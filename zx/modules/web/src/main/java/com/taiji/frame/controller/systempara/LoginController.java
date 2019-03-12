package com.taiji.frame.controller.systempara;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.ListSortUtil;
import com.taiji.frame.common.util.MD5Util;
import com.taiji.frame.common.util.VerifyCodeUtil;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecPopedomView;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.UserVo;
import com.taiji.frame.realm.AuthorityUtil;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicParaDtlService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import com.westone.middleware.toolkit.trustService.identity.VerifyIdentityTicketResult;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSONArray;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.*;
import java.util.List;

//import itec.ldap.*;


@Controller
public class LoginController extends BaseController{
    private static final Logger LOG = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private DicUserService dicUserService;   //获取登录信息

    @Autowired
    private DicParaDtlService dicParaDtlService;



    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;


    @Getter
    @Setter
    private List<SecPopedomView> userSecPopeDomViewList;    //登录用户拥有的菜单列表

    @Getter
    @Setter
    private  List<SecRole> secRoleList;   //登录用户的角色列表


    /**
     * 用户登录
     */
    @RequestMapping(value="/login.do", method=RequestMethod.POST)
    public String login(HttpServletRequest request){

        DicUser user = null;
        UsernamePasswordToken token = null;
        String username = "";

//        // Userinfo 中的 rmsid 即 Resource 中的 rmsNo
//        // 从 session 中获取 userinfo
//        VerifyIdentityTicketResult.Userinfo userinfo = (VerifyIdentityTicketResult.Userinfo)
//                request.getSession().getAttribute("userinfo");
//        if (userinfo != null) {
//            String rmsid = userinfo.rmsid;
//            if (rmsid != null) {
//                user = dicUserService.findUniqueBy("rmsNo", rmsid);
//                username = user.getEmpName();
//                String password = user.getPassword();
//                token = new UsernamePasswordToken(username, password);
//                token.setRememberMe(true);
//            }
//
//        } else {
//            return "login";
//        }

        username = request.getParameter("j_username");
        String password = request.getParameter("j_password");
        String givenName = request.getParameter("j_givenName");
        String md5PassWord = "";
        if ("".equals(givenName) || givenName == null) {
            md5PassWord = MD5Util.MD5(password);
        } else {
            md5PassWord = password;
        }
        token = new UsernamePasswordToken(username, md5PassWord);
        token.setRememberMe(true);
        try {
            Subject currentUser = SecurityUtils.getSubject();
            currentUser.login(token);
            String userID = (String) currentUser.getPrincipal();
            user = dicUserService.findUniqueBy("userId",userID);
        //    System.out.println("对用户[" + username + "]进行登录验证..验证通过");
            //如果登录用户为禁用用户
            if(0 == user.getIsactive()){
                user=null;
                request.setAttribute("message_login", "此用户已被禁用");
            }
        }catch(UnknownAccountException uae){
            request.setAttribute("message_login", "系统无此账号，无法登录");
        }catch(IncorrectCredentialsException ice){
            request.setAttribute("message_login", "密码不正确");
            request.setAttribute("logUserName",username);
        }catch(LockedAccountException lae){
            request.setAttribute("message_login", "账户已锁定");
        }catch(ExcessiveAttemptsException eae){
            request.setAttribute("message_login", "用户名或密码错误次数过多");
        }catch(AuthenticationException ae){
            ae.printStackTrace();
            request.setAttribute("message_login", "用户名或密码不正确");
        }
        //成功登录
        if (null != user) {
            this.setSession("currentUser", user);
            //日志信息保存
            try {
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("登录");
                sysLogVo.setRecordType(3);
                sysLogVo.setEntityId(user.getId());
                sysLogVo.setEntityName(user.getEmpName());
                sysLogVo.setResult("true");
                //记录日志
                sysLogService.record(sysLogVo);
            }catch (Exception e){
                LOG.error("登录失败");
            }
            //重定向
            return "redirect:/toIndex.do";
        } else {
            return "login";
        }
    }

    /**
     * 用户登录
     */
    @RequestMapping(value="/loginNoUser.do")
    public String loginNoUser(HttpServletRequest request){
        DicUser user = null;
        UsernamePasswordToken token = null;
        String username = "";

        // Userinfo 中的 rmsid 即 Resource 中的 rmsNo
        // 从 session 中获取 userinfo
        VerifyIdentityTicketResult.Userinfo userinfo = (VerifyIdentityTicketResult.Userinfo)
                request.getSession().getAttribute("userinfo");
        if (userinfo == null) {
            return "login";
        } else {
            String rmsid = userinfo.rmsid;
            if (rmsid != null) {
                user = dicUserService.findUniqueBy("rmsNo", rmsid);
                if (null == user) {
                    request.setAttribute("message_login", "系统无此账号，无法登录");
                    return "login";
                }
                username = user.getUserId();
                String password = user.getPassword();
                token = new UsernamePasswordToken(username, password);
                token.setRememberMe(true);
            }
        }
        try {
            Subject currentUser = SecurityUtils.getSubject();
            currentUser.login(token);
            String userID = (String) currentUser.getPrincipal();
            user = dicUserService.findUniqueBy("userId",userID);
            //    System.out.println("对用户[" + username + "]进行登录验证..验证通过");
            //如果登录用户为禁用用户
            if(0 == user.getIsactive()){
                user=null;
                request.setAttribute("message_login", "此用户已被禁用");
            }
        }catch(UnknownAccountException uae){
            request.setAttribute("message_login", "系统无此账号，无法登录");
        }catch(IncorrectCredentialsException ice){
            request.setAttribute("message_login", "密码不正确");
            request.setAttribute("logUserName",username);
        }catch(LockedAccountException lae){
            request.setAttribute("message_login", "账户已锁定");
        }catch(ExcessiveAttemptsException eae){
            request.setAttribute("message_login", "用户名或密码错误次数过多");
        }catch(AuthenticationException ae){
            ae.printStackTrace();
            request.setAttribute("message_login", "用户名或密码不正确");
        }//成功登录
        if (null != user) {
            this.setSession("currentUser", user);

            //记录日志
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("证书登录");
            sysLogVo.setRecordType(3);
            sysLogVo.setEntityId(user.getId());
            sysLogVo.setEntityName(user.getEmpName());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            //重定向
            return "redirect:/toIndex.do";
        } else {
            return "login";
        }

    }


    /**
     * 将一些数据放到ShiroSession中,以便于其它地方使用
     * 比如Controller,使用时直接用HttpSession.getAttribute(key)就可以取到
     */
    private void setSession(Object key, Object value){
        Subject currentUser = SecurityUtils.getSubject();
        if(null != currentUser){
            Session session = currentUser.getSession();
            if(null != session){
                session.setAttribute(key, value);
            }
        }
    }

    /**
     * shiro对密码进行md5加密
     * @param password 密码
     * @return
     */
    public String md5Password(String password){
        //对密码进行加密
        String md5Password= new Md5Hash(password).toBase64();
        return md5Password;
    }


    /**
     * 登录成功重定向进入首页
     * @param request
     * @return
     */
    @RequestMapping("/toIndex.do")
    public String toIndex(HttpServletRequest request){
        DicUser curUser = AuthorityUtil.getCurUser();
        if(curUser!=null) {
            DicUser user = dicUserService.findUniqueBy("id", curUser.getId());
            //根据登录用户的权限取系统菜单
            userSecPopeDomViewList = new ArrayList<SecPopedomView>();
            secRoleList = user.getRoleList();
            for (SecRole secRole : secRoleList) {
                List<SecPopedomView> roleSecPopeDomViewList = secRole.getSecPopedomViewList();
                for (SecPopedomView secPopeDomView : roleSecPopeDomViewList) {
                    if (!userSecPopeDomViewList.contains(secPopeDomView)) {
                        userSecPopeDomViewList.add(secPopeDomView);
                    }
                }
            }
            //获取部门列表
            JSONArray treeNode = getOrgList();
            request.setAttribute("treeNode",treeNode);
            //排序
            new ListSortUtil<SecPopedomView>().mySort(userSecPopeDomViewList,"position","asc");
            //所有权限菜单
            request.setAttribute("userSecPopeDomViewList", userSecPopeDomViewList);
            request.setAttribute("curUserId",user.getId());

            return "index";
        }else {
            return "login";
        }
    }


    /**
     * 用户登出
     */
    @RequestMapping("/logout.do")
    public String logout(){
        SecurityUtils.getSubject().logout();
        return InternalResourceViewResolver.REDIRECT_URL_PREFIX + "/";
    }

    /**
     * 修改密码
     * @return
     */
    @RequestMapping(value = "/login/modifyPassword.do" ,method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String modifyPassword(String userId,String oldPassword,String newPassword) {
        String flag;
        try {
            DicUser user = dicUserService.findUniqueBy("id",userId);
            user.setPassword(MD5Util.MD5(newPassword));
            dicUserService.save(user);
            flag="true";
        } catch (Exception e) {
            e.printStackTrace();
            flag="false";
        }
        return flag;
    }


    /**
     * 修改密码
     * @return
     */
    @RequestMapping(value = "/login/editUserInfo.do" ,method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String editUserInfo(String userInfoId,String empName,String email,String fax,String notes,String mobile) {
        String flag;
        try {
            DicUser user = dicUserService.findUniqueBy("id",userInfoId);
            user.setEmpName(empName);
            user.setEmail(email);
            user.setFax(fax);
            user.setMobile(mobile);
            user.setUpdDate(new Date());
            dicUserService.save(user);
            flag="true";
        } catch (Exception e) {
            e.printStackTrace();
            flag="false";
        }
        return flag;
    }

    /**
     * 判断密码重复
     * @return
     */
    @RequestMapping(value="/login/checkOldPassword.do", method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String checkOldPassword(String userId,String oldPassword) {
        String flag;
        try {
            DicUser user = dicUserService.findUniqueBy("id", userId);
            if (oldPassword != null && MD5Util.MD5(oldPassword).equals(user.getPassword())) {
                flag="true";
            } else {
                flag="false";
            }
        } catch (Exception e) {
            flag="false";
        }
        return flag;
    }


    /**
     * 获取验证码图片和文本(验证码文本会保存在HttpSession中)
     */
    @RequestMapping("/getVerifyCodeImage.do")
    public void getVerifyCodeImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        String verifyCode = VerifyCodeUtil.generateTextCode(VerifyCodeUtil.TYPE_NUM_ONLY, 4, null);
        //将验证码放到HttpSession里面
        request.getSession().setAttribute("verifyCode", verifyCode);
        System.out.println("本次生成的验证码为[" + verifyCode + "],已存放到HttpSession中");
        //设置输出的内容的类型为JPEG图像
        response.setContentType("image/jpeg");
        BufferedImage bufferedImage = VerifyCodeUtil.generateImageCode(verifyCode, 90, 30, 3, true, Color.WHITE, Color.BLACK, null);
        //写给浏览器
        ImageIO.write(bufferedImage, "JPEG", response.getOutputStream());
    }

    @RequestMapping(value = "/save.do", method = RequestMethod.POST)
    @ResponseBody
    public Map save(UserVo userVo) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            userVo.setCreateDate(getCurDate());
            userVo.setUpdDate(getCurDate());
            dicUserService.saveUser(userVo);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    @RequestMapping(value = "/loadUserByGN.do",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> loadUserByGN(String given){
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            DicUser dicUser = dicUserService.findUniqueBy("givenName", given);
            if(dicUser!=null && !"".equals(dicUser)){
                map.put("isGiven",true);
                map.put("username",dicUser.getUserId());
                map.put("password",dicUser.getPassword());
            }else{
                map.put("isGiven",false);
            }
            map.put("result", true);
        }catch (Exception e){
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
}
