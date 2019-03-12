package com.taiji.frame.controller.systempara;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.MD5Util;
import com.taiji.frame.model.systempara.*;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.UserVo;
import com.taiji.frame.service.systempara.*;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by CHX on 2016/4/7.
 */
@Controller
@RequestMapping(value = "/user")
public class DicUserController extends BaseController<DicUser> {

    private static final Logger               LOG = LoggerFactory.getLogger(DicUserController.class);

    @Autowired
    private              DicUserService       dicUserService;
    @Autowired
    private              DicDeptService       dicDeptService;
    @Autowired
    private              SecRoleService       secRoleService;
    @Autowired
    private              DicParamService      dicParamService;
    @Autowired
    private              DicNationalityService dicNationalityService;

    @Autowired
    private              SysLogService        sysLogService;

    @RequestMapping(value = "/load.do", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String load(Carrier carrier, String searchDeptId, String empName, String searchUserId, String rankId) {
        Map<String, Object> map = new HashMap<>();
        try {

            if (null != empName && !"".equals(empName)) {
                map.put("empName", "%" + empName + "%");
            }
            if (null != searchUserId && !"".equals(searchUserId)) {
                map.put("searchUserId", "%" + searchUserId + "%");
            }

            if (null != rankId && !"".equals(rankId)) {
                map.put("rankId",rankId);
            }

            if (!StringUtils.isEmpty(searchDeptId)) {

                List<DicDept> deptList = dicDeptService.getBelongDept(searchDeptId);
                List<String> stringList = new ArrayList<>();
                if (deptList.size() > 0) {
                    for (DicDept dicDept : deptList) {
                        stringList.add(dicDept.getId());
                    }
                }
                map.put("stringList", stringList);
            }
            dicUserService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 跳转到用户信息管理页面
     *
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/list.do", method = RequestMethod.GET)
    public String list(ModelMap modelMap) {
        //当前用户所在部门
        DicUser user = getCurUser();
        DicDept curDept = user.getDicDept();
        List<DicParam> dicParamList = dicParamService.getParamByGroupId(3);
        //查询民族列表
        List<DicNationality> nationalityList = dicNationalityService.getAll();
        modelMap.addAttribute("nationalityList", nationalityList);
        modelMap.addAttribute("dicParamList", dicParamList);
        modelMap.addAttribute("curDept", curDept);
        return "systempara/user-info";
    }

    /**
     * 获取roleList
     *
     * @return
     */
    @RequestMapping(value = "/getRoleList.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getRoleList() {
        Map<String, Object> map = new HashMap<>();
        try {
            List<SecRole> secRoleList = secRoleService.getAllByIsactive(1);
            JSONArray     jsonArray   = new JSONArray();
            for (SecRole secRole : secRoleList) {
                jsonArray.add(secRole.getJsonObject());
            }
            map.put("result", true);
            map.put("secRoleList", jsonArray);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    /**
     * 用户编辑
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/loadEditUser.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> loadEditUser(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            DicUser       user        = dicUserService.get(id);
            List<SecRole> secRoleList = user.getRoleList();
            JSONArray     jsonArray   = new JSONArray();
            for (SecRole secRole : secRoleList) {
                jsonArray.add(secRole.getJsonObject());
            }
            DicDept curDept = user.getDicDept();
            if (curDept != null) {
                map.put("curDept", curDept.getJsonObject());
            } else {
                map.put("curDept", "");
            }
            map.put("user", user.getJsonObject());
            map.put("secRoleList", jsonArray);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 保存用户
     *
     * @param userVo
     * @return
     */
    @RequestMapping(value = "/saveUser.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> saveUser(UserVo userVo) {
        Map<String, Object> map = new HashMap<>();
        DicUser user = null;
        try {
            userVo.setCreateDate(getCurDate());
            userVo.setUpdEmp(getCurUser().getEmpName());
            userVo.setUpdDate(getCurDate());
            user = dicUserService.saveUser(userVo);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        //日志信息保存
        try {
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("用户");
            if (StringUtils.isNotEmpty(userVo.getId())){
                sysLogVo.setRecordType(1);
            }else {
                sysLogVo.setRecordType(0);
            }
            if (null != user){
                sysLogVo.setEntityId(user.getId());
                sysLogVo.setEntityName(user.getEmpName());
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
     * 查看用户详细信息
     *
     * @param map
     * @param id
     * @return
     */
    @RequestMapping(value = "/detail.do", method = RequestMethod.GET)
    public String detail(Map<String, Object> map, String id) {
        DicUser user = dicUserService.get(id);
        map.put("user", user);
        return "systempara/user-detail";
    }

    /**
     * 激活
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/isActive.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> isActive(String id) {
        DicUser             user = dicUserService.get(id);
        Map<String, Object> map  = new HashMap<>();
        if (user.getIsactive() == 1) {
            user.setIsactive(0);
        } else {
            user.setIsactive(1);
        }
        dicUserService.save(user);
        map.put("result", true);

        //日志信息保存
        try {
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setRecordType(5);
            if (user.getIsactive() == 1) {
                sysLogVo.setTypeName("激活");
            }else {
                sysLogVo.setTypeName("禁用");
            }
            if (null != user){
                sysLogVo.setEntityId(user.getId());
                sysLogVo.setEntityName(user.getEmpName());
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
     * 重置密码
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/rePassword.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> rePassword(String id) {
        DicUser             user     = dicUserService.get(id);
        Map<String, Object> map      = new HashMap<>();
        String              password = MD5Util.MD5("123456");
        user.setPassword(password);
        dicUserService.save(user);
        map.put("result", true);
        //日志信息保存
        try {
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("重置密码");
            sysLogVo.setRecordType(4);
            if (null != user){
                sysLogVo.setEntityId(user.getId());
                sysLogVo.setEntityName(user.getEmpName());
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
     * 解析webService返回xml，判断返回result结果，0为正确
     *
     * @param strXml
     * @return
     * @throws IOException
     */
    public static String getXml(String strXml) throws IOException {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        DocumentBuilder        db  = null;
        try {
            db = dbf.newDocumentBuilder();
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        }

        StringReader sr       = new StringReader(strXml);
        InputSource  is       = new InputSource(sr);
        Document     document = null;
        try {
            document = db.parse(is);
        } catch (SAXException e) {
            e.printStackTrace();
        }
        Element  root   = document.getDocumentElement();
        NodeList nodes  = root.getChildNodes();
        String   result = "";
        if (nodes != null) {
            for (int i = 0; i < nodes.getLength(); i++) {
                Node node = nodes.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    if (node.getNodeName().equals("result")) {
                        result = node.getTextContent();
                    }
                }
                if (result.equals("0")) {
                    break;
                }

            }
        }
        return result;
    }

    /*@RequestMapping(value = "/getDeptList.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getDeptList() {
        Map<String, Object> map = new HashMap<>();
        try {
            List<DicDept> deptList  = dicDeptService.getBelongDept("01");
            JSONArray     jsonArray = new JSONArray();
            for (DicDept dicDept : deptList) {
                jsonArray.add(dicDept.getJsonObject());
            }

            map.put("result", true);
            map.put("deptList", jsonArray);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }*/

    /**
     * 删除
     * @param id
     * @return
     */
    @RequestMapping(value = "/deleteUser.do", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteUser(String id) {
        DicUser user = dicUserService.get(id);
        Map<String, Object> map = new HashMap<>();
        //依次检测用户有没有被占用，如果被占用直接返回

        dicUserService.delete(user);
        map.put("result", true);
        //日志信息保存
        try {
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("用户");
            sysLogVo.setRecordType(2);
            if (null != user){
                sysLogVo.setEntityId(user.getId());
                sysLogVo.setEntityName(user.getEmpName());
            }
            sysLogVo.setResult(map.get("result").toString());
            //记录日志
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            LOG.debug(e.getMessage(),e);
        }
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/find-users-by-dept.do", method = RequestMethod.POST)
    public Map<String, Object> findUsersByDept(String deptId) {
        Map<String, Object> map = new HashMap<>(1);
        if (!StringUtils.isEmpty(deptId)) {

            List<DicDept> deptList = dicDeptService.getBelongDept(deptId);
            List<String> stringList = new ArrayList<>();
            if (deptList.size() > 0) {
                for (DicDept dicDept : deptList) {
                    stringList.add(dicDept.getId());
                }
            }
            List <DicUser> userList = dicUserService.findUserList(stringList);
            List<JSON> dicUserList = new ArrayList<>();
            for (DicUser dicUser : userList) {
                dicUserList.add(dicUser.getJsonObject());
            }

            map.put("dicUserList", dicUserList);
        }

        map.put("result",true);

        return map;

    }


    /**
     * 获取部分人员
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/get-first-count.do", method = RequestMethod.GET)
    public List<JSONObject> getFirstCount(String count) {
        List<JSONObject> list = new ArrayList<>();

        if (!StringUtils.isEmpty(count)) {
            List<DicUser> dicUserList = dicUserService.getFirstCount(count);
            list = getUserInfo(dicUserList);
        }

        return list;
    }


    @ResponseBody
    @RequestMapping(value = "/query-user.do", method = RequestMethod.GET)
    public List<JSONObject> queryUser(String query) {
        List<JSONObject> list = new ArrayList<>();
        if (!StringUtils.isEmpty(query)) {
            String q = "";
            try {
                q = URLDecoder.decode(query, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            List<DicUser> dicUserList = dicUserService.searchByQuery("%" + q + "%");
            list = getUserInfo(dicUserList);
        }

        return list;
    }

    private List<JSONObject> getUserInfo(List<DicUser> dicUserList) {
        List<JSONObject> list = new ArrayList<>();
        for (DicUser dicUser : dicUserList) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", dicUser.getId());
            jsonObject.put("empName", dicUser.getEmpName());
            jsonObject.put("deptName", null == dicUser.getDicDept() ? "" : dicUser.getDicDept().getDeptName());
            list.add(jsonObject);
        }

        return list;
    }
}
