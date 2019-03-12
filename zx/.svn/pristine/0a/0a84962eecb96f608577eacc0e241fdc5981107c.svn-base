package com.taiji.frame.controller.dashboard;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.realm.AuthorityUtil;
import com.taiji.frame.service.systempara.DicUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by CHX on 2016/5/3.
 */
@Controller
@RequestMapping(value = "/dashboard")
public class DashboardController extends BaseController {

    private static final Logger LOG = LoggerFactory.getLogger(DashboardController.class);




    @Autowired
    private DicUserService dicUserService;

    /**
     * 控制版面页面
     * @param map
     * @return
     */
    @RequestMapping(value = "/list.do")
    public String show(Map<String, Object> map) {
        DicUser user = getCurUser();
        DicDept dicDept = user.getDicDept();

        String startDate = getCurDateStr(DateUtil.FORMAT_DAYTIME);
        String sysDate = DateUtil.dateToString(getCurDate(), DateUtil.FORMAT_DAY);
        List<String> curOperateAuth=new ArrayList<String>();
        String specSubSecPopeDomViewId = "13";
        List<String> specList = AuthorityUtil.getOperateAuthority(specSubSecPopeDomViewId, dicUserService);
        curOperateAuth.addAll(specList);
        String emegSubSecPopeDomViewId = "4";
        List<String> emegList = AuthorityUtil.getOperateAuthority(emegSubSecPopeDomViewId, dicUserService);
        curOperateAuth.addAll(emegList);
        String dutySubSecPopeDomViewId = "23";
        List<String> dutyList = AuthorityUtil.getOperateAuthority(dutySubSecPopeDomViewId, dicUserService);
        curOperateAuth.addAll(dutyList);
        String accdSubSecPopeDomViewId = "8";
        List<String> accdList = AuthorityUtil.getOperateAuthority(accdSubSecPopeDomViewId, dicUserService);
        curOperateAuth.addAll(accdList);
        String innerSubSecPopeDomViewId = "9";
        List<String> innerList = AuthorityUtil.getOperateAuthority(innerSubSecPopeDomViewId, dicUserService);
        curOperateAuth.addAll(innerList);
        map.put("curOperateAuth",curOperateAuth);
        map.put("sysDate", sysDate);

        map.put("startDate", startDate);
        map.put("userName",user.getEmpName());
        return "dashboard/list";
    }

}
