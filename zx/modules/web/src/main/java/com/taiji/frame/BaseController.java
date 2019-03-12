package com.taiji.frame;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.GridResultJackson;
import com.taiji.frame.common.util.ReflectionUtils;
import com.taiji.frame.model.systempara.*;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.realm.AuthorityUtil;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.service.systempara.UrlParaService;
import com.taiji.frame.util.ExecuteDAO;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.persistence.Entity;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by CHX on 2016/2/23.
 */
public class BaseController<T extends IdEntity> {

    private static final Logger LOG = LoggerFactory.getLogger(BaseController.class);

    @Autowired
    HttpServletRequest request;
    @Autowired
    DicUserService dicUserService;
    @Autowired
    UtilService utilService;
    @Autowired
    DicDeptService dicDeptService;

    @Autowired
    private SysLogService sysLogService;

    @Autowired
    private UrlParaService urlParaService;


    protected ExecuteDAO executeDAO;
    protected Class<T> entityClass;

    @Resource(name = "executeDAO")
    public void setExecuteDAO(ExecuteDAO executeDAO) {
        this.executeDAO = executeDAO;
    }

    public BaseController(){
        entityClass = ReflectionUtils.getSuperClassGenricType(getClass());
    }

    /**
     * 简单字段重复校验
     * @param checkValue
     * @param checkKey
     * @param id
     * @return
     */
    @RequestMapping(value = "/checkUnique.do", method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String checkUnique(String checkValue,String checkKey,String id) {
        String flag;
        try {
            Map<String,Object> param = new HashMap<>();
            StringBuffer hql = new StringBuffer("from "+entityClass.getName()+" where "+checkKey+"=:checkValue");
            param.put("checkValue",checkValue);
            if(!StringUtils.isEmpty(id)){
                hql.append(" and id !=:id");
                param.put("id",id);
            }

            List<T> list = this.executeDAO.find(hql.toString(), param);
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

    /**
     * 获取当前登录的用户信息
     * @return
     */
    public DicUser getCurUser(){
        DicUser curUser = AuthorityUtil.getCurUser();
        curUser = dicUserService.get(curUser.getId());
        return curUser;
    }

    /**
     * 获取部门列表
     * */
    public JSONArray getOrgList() {

        JSONArray treeNode = new JSONArray();
        //查询全国政协下所有部门列表（“01”为全国政协部门编码）
        List<DicDept> deptList = dicDeptService.getBelongDept("01");
        if (null != deptList &&  deptList.size() > 0) {
            for (DicDept dicDept : deptList) {
                JSONObject object = new JSONObject();
                object.put("id",dicDept.getDeptCode());
                object.put("PId",dicDept.getParentCode());
                object.put("name",dicDept.getDeptName());
                object.put("seq",dicDept.getSeq());
                //禁止根节点拖拽
                if ("01".equals(dicDept.getDeptCode())) {
                    object.put("drag",false);
                }
                if ("01".equals(dicDept.getParentCode()) || "01".equals(dicDept.getDeptCode())) {
                    object.put("open",true);
                }
                treeNode.add(object);
            }
        }
        return treeNode;
    }

    @ModelAttribute
    public void prepare(){
        String subSecPopeDomViewId = request.getParameter("SubSecPopeDomViewId");
        if(subSecPopeDomViewId!=null) {
            List<String> curOperateAuth = AuthorityUtil.getOperateAuthority(subSecPopeDomViewId, dicUserService);
            request.getSession().setAttribute("curOperateAuth",curOperateAuth); //放到session中
        }
    }

    @ModelAttribute
    public void initCarrier(Carrier<T> carrier)
    {
        if (carrier.getCurrentPage() == 0) {
            if(carrier.getPage() != 0 ){
                carrier.setCurrentPage(carrier.getPage());
            }else {
                carrier.setCurrentPage(1);
            }

        }
    }

    public String gridResult(Carrier<T> carrier)
    {
        JSONObject result = new JSONObject();
        try {
            JSONArray jsonArray = new JSONArray();
            if (carrier.getResult() != null) {
                for (Object obj : carrier.getResult()) {
                    jsonArray.add(((Jsonable) obj).getJsonObject());
                }
            }

            result.put("page", carrier.getCurrentPage());
            result.put("total", carrier.getTotalPage());
            result.put("records", carrier.getTotalSize());
            result.put("data", jsonArray);
        } catch (Exception e) {
            LOG.debug(e.getMessage(),e);
        }

        return result.toString();
    }

    public GridResultJackson<T> gridResultJackson(Carrier<T> carrier)
    {
        GridResultJackson<T> result = new GridResultJackson<T>();
        result.setPage(carrier.getCurrentPage());
        result.setRecords(carrier.getTotalSize());
        result.setTotal(carrier.getTotalPage());
        result.setData(carrier.getResult());
        return result;
    }

    /**
     * date 数据类型绑定
     * @param binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder){
        SimpleDateFormat dateFormat =new SimpleDateFormat("yyyy-MM-dd HH:mm");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    public Date getCurDate() {
        return utilService.getSysTime();
    }

    public String getCurDateStr(String format){
        Date date = utilService.getSysTime();
        return DateUtil.dateToString(date, format);
    }

    public String encodeContent(String s) throws UnsupportedEncodingException {
        if (null != s){
            s =new String(s.getBytes("iso8859_1"),"utf-8");
        }
        return s;
    }


    public SysLogVo noteLog(){
        SysLogVo sysLogVo = new SysLogVo();
        String url =  request.getServletPath();
        if(url.contains(".do")){
            String actionMethod[] = url.split("\\.");
            String method = actionMethod[0];
            UrlPara urlPara = urlParaService.findUniqueBy("url",method);
            if(null!=urlPara){
                Map<String,String[]> map = request.getParameterMap();
                String removeAttr = getIpAddr(request);
                Object obj = request.getSession().getAttribute("currentUser");
                SysLog sysLog = new SysLog();
                sysLog.setUpdDate(new Date());
                sysLog.setFromIp(removeAttr);
                if(null != obj)
                {
                    DicUser user = (DicUser)obj;
                    sysLog.setUpdEmpId(user.getId());
                    sysLog.setUpdEmpName(user.getEmpName());
                }
                if(method.equals("/login")){
                    if(null != obj)
                    {
                        DicUser user = (DicUser)obj;
                        sysLog.setDscr("登录名:"+user.getEmpName()+";");
                    }
                }else{
                    //sysLog.setDscr(mapToString(map));

                }
                sysLog.setUrlDscr(urlPara.getUrlDscr());
                sysLogService.save(sysLog);
            }
        }
        return sysLogVo;
    }

    /**
     * 获取日志Vo
     */
    public SysLogVo getSysLogVo(){
        SysLogVo sysLogVo = new SysLogVo();
        DicUser curUser = getCurUser();
        if (null != curUser){
            sysLogVo.setUpdEmpId(curUser.getId());
            sysLogVo.setUpdEmpName(curUser.getEmpName());
        }
        String removeAttr = getIpAddr(request);
        sysLogVo.setFromIp(removeAttr);
        return sysLogVo;
    }

    /**
     * 记录日志信息所需map
     * */
    public Map<String, String[]> getParameterMap () {
        Map<String, String[]> map = request.getParameterMap();
        return map;
    }

    /**
     * map转字符串
     * @param map
     * @return
     */
    private String mapToString(Map<String,Object> map){
        StringBuffer dscr = new StringBuffer("");
        for(Map.Entry<String,Object> entry:map.entrySet()){
            String key = entry.getKey();
            String values = (String) entry.getValue();
            dscr.append(key+":"+values+";");
        }
        return dscr.toString().length() >2500? dscr.toString().substring(0,2500)+"...":dscr.toString();
    }

    /**
     * 获取用户真实IP地址，不使用request.getRemoteAddr()的原因是有可能用户使用了代理软件方式避免真实IP地址,
     * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值
     * @return ip
     */
    private String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
            // 多次反向代理后会有多个ip值，第一个ip才是真实ip
            if( ip.indexOf(",")!=-1 ){
                ip = ip.split(",")[0];
            }
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
