package com.taiji.frame.realm;

import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.service.systempara.DicUserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 自定义的指定Shiro验证用户登录的类
 */
@Component
public class MyRealm extends AuthorizingRealm {

    @Autowired
    private DicUserService dicUserService;

    /**
     * 为当前登录的Subject授予角色和权限
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals){

        return null;
    }

    /**
     * 验证当前登录的Subject
     * 经测试:本例中该方法的调用时机为LoginController.login()方法中执行Subject.login()时
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        //获取基于用户名和密码的令牌
        UsernamePasswordToken token = (UsernamePasswordToken)authcToken;
//        System.out.println("验证当前Subject时获取到token为" + ReflectionToStringBuilder.toString(token, ToStringStyle.MULTI_LINE_STYLE));
        //此处无需比对,比对的逻辑Shiro会做,我们只需返回一个和令牌相关的正确的验证信息

        DicUser user = dicUserService.findUniqueBy("userId", token.getUsername());

      if(null != user){

          AuthenticationInfo authcInfo = new SimpleAuthenticationInfo(user.getUserId(),user.getPassword(),this.getName());

          return authcInfo;
      }else{ //没有返回登录用户名对应的SimpleAuthenticationInfo对象时,就会在LoginController中抛出UnknownAccountException异常
          return null;
      }


    }

}
