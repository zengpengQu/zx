package com.taiji.frame.controller.pubinfo.contacts;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.contacts.CmmList;
import com.taiji.frame.model.entity.pubinfo.contacts.AddressTeam;
import com.taiji.frame.model.entity.pubinfo.contacts.CmmListt;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.contacts.CmmPerListVo;
import com.taiji.frame.service.pubinfo.contacts.ContactsDepService;
import com.taiji.frame.service.pubinfo.contacts.ContactsUserService;
import com.taiji.frame.service.pubinfo.contacts.AddressTeamService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * @author sy
 * 通讯录
 */
@Controller
@RequestMapping(value = "/contacts")
public class ContactsUserController extends BaseController<CmmList> {

    private static final Logger LOG = LoggerFactory.getLogger(ContactsUserController.class);

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private ContactsUserService contactsUserService;
    @Autowired
    private ContactsDepService contactsDepService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private AddressTeamService addressTeamService;

    @Autowired
    private SysLogService sysLogService;

    /**
     *  通讯录主页面跳转
     */
    @RequestMapping(value = "/contacts-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {
        //当前用户
        DicUser dicUser = getCurUser();
        //用户所在部门
        DicDept curDept = dicUser.getDicDept();
        map.put("curDept", curDept.getJsonObject());
        List<AddressTeam> addressList = addressTeamService.getAll();
        map.put("addressList", addressList);
        return "pubinfo/contacts/contacts-list";

    }

    /**
     * load grid 用户表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-contacts-list.do",produces = "text/html;charset=UTF-8" )
    public String  contactsListLoad(Carrier<CmmList> carrier,String id) {
        HashMap map = new HashMap(1);
        try {
            if(StringUtils.isNotEmpty(id)){
                map.put("id",id);
            }
            contactsUserService.load(carrier,map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }
    /**
     * load grid 用户表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-contacts-one.do",method = RequestMethod.POST )
    public String  contactsOneLoad(Carrier<CmmList> carrier,String id,String deptName,String location,String name) {
        HashMap map = new HashMap(16);
        try {
            if(StringUtils.isNotEmpty(id)){
                map.put("userId",id);
            }
            if(StringUtils.isNotEmpty(deptName)){
                map.put("deptName",deptName);
            }
            if(StringUtils.isNotEmpty(location)){
                map.put("location",location);
            }
            if(StringUtils.isNotEmpty(name)){
                map.put("name",name);
            }
            contactsUserService.load(carrier,map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑 用户通讯信息 页面跳转
     */
    @RequestMapping(value = "/contacts-edit-user.do", method = RequestMethod.GET)
    public String toSaveContacts(String id,String psId, ModelMap modelMap ) {
        //部门名称
        //根据分组ID获得分组信息
        if(StringUtils.isNotEmpty(psId)){
            CmmListt comListt = null;
            if("0".equals(psId)){
                //psId为0表示  修改用户信息
                //根据id得到用户数据 取parentId
                CmmList comList1 =  contactsUserService.get(id);
                String comListtId = comList1.getCmmListDepts().getId();
                comListt = contactsDepService.get(comListtId);
            }else {
                comListt = contactsDepService.get(psId);
            }
            //得到部门信息
            modelMap.put("comListt", comListt);
        }
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.put("sysDate", sysDate);
        //根据用户ID进行数据回显
        if(StringUtils.isNotEmpty(id)){
            CmmList comList = contactsUserService.get(id);
            modelMap.addAttribute("userComList", comList);
        }
        return "pubinfo/contacts/contacts-user-edit";
    }

    /**
     * 新增/编辑  用户通讯录信息
     */
    @ResponseBody
    @RequestMapping(value = "/contacts-edit-user-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveContacts(CmmPerListVo cmmPerListVo) {
        Map<String, Object> map = new HashMap<>(16);
        CmmList cmmList = new CmmList();
        try {
            BeanUtils.copyProperties(cmmPerListVo, cmmList);
            //设置部门
            DicDept dicDept = dicDeptService.get(cmmPerListVo.getDicDeptId());
            cmmList.setDicDept(dicDept);
            //设置操作人
            DicUser dicUser = getCurUser();
            cmmList.setDicUser(dicUser);
            //设置出生日期
            // Date birthDate = DateUtil.stringToDate(cmmPerListVo.getBirthDateStr(), DateUtil.FORMAT_DAY);
            // cmmList.setBirthDate(birthDate);

            //设置创建时间
            cmmList.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN));
            //设置删除标志,未删除
            cmmList.setDelFlag("0");
            CmmListt cmmListt = contactsDepService.get(cmmPerListVo.getComListtId());
            cmmList.setCmmListDepts(cmmListt);
            contactsUserService.save(cmmList);
            map.put("result", true);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("用户通讯录");
        if (StringUtils.isNotEmpty(cmmPerListVo.getId())){
            sysLogVo.setRecordType(1);
        }else {
            sysLogVo.setRecordType(0);
        }
        if (null != cmmList){
            sysLogVo.setEntityId(cmmList.getId());
            sysLogVo.setEntityName(cmmList.getLocation());
        }
        sysLogVo.setResult(map.get("result").toString());
        sysLogService.record(sysLogVo);
        return map;
    }

    /**
     * 删除通讯录
     */
    @ResponseBody
    @RequestMapping(value = "/contacts-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteContacts(String id) {
        Map<String, Object> map = new HashMap<>(16);
        CmmList cmmList = null;
        try {
            //根据id查找通讯录信息
            cmmList = contactsUserService.get(id);
            //删除标志设为1
            cmmList.setDelFlag("1");
            //保存数据
            contactsUserService.save(cmmList);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("用户通讯录");
        sysLogVo.setRecordType(2);
        if (null != cmmList){
            sysLogVo.setEntityId(id);
            sysLogVo.setEntityName(cmmList.getName());
        }
        sysLogVo.setResult(map.get("result").toString());
        sysLogService.record(sysLogVo);
        return map;
    }

}
