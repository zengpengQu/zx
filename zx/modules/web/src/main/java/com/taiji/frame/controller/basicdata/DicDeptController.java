package com.taiji.frame.controller.basicdata;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.StringUtil;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.Tree;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.batch.DicDeptVo;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 *
 * @author user
 * @date 2016/4/22
 */
@Controller
@RequestMapping(value = "/dept")
public class DicDeptController extends BaseController<DicDept> {
    private static final Logger LOG = LoggerFactory.getLogger(DicDeptController.class);

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 十进制的Z的值
     */
    public static final Integer DECIMAL_SYSTEM_Z = 35;

    /**
     * 跳转到部门管理页面
     *
     * @param map
     * @return
     */
    @RequestMapping(value = "/dept-list", method = RequestMethod.GET)
    public String loads(Map<String, Object> map) {
        String id = "01";
        DicDept dicDept = dicDeptService.get(id);
        String property = dicDept.getProperty();
        String category = dicDept.getCategory();
        if (StringUtils.isNotEmpty(property)) {
            DicParam dicParam = dicParamService.get(property);
            map.put("property", dicParam.getName());
        } else {
            map.put("property", null);
        }
        if (StringUtils.isNotEmpty(category)) {
            DicParam Param = dicParamService.get(category);
            map.put("category", Param.getName());
        } else {
            map.put("category", null);
        }

        JSONArray array = getOrgList();
        map.put("array", array);
        map.put("dicDept", dicDept);
        return "/systempara/dept-list";
    }

    /**
     * 详情---查看某个部门信息
     *
     * @param deptCode
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/dept-view", method = RequestMethod.POST)
    public Map<String, Object> details(String deptCode) {

        HashMap<String, Object> map = new HashMap<>(3);
        try {
            DicDept dicDept = dicDeptService.getDeptByDeptCode(deptCode);
            String property = dicDept.getProperty();
            String category = dicDept.getCategory();
            if (StringUtils.isNotEmpty(property)) {
                DicParam dicParam = dicParamService.get(property);
                map.put("property", dicParam.getName());
            } else {
                map.put("property", null);
            }
            if (StringUtils.isNotEmpty(category)) {
                DicParam Param = dicParamService.get(category);
                map.put("category", Param.getName());
            } else {
                map.put("category", null);
            }
            //把对象转JSON
            JSON jsonObject = dicDept.getJsonObject();
            map.put("dicDept", jsonObject);
            map.put("result", true);
        } catch (Exception e) {
            map.put("result", false);
            LOG.debug(e.getMessage(), e);
        }
        return map;
    }

    /**
     * 跳转到添加部门页面
     *
     * @param modelMap
     * @param deptCode 树ID
     * @return
     */
    @RequestMapping(value = "/to-dept-edit.do", method = RequestMethod.POST)
    public String toEdit(ModelMap modelMap, String deptCode) {
        if (StringUtils.isNotEmpty(deptCode)) {
            DicDept dicDept = dicDeptService.getDeptByDeptCode(deptCode);
            modelMap.addAttribute("dicDept", dicDept);
        }
        //单位类别
        List<DicParam> paramList = dicParamService.getParamByGroupId(24);
        //单位性质
        List<DicParam> list = dicParamService.getParamByGroupId(25);
        modelMap.addAttribute("paramList", paramList);
        modelMap.addAttribute("list", list);
        return "/systempara/dept-add";
    }

    /**
     * 添加部门的菜单
     *
     * @param dicDeptVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/dept-save.do", method = RequestMethod.POST)
    public Map<String, Object> addDepartment(DicDeptVo dicDeptVo) {
        Map<String, Object> map = new HashMap<String, Object>(4);
        DicDept dept = null;
        try {
            //添加新的节点
            dept = new DicDept();
            String deptCode_ = dicDeptVo.getDeptCode();
            //部门名称检索
            Map absNameMap = dicDeptService.getDeptNamePath(deptCode_);
            String absName = absNameMap.get("REPLACE") + "/" + dicDeptVo.getDeptName();
            dept.setAbsName(absName);

            dept.setParentCode(deptCode_);
            //设置treeID
            String deptCode = getTreeId(deptCode_);
            dept.setDeptCode(deptCode);
            //部门ID检索
            Map absCodeMap = dicDeptService.getDeptIdPath(deptCode_);
            String absCode = absCodeMap.get("absCode") + "/" + deptCode;
            dept.setAbsCode(absCode);
            //设置seq
            DicDept maxSeqDept = dicDeptService.getMaxSeqDept();
            Float seq = maxSeqDept.getSeq() + 1;
            dept.setSeq(seq);

            DicDept dicDept = dicDeptService.getDeptByDeptCode(deptCode_);
            Long deptLevel = dicDept.getDeptLevel();
            dept.setDeptLevel(deptLevel + 1);
            dept.setStatus(1);

            this.setData(dicDeptVo, dept);
            dicDeptService.save(dept);

            String property = dept.getProperty();
            String category = dept.getCategory();
            if (StringUtils.isNotEmpty(property)) {
                DicParam dicParam = dicParamService.get(property);
                map.put("property", dicParam.getName());
            } else {
                map.put("property", null);
            }
            if (StringUtils.isNotEmpty(category)) {
                DicParam Param = dicParamService.get(category);
                map.put("category", Param.getName());
            } else {
                map.put("category", null);
            }
            JSONArray jsonArray = getOrgList();
            map.put("dicDept", dept);
            map.put("jsonArray", jsonArray);
            map.put("code", deptCode_);
            map.put("result", true);
        } catch (Exception e) {
            map.put("result", false);
            LOG.debug(e.getMessage(), e);
        }
        //日志信息保存
        try {
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("部门");
            sysLogVo.setRecordType(0);
            if (null != dept) {
                sysLogVo.setEntityId(dept.getId());
                sysLogVo.setEntityName(dept.getDeptName());
            }
            sysLogVo.setResult(map.get("result").toString());
            //记录日志
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return map;
    }

    private void setData(DicDeptVo dicDeptVo, DicDept dept) {
        //treeId
        String deptCode_ = dicDeptVo.getDeptCode();
        String deptName = dicDeptVo.getDeptName();
        dept.setDeptName(deptName);
        String deptDscr = dicDeptVo.getDeptDscr();
        dept.setDeptDscr(deptDscr);
        DicUser curUser = getCurUser();
        dept.setUpdEmp(curUser.getEmpName());
        dept.setUpdDate(utilService.getSysTime());

        String postalCode = dicDeptVo.getPostalCode();
        dept.setPostalCode(postalCode);
        String tel = dicDeptVo.getTel();
        dept.setTel(tel);
        String ownership = dicDeptVo.getOwnership();
        dept.setOwnership(ownership);
        String property = dicDeptVo.getProperty();
        dept.setProperty(property);
        String category = dicDeptVo.getCategory();
        dept.setCategory(category);
        String address = dicDeptVo.getAddress();
        dept.setAddress(address);
        String authType = dicDeptVo.getAuthType();
        dept.setAuthType(authType);
    }

    /**
     * 跳转-修改部门名-页面
     *
     * @param deptCode
     * @return
     */
    @RequestMapping(value = "/to-dept-update.do", method = RequestMethod.POST)
    public String toUpdateDepartment(ModelMap modelMap, String deptCode) {
        if (StringUtils.isNotEmpty(deptCode)) {
            DicDept dicDept = dicDeptService.getDeptByDeptCode(deptCode);
            modelMap.put("dicDept", dicDept);
        }
        //单位类别
        List<DicParam> paramList = dicParamService.getParamByGroupId(24);
        //单位性质
        List<DicParam> list = dicParamService.getParamByGroupId(25);
        modelMap.addAttribute("paramList", paramList);
        modelMap.addAttribute("list", list);
        return "/systempara/dept-edit";
    }

    /**
     * 修改某个部门名
     *
     * @param dicDeptVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/dept-update.do", method = RequestMethod.POST)
    public Map<String, Object> updateDepartment(DicDeptVo dicDeptVo) {
        Map<String, Object> map = new HashMap<String, Object>(4);
        DicDept dicDept = null;
        try {
            String deptCode = dicDeptVo.getDeptCode();
            dicDept = dicDeptService.getDeptByDeptCode(deptCode);

            this.setData(dicDeptVo, dicDept);
            dicDeptService.save(dicDept);

            String property = dicDept.getProperty();
            String category = dicDept.getCategory();
            if (StringUtils.isNotEmpty(property)) {
                DicParam dicParam = dicParamService.get(property);
                map.put("property", dicParam.getName());
            } else {
                map.put("property", null);
            }
            if (StringUtils.isNotEmpty(category)) {
                DicParam Param = dicParamService.get(category);
                map.put("category", Param.getName());
            } else {
                map.put("category", null);
            }

            JSONArray jsonArray = getOrgList();
            map.put("dicDept", dicDept.getJsonObject());
            map.put("jsonArray", jsonArray);
            map.put("editCode", dicDept.getParentCode());
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        //日志信息保存
        try {
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("部门");
            sysLogVo.setRecordType(1);
            if (null != dicDept) {
                sysLogVo.setEntityId(dicDept.getId());
                sysLogVo.setEntityName(dicDept.getDeptName());
            }
            sysLogVo.setResult(map.get("result").toString());
            //记录日志
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return map;
    }

    /**
     * 更新部门seq
     * */
    @ResponseBody
    @RequestMapping(value = "/update-seq.do", method = RequestMethod.POST)
    public Map<String,Object> updateSeq(Float seq,String id) {


        Map<String, Object> map = new HashMap<>(9);

        //根据ID找到当前部门
        try {
            DicDept dicDept = dicDeptService.getDeptByDeptCode(id);
            if (dicDept != null) {
                dicDept.setSeq(seq);
                dicDeptService.save(dicDept);
                map.put("result",true);
            }
        } catch (Exception e) {
            LOG.error("更新部门seq失败");
            map.put("result",false);
        }
        return map;
    }

    /**
     * 删除某个部门，若有子部门也删除掉
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/dept-delete.do", method = RequestMethod.POST)
    public Map<String, Object> delDepartment(String id) {
        Map<String, Object> map = new HashMap<String, Object>(9);
        String deptCode = id;
        DicDept dicDept = null;
        try {
            if (StringUtils.isNotEmpty(deptCode)) {
                //当前节点信息
                dicDept = dicDeptService.getDeptByDeptCode(deptCode);
                String delCode = null;
                //删除子节点
                getDeptByParentCode(deptCode);
                dicDept.setStatus(0);
                //父节点
                String parentCode = dicDept.getParentCode();

                DicDept dept = dicDeptService.getDeptByDeptCode(parentCode);
                dicDeptService.save(dicDept);

                String property = dept.getProperty();
                String category = dept.getCategory();
                if (StringUtils.isNotEmpty(property)) {
                    DicParam dicParam = dicParamService.get(property);
                    map.put("property", dicParam.getName());
                } else {
                    map.put("property", null);
                }
                if (StringUtils.isNotEmpty(category)) {
                    DicParam Param = dicParamService.get(category);
                    map.put("category", Param.getName());
                } else {
                    map.put("category", null);
                }
                JSONArray jsonArray = getOrgList();
                map.put("dicDept", dept.getJsonObject());
                map.put("jsonArray", jsonArray);
            }
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        //日志信息保存
        try {
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("部门");
            sysLogVo.setRecordType(2);
            if (null != dicDept) {
                sysLogVo.setEntityId(dicDept.getId());
                sysLogVo.setEntityName(dicDept.getDeptName());
            }
            sysLogVo.setResult(map.get("result").toString());
            //记录日志
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return map;
    }

    //删除子节点
    public void getDeptByParentCode(String deptCode) {
        //根据parentId数据
        List<DicDept> deptList = dicDeptService.getDeptByParentCode(deptCode);
        if (null != deptList && deptList.size() > 0) {
            for (DicDept dicDept : deptList) {
                String deptCode_ = dicDept.getDeptCode();
                dicDept.setStatus(0);
                dicDeptService.save(dicDept);
                getDeptByParentCode(deptCode_);
            }
        }
    }

    /**
     * 获取TreeId
     */
    private String getTreeId(String id) {
        //获取当前节点的所有子节点
        List<DicDept> deptList = dicDeptService.getDeptByParentCode(id);
        List<String> list = new ArrayList<String>();
        String treeId = null;
        if (null != deptList && deptList.size() > 0) {
            String prefixStr = StringUtil.prefixStr(deptList.get(0).getDeptCode());
            for (DicDept dicDept : deptList) {
                String deptId = dicDept.getDeptCode();
                String subffixStr = StringUtil.subffixStr(deptId);
                list.add(subffixStr);
            }
            String[] str = list.toArray(new String[list.size()]);
            //获取最大的字符串
            String maxString = StringUtil.getMaxString(str);
            //把字符串转换为十进制
            int hexStringToAlgorism = StringUtil.hexStringToAlgorism(maxString);
            if (hexStringToAlgorism < DECIMAL_SYSTEM_Z) {
                hexStringToAlgorism = hexStringToAlgorism + 1;
            }
            //把十进制转换为十六进制
            String string = StringUtil.algorismToHEXString(hexStringToAlgorism);
            String lastStr = StringUtil.subffixStr(string);
            treeId = prefixStr + lastStr;
        } else {
            treeId = id + "01";
        }
        return treeId;
    }

    /**
     * 根据id查找是否有子部门
     * */
    @ResponseBody
    @RequestMapping(value = "/has-child-dept.do",method = RequestMethod.POST)
    public Map<String,Object> hasChildDept(String deptCode) {

        Map<String,Object> result = new HashMap<>(1);

        List<DicDept> deptList = dicDeptService.getDeptByParentCode(deptCode);

        if (null != deptList && deptList.size() > 0) {
            result.put("result",true);
        } else {
            result.put("result",false);
        }
        return result;
    }

    /****************************************************************************************************/

    //加载grid数据
//    @RequestMapping(value = "/load.do",produces = "text/html;charset=UTF-8")
//    @ResponseBody
//    public String load(Carrier<DicDept> carrier,String orgId){
//        try {
//            dicDeptService.loadDept(carrier, orgId);
//        } catch (Exception e) {
//            LOG.error(e.getMessage(), e);
//        }
//        return gridResult(carrier);
//    }

    //新增部门
//    @RequestMapping(value="/save.do",method = RequestMethod.POST)
//    @ResponseBody
//    public Map save(DicDept dicDept,String orgId){
//        Map<String,Object> map =new HashMap<String,Object>();
//        try{
//            dicDept.setUpdDate(getCurDate());
//            dicDept.setUpdEmp(getCurUser().getEmpName());
//            dicDept.setStatus("0");
//            dicDeptService.save(dicDept);
//            map.put("result", true);
//        }catch(Exception e){
//            LOG.debug(e.getMessage(),e);
//            map.put("result", false);
//        }
//        return map;
//    }

    //加载数据
//    @RequestMapping(value="loadEditdept.do",method = RequestMethod.POST)
//    @ResponseBody
//    public Map loadEditdept(String id){
//        Map<String,Object> map = new HashMap<String, Object>();
//        try{
//            DicDept dicDept = dicDeptService.get(id);
//            map.put("dicDept", dicDept.getJsonObject());
//            map.put("result", true);
//        }catch (Exception e){
//            LOG.debug(e.getMessage(), e);
//            map.put("result", false);
//        }
//        return map;
//    }

    //删除部门
//    @RequestMapping(value = "/deleteDept.do",method = RequestMethod.POST)
//    @ResponseBody
//    public Map deleteDept(String id){
//        Map<String,Object> map = new HashMap<String, Object>();
//        try{
//            Date deleteDate = getCurDate();
//            String userName = getCurUser().getEmpName();
//            dicDeptService.deleteDept(id, deleteDate, userName);
//            map.put("result", true);
//        }catch (Exception e){
//            LOG.debug(e.getMessage(), e);
//            map.put("result", false);
//        }
//        return map;
//    }

//    @RequestMapping(value = "/isIncludeUser.do",method = RequestMethod.POST)
//    @ResponseBody
//    public Map isIncludeUser(String id){
//        Map<String,Object> map = new HashMap<String, Object>();
//        try{
//            int num = dicUserService.findByDept(id).size();
//            if(num!=0){
//                map.put("result", true);
//            }else{
//                map.put("result", false);
//            }
//        }catch (Exception e){
//            LOG.debug(e.getMessage(), e);
//            map.put("result", false);
//        }
//        return map;
//    }

    /**
     * 简单字段重复校验
     * @param checkValue
     * @param checkKey
     * @param id
     * @return
     */
//    @RequestMapping(value = "/checkDeptUnique.do", method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
//    @ResponseBody
//    public String checkDeptUnique(String checkValue,String checkKey,String id,String orgId) {
//        String flag;
//        try {
//            Map<String,Object> param = new HashMap<>();
//            StringBuffer hql = new StringBuffer("from DicDept where "+checkKey+"=:checkValue");
//            param.put("checkValue", checkValue);
//            if(!StringUtils.isEmpty(id)){
//                hql.append(" and id !=:id");
//                param.put("id",id);
//            }
//            hql.append(" and status=0");
//
//            if(!StringUtils.isEmpty(orgId)){
//                hql.append(" and dicOrganization.id=:orgId");
//                param.put("orgId",orgId);
//            }
//            List<DicDept> list = dicDeptService.find(hql.toString(), param);
//            if (list.size() != 0) {
//                flag = "false";
//            } else {
//                flag = "true";
//            }
//
//        } catch (Exception e) {
//            LOG.debug(e.getMessage(), e);
//            flag = "false";
//        }
//        return flag;
//    }
}
