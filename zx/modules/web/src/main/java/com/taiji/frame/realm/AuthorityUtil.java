package com.taiji.frame.realm;

import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecPopedomView;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.service.systempara.DicUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhangshuai on 2016/2/22.
 * 页面操作权限工具类
 */
public class AuthorityUtil {

    /**
     * 获取当前登录的用户信息
     * @return
     */
    public static DicUser getCurUser(){
        //获取shiro的session中存储的信息
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        DicUser curUser = (DicUser) session.getAttribute("currentUser");
        return curUser;
    }

    /**
     * 当前用户进入页面时的操作权限
     *
     * @param parentSecPopedomViewId
     * @return
     */
    public static List<String> getOperateAuthority(String parentSecPopedomViewId,DicUserService dicUserService) {

        List<String> userOperateAuthorityList = new ArrayList<String>();
        //获取shiro的session中存储的信息
        Subject currentUser = SecurityUtils.getSubject();
        try {
            if (currentUser != null) {
                Session session = currentUser.getSession();
                DicUser curUser = (DicUser) session.getAttribute("currentUser");

                curUser = dicUserService.get(curUser.getId());
                List<SecRole> secRoleList = curUser.getRoleList();
                for (SecRole secRole : secRoleList) {
                    List<SecPopedomView> roleSecPopeDomViewList = secRole.getSecPopedomViewList();
                    for (SecPopedomView secPopeDomView : roleSecPopeDomViewList) {
                        if (null !=secPopeDomView.getParentId() && parentSecPopedomViewId.equals(secPopeDomView.getParentId())) {
                            if (!userOperateAuthorityList.contains(secPopeDomView.getId())) {
                                userOperateAuthorityList.add(secPopeDomView.getId());
                            }
                        }
                    }
                }
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return userOperateAuthorityList;

    }


}