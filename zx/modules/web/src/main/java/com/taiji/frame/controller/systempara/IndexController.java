package com.taiji.frame.controller.systempara;


import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.ListSortUtil;
import com.taiji.frame.common.util.MD5Util;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecPopedomView;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.service.foreignaffairs.bulletinBoard.BulletinBoardService;
import com.taiji.frame.service.inspection.place.PlaceService;
import com.taiji.frame.service.pubinfo.batch.SubmitBatchOutService;
import com.taiji.frame.service.pubinfo.batch.SubmitBatchService;
import com.taiji.frame.service.pubinfo.schedule.ActivityPlanService;
import com.taiji.frame.service.pubinfo.schedule.DutyDailyService;
import com.taiji.frame.service.pubinfo.schedule.WeekWorkService;
import com.taiji.frame.service.systempara.DicParaDtlService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.util.UtilService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.taiji.frame.realm.AuthorityUtil.getCurUser;

@Controller
public class IndexController {

    private static final Logger LOG = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    private UtilService utilService;
    /**获取登录信息*/
    @Autowired
    private DicUserService dicUserService;

    @Autowired
    private DicParaDtlService dicParaDtlService;

    @Autowired
    private DicParaDtlService paraDtlService;
    /**公告栏*/
    @Autowired
    private BulletinBoardService bulletinBoardService;
    /**视察考察*/
    @Autowired
    private PlaceService placeService;
    /**领导活动安排*/
    @Autowired
    private ActivityPlanService activityPlanServicea;
    /**一周工作情况*/
    @Autowired
    private WeekWorkService wekWorkService;
    /**值班日报*/
    @Autowired
    private DutyDailyService dutyDailyService;
    /**呈批件
     * 内行，外行
     */
    @Autowired
    private SubmitBatchService submitBatchService;
    @Autowired
    private SubmitBatchOutService submitBatchOutService;

    /**
     * 跳转到登录页
     *
     * @return
     */
    @RequestMapping("/index.do")
    public String login() {
        return "login";
    }

    /**
     * 跳转到首页内容
     *
     * @return
     */
    @RequestMapping("/index/main.do")
    public String indexMain(HttpServletRequest request) {
        try {
            //孙毅注销
            //DicUser curUser = AuthorityUtil.getCurUser();
            DicUser curUser = getCurUser();
            if (curUser != null) {
                Boolean hasAccdAuth = false; //突发事件审核
                Boolean hasInnerAuth = false; //内部事件审核
                Boolean hasAcc = false;  //突发事件
                Boolean hasAccScan = false; //突发事件浏览
                Boolean hasInnerAcc = false; //内部突发事件

                DicUser user = dicUserService.findUniqueBy("id", curUser.getId());
                //第一步 根据用户所属机构取机构的最新动态显示标志
                //第二步 判断登录人是否有[突发事件审核][内部突发事件审核]权限
                List<SecRole> secRoleList = user.getRoleList();
                for (SecRole secRole : secRoleList) {
                    List<SecPopedomView> roleSecPopeDomViewList = secRole.getSecPopedomViewList();
                    for (SecPopedomView secPopeDomView : roleSecPopeDomViewList) {

                        //判断有无突发事件审核权限
                        if ("8_09".equals(secPopeDomView.getId())) {
                            hasAccdAuth = true;
                            continue;
                        }
                        //判断有无内部事件审核权限
                        if ("9_09".equals(secPopeDomView.getId())) {
                            hasInnerAuth = true;
                            continue;
                        }
                        //判断有无突发事件权限
                        if ("8".equals(secPopeDomView.getId())) {
                            hasAcc = true;
                            continue;
                        }
                        //判断有无突发事件浏览权限
                        if ("46".equals(secPopeDomView.getId())) {
                            hasAccScan = true;
                            continue;
                        }
                        //判断有无内部突发 权限
                        if ("9".equals(secPopeDomView.getId())) {
                            hasInnerAcc = true;
                            continue;
                        }
                    }
                }

                request.setAttribute("userId", user.getId());
                //增加登录人所属行政区划ID

                //孙毅添加  首页数据显示
                //菜单权限
                List<SecPopedomView> userSecPopeDomViewList = new ArrayList<SecPopedomView>();
                if(curUser!=null) {
                    DicUser user1 = dicUserService.findUniqueBy("id", curUser.getId());
                    //根据登录用户的权限取系统菜单
                    secRoleList = user1.getRoleList();
                    for (SecRole secRole : secRoleList) {
                        List<SecPopedomView> roleSecPopeDomViewList = secRole.getSecPopedomViewList();
                        for (SecPopedomView secPopeDomView : roleSecPopeDomViewList) {
                            if (!userSecPopeDomViewList.contains(secPopeDomView)) {
                                userSecPopeDomViewList.add(secPopeDomView);
                            }
                        }
                    }
                    //排序
                    new ListSortUtil<SecPopedomView>().mySort(userSecPopeDomViewList, "position", "asc");
                    //所有权限菜单
                    request.setAttribute("userSecPopeDomViewListIndexMain", userSecPopeDomViewList);
                }
                //菜单权限
                String placeStrs = "";
                String dutyStrs ="";
                String wekWorks = "";
                String activitys = "";
                String batch = "";

                for (SecPopedomView v:userSecPopeDomViewList) {
                    String id = v.getId();
                    //以下权限用来区别当前用户属于值班员还是普通用户
                    //视察考察
                    if("76_13".equals(id)){placeStrs=id;}
                    if("50_11".equals(id)){dutyStrs=id;}
                    if("51_13".equals(id)){wekWorks=id;}
                    //领导活动安排
                    if("53_14".equals(id)){activitys=id;}
                    //呈批件
                    if("79_9".equals(id)){batch=id;}
                }


                //待办事项
                    // 1.视察考察调研活动curUser
                        request.setAttribute("placeListIndexMainAgency", placeService.indexMainloadAgencyService(placeStrs, curUser));
                    //2.日程安排
                        // (1).值班日报
                        request.setAttribute("dutyDailyListIndexMainAgency", dutyDailyService.dutyListLoadIndexMain(0, curUser, dutyStrs));
                        // (2).一周工作情况
                        request.setAttribute("wekWorkListIndexMainChargeList", wekWorkService.loadIndexMain(0, curUser, wekWorks));
                        // (3).活动领导安排
                        request.setAttribute("activityPlanIndexMainChargeList", activityPlanServicea.loadIndexMain(0, curUser, activitys));
                    //3.呈批件
                        //(1)内行文
                        request.setAttribute("submitBatchListIndexMain", submitBatchService.loadIndexMainService(curUser, batch));
                        //(2)外行文
                        request.setAttribute("submitBatchOutListIndexMain", submitBatchOutService.loadIndexMain(curUser, batch));
                //工作状态
                //值班日报(状态已查收的 显示)
                //request.setAttribute("dutyDailyListIndexMainList",dutyDailyService.dutyListLoadIndexMain(1,curUser,dutyStrs));
                //一周工作情况（状态已下发的 显示）
                //request.setAttribute("wekWorkListIndexMainList", wekWorkService.loadIndexMain(1,curUser,"时间"));
                //活动领导安排（状态一下发，并且需要开会的显示）
                //request.setAttribute("activityPlanListIndexMainList", activityPlanServicea.loadIndexMain(1,curUser,""));

                //公告栏信息
                request.setAttribute("bulletinBoardIndexMainList", bulletinBoardService.loadIndexMain());
                //视察考察调研活动安排数据展示（显示已确认的数据）
                    request.setAttribute("placeListIndexMain", placeService.indexMainloadService(curUser));
                //孙毅添加结束
            }
            String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
            request.setAttribute("indexMainSysTime",sysDate);
        } catch (Exception ex) {
            LOG.error(ex.getMessage(), ex);
        }

        return "index-main";
    }




    /**
     * 判断密码重复
     *
     * @return
     */
    @RequestMapping(value = "/index/checkOldPassword.do")
    @ResponseBody
    public Map checkOldPassword(String userId, String oldPassword) {
        String flag;
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            DicUser user = dicUserService.findUniqueBy("id", userId);
            if (oldPassword != null && MD5Util.MD5(oldPassword).equals(user.getPassword())) {
                flag = "true";
            } else {
                flag = "false";
            }
        } catch (Exception e) {
            flag = "false";
        }
        map.put("result", flag);
        return map;
    }

    /**
     * 判断密码
     *
     * @return
     */
    @RequestMapping("/index/freshPassword.do")
    @ResponseBody
    public Map freshPassword() {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            //DicUser curUser = AuthorityUtil.getCurUser();
            DicUser curUser = getCurUser();
            if (curUser.getPassword().equals("E10ADC3949BA59ABBE56E057F20F883E")) {
                map.put("password", true);
            } else {
                map.put("password", false);
            }
            map.put("result", true);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 根据当前用户的ID加载用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/index/loadUserInfo.do", method = RequestMethod.POST)
    public Map<String, Object> loadUserInfo(String id) {

        Map<String, Object> map = new HashMap<>(10);
        try {
            DicUser user = dicUserService.findUniqueBy("id", id);
            map.put("result", true);
            map.put("userInfo", user.getJsonObject());
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
}
