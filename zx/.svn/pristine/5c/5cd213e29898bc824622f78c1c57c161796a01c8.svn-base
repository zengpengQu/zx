package com.taiji.frame.controller.pubinfo.contacts;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.model.entity.pubinfo.contacts.AddressTeam;
import com.taiji.frame.model.entity.pubinfo.contacts.CmmListt;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.contacts.AddressTeamVo;
import com.taiji.frame.service.pubinfo.contacts.AddressTeamService;
import com.taiji.frame.service.pubinfo.contacts.ContactsDepService;

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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.util.*;

/**
 * @author sy
 * 通讯录
 */
@Controller
@RequestMapping(value = "/contacts-address")
public class AddressTeamController extends BaseController<AddressTeam> {
    private static final Logger LOG = LoggerFactory.getLogger(AddressTeamController.class);

    @Autowired
    private AddressTeamService addressTeamService;
    @Autowired
    private ContactsDepService contactsDepService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 通讯录的添加页面跳转
     * @param id 当前节点ID
     * @param parentId 当前节点父ID
     * @return
     */
    @RequestMapping(value = "/addressTeam-add.do", method = RequestMethod.POST)
    public String addressTeamAdd(ModelMap modelMap, String id,String parentId) {
        //根据id查询到当前通讯录信息
        if(StringUtils.isNotEmpty(id)) {
            modelMap.put("thisAddressTeam" ,addressTeamService.get(id));
            modelMap.put("parentAddressTeamParentId" ,parentId);
        }
        return "pubinfo/contacts/contacts-addressTeam-edit";
    }

    /**
     * 添加子菜单
     */
    @ResponseBody
    @RequestMapping(value = "/addressTeam-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> addressTeamAddSave(AddressTeamVo addressTeamvo) {
        Map<String, Object> map = new HashMap<>(16);
        AddressTeam addressTeam = new AddressTeam();
        try {
            //根据id获取到当前通讯录信息，并将是否由有子菜单设为 ：1  有
            AddressTeam addressTeam1 = addressTeamService.get(addressTeamvo.getId());
            addressTeam1.setIsLeaf("1");
            addressTeamService.save(addressTeam1);
            BeanUtils.copyProperties(addressTeamvo, addressTeam);
            //新增用户填写的添加信息
            addressTeam.setId("");
            addressTeam.setCreateTime(utilService.getSysTime());
            //新增通讯录，没有设置parentId，没有子菜单
            addressTeam.setIsLeaf("0");
            //设置新增的parentId
            addressTeam.setAddressTeam(addressTeamService.get(addressTeamvo.getId()));
            addressTeamService.save(addressTeam);
            map.put("result", true);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("通讯录分组");
        sysLogVo.setRecordType(0);
        if (null != addressTeam){
            sysLogVo.setEntityId(addressTeam.getId());
            sysLogVo.setEntityName(addressTeam.getTeamName());
        }
        sysLogVo.setResult(map.get("result").toString());
        //记录日志
        sysLogService.record(sysLogVo);
        return map;
    }

    /**
     * 通讯录删除根据ID 如果有子菜单一并删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/addressTeam-delete.do", method = RequestMethod.POST)
    public Map<String, Object> addressTeamDelete(String id) {
        Map<String, Object> map = new HashMap<>(16);
        AddressTeam team = null;
        try {
            if(StringUtils.isNotEmpty(id)){
                team = addressTeamService.get(id);
                //根据自身ID获取到父ID在获取到 父对象 将是否有子节点改为：0 无
                AddressTeam addressTeam = addressTeamService.get(addressTeamService.get(id).getAddressTeam().getId());
                addressTeam.setIsLeaf("0");
                addressTeamService.save(addressTeam);
                //数据库设置了联级删除
                addressTeamService.delete(id);
            }
            map.put("result", true);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("通讯录分组");
        sysLogVo.setRecordType(2);
        if (null != team){
            sysLogVo.setEntityId(team.getId());
            sysLogVo.setEntityName(team.getTeamName());
        }
        sysLogVo.setResult(map.get("result").toString());
        //记录日志
        sysLogService.record(sysLogVo);
        return map;
    }

    /**
     * 修改通讯录名称页面跳转
     */
    @RequestMapping(value = "/addressTeam-up.do", method = RequestMethod.POST)
    public String toAddressTeamUpDate(ModelMap modelMap, String id,String parentId) {
        if(StringUtils.isNotEmpty(id)) {
            modelMap.put("thisAddressTeam" ,addressTeamService.get(id));
            modelMap.put("parentAddressTeamParentId" ,parentId);
        }
        return "pubinfo/contacts/contacts-addressTeam-uoDate";
    }

    /**
     * 通讯录名称修改
     */
    @ResponseBody
    @RequestMapping(value = "/addressTeam-ups.do", method = RequestMethod.POST)
    public Map<String, Object> addressTeamUpDate(AddressTeamVo addressTeamvo) {
        Map<String, Object> map = new HashMap<>(2);
        AddressTeam addressTeam = new AddressTeam();
        try {
            BeanUtils.copyProperties(addressTeamvo, addressTeam);
            addressTeam.setAddressTeam(addressTeamService.get(addressTeamvo.getParentId()));
            addressTeam.setIsLeaf(addressTeamvo.getIsLeaf());
            addressTeamService.save(addressTeam);
            map.put("result", true);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("通讯录分组");
        sysLogVo.setRecordType(1);
        if (null != addressTeam){
            sysLogVo.setEntityId(addressTeam.getId());
            sysLogVo.setEntityName(addressTeam.getTeamName());
        }
        sysLogVo.setResult(map.get("result").toString());
        //记录日志
        sysLogService.record(sysLogVo);
        return map;
    }

    /**
     * 导出
     * @param data 选中行的ID
     * @param type  为part表示有选择的数据，all表示导出所有数据
     * @param deptIdd  点击分组 点击导出时 获得的分组ID
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/addressTeam-preview.do", method = RequestMethod.GET)
    public void findDuties(String data, String type,String deptIdd,String deptName,String locationName,
                             HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            List<CmmListt> contactsDep = new ArrayList<>();
            String fileName = "通讯录详细信息.xls";
            OutputStream os = OtherUtil.getOutputStream(fileName, request, response);
            if("".equals(deptName) && "".equals(locationName)){
                if("0".equals(deptIdd)) {
                    contactsDep = contactsDepts(type,data);
                    AddressTeamExcel.createExce3(os, fileName, contactsDep);
                }else {
                    if("".equals(data)){
                        contactsDep = contactsDepService.loadGetAll("dicDept.id",deptIdd);
                        if(contactsDep.size()>0){
                            AddressTeamExcel.createExce3(os, fileName, contactsDep);
                        }
                    }else {
                        contactsDep = contactsDepts(type, data);
                        AddressTeamExcel.createExce3(os, fileName, contactsDep);
                    }
                }
            }else {
                if(!"".equals(data)) {
                    contactsDep = contactsDepts(type,data);
                    if (contactsDep.size() > 0) {
                        AddressTeamExcel.createExce3(os, fileName, contactsDep);
                    }
                }
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("通讯录");
        sysLogVo.setRecordType(7);
        sysLogVo.setEntityId("");
        sysLogVo.setEntityName("");
        sysLogVo.setResult("true");
        //记录日志
        sysLogService.record(sysLogVo);
    }


    public List<CmmListt> contactsDepts(String type,String data){
        List<CmmListt> contactsDep = new ArrayList<>();
         if ("part".equals(type)) {
            String[] strs = data.split(",");
            for (int i = 0; i < strs.length; i++) {
                String str = strs[i];
                CmmListt cmmListt = contactsDepService.get(str);
                contactsDep.add(cmmListt);
            }
            return contactsDep;
        } else {
            //得到排序后 需要导出的所有数据
            contactsDep = contactsDepService.loadGetAll("addressTeam.id,dicDept.id ",null);
             return contactsDep;
        }
    }

}














