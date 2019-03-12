package com.taiji.frame.controller.systempara;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.ListSortUtil;
import com.taiji.frame.model.systempara.*;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.systempara.DicParaDtlService;
import com.taiji.frame.service.systempara.SecPopedomViewService;
import com.taiji.frame.service.systempara.SecRoleService;
import com.taiji.frame.service.systempara.SysLogService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by CHX on 2016/4/11.
 */
@Controller
@RequestMapping("/role")
public class SecRoleController extends BaseController<SecRole> {

    private static final Logger LOG = LoggerFactory.getLogger(SecRoleController.class);

    @Autowired
    private SecRoleService secRoleService;

    @Autowired
    private SecPopedomViewService secPopedomViewService;

    @Autowired
    private DicParaDtlService dicParaDtlService;

    @Autowired
    private SysLogService sysLogService;

    @RequestMapping(value = "/load.do",produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String load(Carrier carrier, String orgId,String roleName) {
        Map<String,Object> map = new HashMap<>();
        try {
            if (null != roleName && !"".equals(roleName)) {
                map.put("roleName", "%"+roleName+"%");
            }
            secRoleService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 跳转到角色信息管理页面
     * @param map
     * @return
     */
    @RequestMapping(value = "/list.do", method = RequestMethod.GET)
    public String list(Map<String,Object> map){
        DicUser user = getCurUser();
        DicDept dicDept = user.getDicDept();

        return "systempara/role-info";
    }

    /**
     * 激活角色
     * @param id
     * @return
     */
    @RequestMapping(value = "/isActive.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> isActive(String id){
        SecRole role = secRoleService.get(id);
        Map<String ,Object> map = new HashMap<>();
        if(role.getIsactive() == 1){
            role.setIsactive(0);
        }else{
            role.setIsactive(1);
        }
        secRoleService.save(role);
        map.put("result",true);
        //日志信息保存
        try {
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setRecordType(5);
            if (role.getIsactive() == 1) {
                sysLogVo.setTypeName("激活");
            }else {
                sysLogVo.setTypeName("禁用");
            }
            if (null != role){
                sysLogVo.setEntityId(role.getId());
                sysLogVo.setEntityName(role.getRoleName());
            }
            sysLogVo.setResult(map.get("result").toString());
            //记录日志
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            LOG.debug(e.getMessage(),e);
        }
        return map;
    }



    /**
     * 跳转到资源信息管理页面
     * @param map
     * @return
     */
    @RequestMapping(value = "/paraList.do", method = RequestMethod.GET)
    public String paraList(Map<String,Object> map){
        List<DicParaDtl> dicParaDtlList = dicParaDtlService.getDicParaDtlByParaType("GRADE");
        map.put("dicParaDtlList", dicParaDtlList);
        return "systempara/role-view";
    }

    @RequestMapping(value = "/getRoleViewByOrgId.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> getRoleViewByOrgId(String roleId){
        Map<String ,Object> map = new HashMap<>();
        try{

            List<SecPopedomView> secPopedomViewList = secPopedomViewService.getAll();
            //排序
            new ListSortUtil<SecPopedomView>().mySort(secPopedomViewList,"position","asc");

            JSONArray jsonArray;
            List<String> viewIds = new ArrayList<>();
            if(null != roleId && !"".equals(roleId)){
                //编辑
                SecRole secRole = secRoleService.get(roleId);
                List<SecPopedomView> secRoleViewList = secRole.getSecPopedomViewList();
                for(SecPopedomView secPopedomView:secRoleViewList){
                    viewIds.add(secPopedomView.getId());
                }
                jsonArray = combinationView(secPopedomViewList, viewIds, true);
            }else{
                jsonArray = combinationView(secPopedomViewList, viewIds, false);
            }
            map.put("viewIds",jsonArray);
            map.put("result",true);
        }catch(Exception e){
            LOG.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 获取各个角色权限
     * @param id
     * @return
     */
    @RequestMapping(value = "/getRoleView.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> getRoleView(String id){
        Map<String ,Object> map = new HashMap<>();
        try{
            DicParaDtl dicParaDtl = dicParaDtlService.get(id);
            List<String> viewIds = new ArrayList<>();

            List<SecPopedomView> secPopedomViewList = secPopedomViewService.getAll("position", true);
            JSONArray jsonArray = combinationView(secPopedomViewList,viewIds,true);
            map.put("viewIds",jsonArray);
            map.put("result",true);
        }catch(Exception e){
            LOG.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 组装菜单权限数据
     * @param secPopedomViewList

     * @return
     */
    public JSONArray combinationView(List<SecPopedomView> secPopedomViewList,List<String> viewIds,Boolean flag){
        JSONArray jsonArray =new JSONArray();

        for(SecPopedomView secPopedomView :secPopedomViewList){

            JSONObject jsonObject = new JSONObject();
            String id = secPopedomView.getId();
            String pId = secPopedomView.getParentId();
            jsonObject.put("id",id);
            if(flag){
                for(String string :viewIds){
                    if(id.equals(string)){
                        jsonObject.put("checked",true);
                    }
                }
            }
            jsonObject.put("pId",secPopedomView.getParentId());
            jsonObject.put("name", secPopedomView.getName());
            if(id.equals("-1")||pId.equals("-1")){
                jsonObject.put("open", true);
            }
            jsonArray.add(jsonObject);

        }
        return jsonArray;
    }

    /**
     * 保存资源权限
     * @param array
     * @return
     */
    @RequestMapping(value = "/saveView.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveView( @RequestParam("array[]")String[] array,String id){
        Map<String ,Object> map = new HashMap<>();
        try{
            DicParaDtl dicParaDtl = dicParaDtlService.get(id);

            dicParaDtlService.save(dicParaDtl);
            secRoleService.deleteRoleWithUser(id);
            map.put("result",true);
        }catch(Exception e){
            LOG.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    @RequestMapping(value = "/saveRoleView.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> saveRoleView( @RequestParam("array[]")String[] array,String roleName,String dscr,String roleId){
        Map<String ,Object> map = new HashMap<>();
        SecRole secRole = null;
        try{
            List<SecPopedomView> secPopedomViewList = new ArrayList<>();
            for(String string:array){
                SecPopedomView secPopedomView = secPopedomViewService.get(string);
                secPopedomViewList.add(secPopedomView);
            }
            if(StringUtils.isEmpty(roleId)){
                secRole = new SecRole();
                secRole.setIsactive(1);
            }else {
                secRole = secRoleService.get(roleId);
            }
            secRole.setUpdDate(getCurDate());
            secRole.setUpdEmp(getCurUser().getEmpName());
            secRole.setRoleName(roleName);
            secRole.setRoleDesc(dscr);
            secRole.setSecPopedomViewList(secPopedomViewList);
            secRoleService.save(secRole);
            map.put("result",true);
        }catch(Exception e){
            LOG.debug(e.getMessage(),e);
            map.put("result",false);
        }
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("角色");
        if(StringUtils.isEmpty(roleId)){
            sysLogVo.setRecordType(0);
        }else {
            sysLogVo.setRecordType(1);
        }
        if (null != secRole){
            sysLogVo.setEntityId(secRole.getId());
            sysLogVo.setEntityName(secRole.getRoleName());
        }
        sysLogVo.setResult(map.get("result").toString());
        //记录日志
        sysLogService.record(sysLogVo);
        return map;
    }

    /**
     * 简单字段重复校验
     * @param checkValue
     * @param checkKey
     * @param id
     * @return
     */
    @Override
    @RequestMapping(value = "/checkSecRole.do", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String checkUnique(String checkValue,String checkKey,String id) {
        String flag;
        try {
            Map<String,Object> param = new HashMap<>();
            StringBuffer hql = new StringBuffer("from SecRole where "+checkKey+"=:checkValue");
            param.put("checkValue", checkValue);
            if(!StringUtils.isEmpty(id)){
                hql.append(" and id !=:id");
                param.put("id",id);
            }

            List<SecRole> list = secRoleService.find(hql.toString(), param);
            if (list.size() != 0) {
                flag = "false";
            } else {
                flag = "true";
            }

        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            flag = "false";
        }
        return flag;
    }

}
