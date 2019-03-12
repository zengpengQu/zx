package com.taiji.frame.controller.pubinfo.contacts;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.contacts.AddressTeam;
import com.taiji.frame.model.entity.pubinfo.contacts.CmmListt;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.contacts.CmmDepListVo;
import com.taiji.frame.service.pubinfo.contacts.AddressTeamService;
import com.taiji.frame.service.pubinfo.contacts.ContactsDepService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author sy
 * 通讯录
 */
@Controller
@RequestMapping(value = "/contacts-dep")
public class ContactsDeptController extends BaseController<CmmListt> {

    private static final Logger LOG = LoggerFactory.getLogger(ContactsDeptController.class);

    @Autowired
    private ContactsDepService contactsDepService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private AddressTeamService addressTeamService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * load grid单位表格数据
     * addressTeamId 通讯录Id
     */
    @ResponseBody
    @RequestMapping(value = "/load-contacts-depList.do", produces = "text/html;charset=UTF-8")
    public String contactsDepListLoad(Carrier<CmmListt> carrier, String deptId,String addressTeamId,String deptName,String location) {

        HashMap map = new HashMap(16);
        try {
            if(StringUtils.isNotEmpty(deptId)){
                map.put("dicId", deptId);
            }

            if("-1".equals(addressTeamId) || "01".equals(addressTeamId)) {
                //等于-1表示当前属于初始化页面 默认加载所以部门通讯录
                //2 表示点击的当前部门提醒分组 跟路径 要查所以
            }else{
                if(StringUtils.isNotEmpty(addressTeamId)){
                    map.put("teamId", addressTeamId);
                }
            }
            if (!StringUtils.isEmpty(deptId)) {
                map.put("deptId", deptId);
            }
            if (!StringUtils.isEmpty(deptName)) {
                map.put("deptName", deptName.replace(" ",""));
            }
            if (!StringUtils.isEmpty(location)) {
                map.put("location", location.replace(" ",""));
            }
            contactsDepService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑通讯信息  页面跳转
     */
    @RequestMapping(value = "/contacts-edit-dept.do", method = RequestMethod.GET)
    public String toSaveContacts(String id,String psId, ModelMap modelMap) {

        if(StringUtils.isNotEmpty(psId)){
            AddressTeam addressTeam = null;
            if("0".equals(psId)){
                // 0 表示修改，根据部门分组ID 查询到通讯录分组ID，在查出通讯录信息
                CmmListt comList1 =  contactsDepService.get(id);
                String r1 = comList1.getAddressTeam().getId();
                addressTeam = addressTeamService.get(r1);
            }else {
                //查询通讯录分组信息
                addressTeam= addressTeamService.get(psId);
            }
            modelMap.put("addressTeam", addressTeam);
        }
        if(StringUtils.isNotEmpty(id)){
            CmmListt comList = contactsDepService.get(id);
            String s = comList.getDicDept().getId();
            modelMap.put("curDept", comList.getDicDept().getJsonObject());
            modelMap.put("deptComList", comList);
        }else {
            DicUser dicUser = getCurUser();
            //用户所在部门
            DicDept curDept = dicUser.getDicDept();
            modelMap.put("curDept", curDept.getJsonObject());
        }
        return "pubinfo/contacts/contacts-dept-edit";
    }

    /**
     * 新增/编辑 部门通讯录
     */
    @ResponseBody
    @RequestMapping(value = "/contacts-edit-dept-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveContacts(CmmDepListVo cmmDepListVo) {

        Map<String, Object> map = new HashMap<>(16);
        CmmListt cmmListt = new CmmListt();
        try {
            BeanUtils.copyProperties(cmmDepListVo, cmmListt);
            //设置部门
            DicDept dicDept = dicDeptService.get(cmmDepListVo.getDicDeptId());
            cmmListt.setDicDept(dicDept);
            AddressTeam addressTeam = addressTeamService.get(cmmDepListVo.getAddressTeamId());
            cmmListt.setAddressTeam(addressTeam);
            //设置删除标志,未删除
            cmmListt.setDelFlag("0");
            contactsDepService.save(cmmListt);
            String teamId = cmmListt.getAddressTeam().getId();
            map.put("result", true);
            map.put("teamId", teamId);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("部门通讯录");
        if (StringUtils.isNotEmpty(cmmDepListVo.getId())){
            sysLogVo.setRecordType(1);
        }else {
            sysLogVo.setRecordType(0);
        }
        if (null != cmmListt){
            sysLogVo.setEntityId(cmmListt.getId());
            sysLogVo.setEntityName(cmmListt.getLocation());
        }
        sysLogVo.setResult(map.get("result").toString());
        sysLogService.record(sysLogVo);
        return map;
    }

    /**
     * 删除通讯录信息
     */
    @ResponseBody
    @RequestMapping(value = "/contacts-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteContacts(String id) {

        Map<String, Object> map = new HashMap<>(16);
        CmmListt cmmListt =null;
        try {
            //根据id查找通讯录信息
            cmmListt = contactsDepService.get(id);
            //删除标志设为1
            cmmListt.setDelFlag("1");
            //保存数据
            contactsDepService.save(cmmListt);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("部门通讯录");
        sysLogVo.setRecordType(2);
        if (null != cmmListt){
            sysLogVo.setEntityId(id);
            sysLogVo.setEntityName(cmmListt.getLocation());
        }
        sysLogVo.setResult(map.get("result").toString());
        sysLogService.record(sysLogVo);
        return map;
    }

}
