package com.taiji.frame.controller.pubinfo.schedule;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.schedule.ActivityPlan;
import com.taiji.frame.model.entity.pubinfo.schedule.PlanReceipt;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.schedule.ActivityPlanVo;
import com.taiji.frame.service.pubinfo.schedule.ActivityPlanService;
import com.taiji.frame.service.pubinfo.schedule.PlanReceiptService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author admin
 * 领导活动安排
 */
@Controller
@RequestMapping(value = "/activity-plan")
public class ActivityPlanController extends BaseController<ActivityPlan> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private ActivityPlanService activityPlanService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private PlanReceiptService planReceiptService;


    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 领导活动安排页面跳转
     * id:主页点击时传入的ID（孙毅添加）
     * */
    @RequestMapping(value = "/activity-plan-list", method = RequestMethod.GET)
    public String list(ModelMap modelMap,String id) {
        //当前用户
        DicUser dicUser = getCurUser();
        //用户所在部门
        DicDept curDept = dicUser.getDicDept();
        modelMap.addAttribute("curDept", curDept.getJsonObject());
        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(),DateUtil.FORMAT_DAY);
        modelMap.addAttribute("sysDate",sysDate);
        //孙毅添加
        modelMap.addAttribute("activityPlanIndexMain",id);

        return "pubinfo/schedule/leader-arrange/activity-plan-list";
    }

    /**
     * load grid表格数据
     * activityPlanIndexMain ：主页传入的ID
     */
    @ResponseBody
    @RequestMapping(value = "/load-plan-list.do", produces = "text/html;charset=UTF-8")
    public String load(Carrier<ActivityPlan> carrier, ActivityPlanVo activityPlanVo,String activityPlanIndexMain) {
        HashMap map = new HashMap(16);
        try {
            String startDateStr = activityPlanVo.getStartDateStr();
            String endDateStr = activityPlanVo.getEndDateStr();
            if(null != startDateStr && !"".equals(startDateStr)){
                map.put("startDate", startDateStr);
            }
            if(null != endDateStr && !"".equals(endDateStr)){
                map.put("endDate", endDateStr);
            }
            if (!StringUtils.isEmpty(activityPlanVo.getStatus())) {
                List<String> statusList = OtherUtil.strToStringList(activityPlanVo.getStatus());
                map.put("statusList", statusList);
            }
            //孙毅添加(主页查询)
            if(StringUtils.isNotEmpty(activityPlanIndexMain)){
                map.put("activityPlanIndexMain", activityPlanIndexMain);
            }
            activityPlanService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 会议通知录入页面跳转
     * */
    @RequestMapping(value = "/load-plan-edit.do",method = RequestMethod.GET)
    public String weekWorkStart(ModelMap modelMap,String id) {

        //根据id查找领导活动安排会议通知
        ActivityPlan activityPlan = new ActivityPlan();
        if (!StringUtils.isEmpty(id)) {
            activityPlan = activityPlanService.get(id);
        }
        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(),DateUtil.FORMAT);
        modelMap.addAttribute("sysDate",sysDate);
        modelMap.addAttribute("model",activityPlan);
        return "pubinfo/schedule/leader-arrange/activity-plan-edit";
    }

    /**
     * 领导活动安排会议通知新增/编辑保存
     * */
    @ResponseBody
    @RequestMapping(value = "/plan-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveWeekWork(ActivityPlan activityPlan,String sendTimeStr) {

        Map<String,Object> map = new HashMap<>(1);

        DicUser dicUser = getCurUser();
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("领导活动安排");
        if(StringUtils.isEmpty(activityPlan.getId())){
            sysLogVo.setRecordType(0);
        }else {
            sysLogVo.setRecordType(1);
        }

        if (!StringUtils.isEmpty(sendTimeStr)) {

            Date sendTime = DateUtil.stringToDate(sendTimeStr,DateUtil.FORMAT);
            activityPlan.setSendTime(sendTime);
        }

        try {
            activityPlanService.editSave(activityPlan, dicUser);
            LOG.info("ID为：" + activityPlan.getId() + "的领导活动安排会议通知保存成功！");
            map.put("result",true);

            sysLogVo.setEntityId(activityPlan.getId());
            sysLogVo.setEntityName(activityPlan.getContent());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error("领导活动安排会议通知：" + e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 会议通知逻辑删除
     * */
    @ResponseBody
    @RequestMapping(value = "/plan-delete.do", method = RequestMethod.POST)
    public Map<String,Object> logicDelete(String id) {

        Map<String, Object> map = new HashMap<>(1);

        try {
            ActivityPlan activityPlan = activityPlanService.get(id);
            //删除标志设为1
            activityPlan.setDelFlag("1");
            //保存领导活动安排会议通知

            activityPlanService.save(activityPlan);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("领导活动安排");
            sysLogVo.setRecordType(2);
            sysLogVo.setEntityId(activityPlan.getId());
            sysLogVo.setEntityName(activityPlan.getContent());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 下发会议通知
     * */
    @ResponseBody
    @RequestMapping(value = "/send-activity-plan.do", method = RequestMethod.POST)
    public Map<String,Object> sendPlan(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            ActivityPlan activityPlan = activityPlanService.get(id);
            //下发
            activityPlan.setStatus("1");
            //下发日期
            Date sysDate = DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT);
            activityPlan.setSendTime(sysDate);
            //保存
            activityPlanService.save(activityPlan);
            map.put("result",true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("领导活动安排");
            sysLogVo.setRecordType(17);
            sysLogVo.setEntityId(activityPlan.getId());
            sysLogVo.setEntityName(activityPlan.getContent());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result",false);
        }
        return map;
    }



    /**
     * 定时任务工作动态
     * */
    @ResponseBody
    @RequestMapping(value = "/activity-plan-time.do", method = RequestMethod.POST)
    public Map<String,Object> planTime(String indexMainRol) {

        Map<String, Object> map = new HashMap<>(3);
        try {
            List<ActivityPlan> activityPlans = activityPlanService.loadIndexMain(1, null, "-1");
            List<PlanReceipt> planReceipts = planReceiptService.loadIndexDate();
            List<HashMap<String,String>> list = activityPlanService.loadIndexMainDate(activityPlans,planReceipts);
            String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT);

            map.put("indexMainSysTime",sysDate);
            map.put("activityPlans",list);
            map.put("result",true);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result",false);
        }
        return map;
    }


}
