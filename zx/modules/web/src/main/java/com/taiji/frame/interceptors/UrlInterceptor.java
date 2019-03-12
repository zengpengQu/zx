package com.taiji.frame.interceptors;

import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SysLog;
import com.taiji.frame.model.systempara.UrlPara;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.service.systempara.UrlParaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;

/**
 * 记录操作日志
 * Created by CHX on 2016/5/11.
 */
public class UrlInterceptor implements HandlerInterceptor {

    @Autowired
    private SysLogService sysLogService;

    @Autowired
    private UrlParaService urlParaService;


    /**
     * 请求调用之前,可以进行数据校验，权限操作等，日志，事物等
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
//        session过期跳转至登录页面

//        String[] noFilters = new String[] { "/login.do", "veriCode.html"};
//        String uri = httpServletRequest.getRequestURI();
//        Boolean filter = true;
//        for(String s: noFilters){
//            if(s.equals(uri)){
//                filter = false;
//            }
//        }
//        if(filter){
//            HttpSession session =httpServletRequest.getSession();
//            if(null == session){
//                httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/login.do");
//                return false;
//            }else{
//                return true;
//            }
//        }else{
//            return true;
//        }
        return true;
    }

    /**
     * 请求执行过程至请求执行完视图渲染之前，可以对请求域中的视图做出修改，重定向等操作；
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    /**
     * 视图渲染之后进行拦截表示操作成功，规避了异常的操作情况 ，释放资源等
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param e
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        /*String url =  httpServletRequest.getServletPath();
        if(url.contains(".do")){
            String actionMethod[] = url.split("\\.");
            String method = actionMethod[0];
            UrlPara urlPara = urlParaService.findUniqueBy("url",method);
            if(null!=urlPara){
                Map<String,String[]> map = httpServletRequest.getParameterMap();
                String removeAttr = getIpAddr(httpServletRequest);

                Object obj = httpServletRequest.getSession().getAttribute("currentUser");

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
                    sysLog.setDscr(mapToString(map));
                }
                sysLog.setUrlDscr(urlPara.getUrlDscr());
                sysLogService.save(sysLog);
            }
        }*/


    }

    private String mapToString(Map<String,String[]> map){
        StringBuffer dscr = new StringBuffer("");
        for(Map.Entry<String,String[]> entry:map.entrySet()){
            String key = entry.getKey();
            String values = Arrays.toString(entry.getValue());
            dscr.append(key+":"+values+";");
        }
        return dscr.toString().length() >2500? dscr.toString().substring(0,2500)+"...":dscr.toString();
    }

    /**
     * 获取用户真实IP地址，不使用request.getRemoteAddr()的原因是有可能用户使用了代理软件方式避免真实IP地址,
     * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值
     * @return ip
     */
    private String getIpAddr(HttpServletRequest httpServletRequest) {
        String ip = httpServletRequest.getHeader("x-forwarded-for");
        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
            // 多次反向代理后会有多个ip值，第一个ip才是真实ip
            if( ip.indexOf(",")!=-1 ){
                ip = ip.split(",")[0];
            }
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = httpServletRequest.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = httpServletRequest.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = httpServletRequest.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = httpServletRequest.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = httpServletRequest.getHeader("X-Real-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = httpServletRequest.getRemoteAddr();
        }
        return ip;
    }
}
