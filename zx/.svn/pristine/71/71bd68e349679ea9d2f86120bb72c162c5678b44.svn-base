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
import com.taiji.frame.model.vo.pubinfo.schedule.PlanReceiptVo;
import com.taiji.frame.service.pubinfo.schedule.ActivityPlanService;
import com.taiji.frame.service.pubinfo.schedule.PlanReceiptService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * @author BT4900
 * 领导活动安排会议通知反馈
 */

@Controller
@RequestMapping(value = "/plan-receipt")
public class PlanReceiptController extends BaseController<PlanReceipt> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private ActivityPlanService activityPlanService;

    @Autowired
    private PlanReceiptService planReceiptService;

    @Autowired
    private UtilService utilService;
    @Autowired
    private SysLogService sysLogService;


    /**
     * 领导活动安排会议回执页面跳转
     */
    @RequestMapping(value = "/load-receipt-list.do", method = RequestMethod.GET)
    public String load(ModelMap modelMap, String id, String feedbackDeptId) {
        //当前用户
        DicUser dicUser = getCurUser();
        //用户所在部门
        DicDept curDept = dicUser.getDicDept();
        modelMap.addAttribute("curDept", curDept.getJsonObject());
        //系统时间
        Date sysDate = utilService.getSysTime();

        if (null != feedbackDeptId && !"".equals(feedbackDeptId)) {

            ActivityPlan activityPlan = activityPlanService.get(id);
            //根据部门ID和workId查找部门反馈信息
            PlanReceipt planReceipt = planReceiptService.findReceiptByPlanIdAndDeptId(id, feedbackDeptId);

            if (planReceipt == null) {
                PlanReceipt receipt = new PlanReceipt();
                receipt.setActivityPlan(activityPlan);
                receipt.setDicDept(dicDeptService.get(feedbackDeptId));
                receipt.setStatus("0");
                receipt.setDelFlag("0");
                receipt.setUpdateTime(sysDate);
                planReceiptService.save(receipt);
            }
        }
        modelMap.addAttribute("planId", id);
        modelMap.addAttribute("feedbackDeptId", feedbackDeptId);

        return "pubinfo/schedule/leader-arrange/plan-receipt-list";
    }

    /**
     * load一周工作情况反馈数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-receipt-list", produces = "text/html;charset=UTF-8")
    public String loadReceiptList(Carrier<PlanReceipt> carrier, PlanReceiptVo planReceiptVo) {

        HashMap map = new HashMap(2);

        if (!StringUtils.isEmpty(planReceiptVo.getPlanId())) {
            map.put("planId", planReceiptVo.getPlanId());
        }

        if (!StringUtils.isEmpty(planReceiptVo.getDeptId())) {
            map.put("deptId", planReceiptVo.getDeptId());
        }
        if (!StringUtils.isEmpty(planReceiptVo.getStatus())) {
            List<String> statusList = OtherUtil.strToStringList(planReceiptVo.getStatus());
            map.put("statusList", statusList);
        }
        try {
            planReceiptService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 编辑领导活动安排反馈
     */
    @RequestMapping(value = "/plan-receipt-edit.do", method = RequestMethod.GET)
    public String planReceiptEdit(ModelMap modelMap, String id) {

        //获取当前登陆的用户信息
        DicUser user = getCurUser();

        ActivityPlan activityPlan = new ActivityPlan();
        PlanReceipt planReceipt = new PlanReceipt();


        if (!StringUtils.isEmpty(id)) {

            activityPlan = activityPlanService.get(id);
            //根据部门ID和planId查找部门反馈信息
            planReceipt = planReceiptService.findReceiptByPlanIdAndDeptId(id, user.getDicDept().getId());
        }

        Date sysDate = utilService.getSysTime();
        //获取上周一日期
        Date nextWeekMonday = DateUtil.getNextWeekMonday(sysDate);
        Date nextWeekSunday = DateUtil.getNextWeekSunday(sysDate);

        //转换为字符串
        String nextWeekMondayStr = DateUtil.dateToString(nextWeekMonday, DateUtil.FORMAT_DAY);
        String nextWeekSundayStr = DateUtil.dateToString(nextWeekSunday, DateUtil.FORMAT_DAY);
        String sysDateStr = DateUtil.dateToString(sysDate, DateUtil.FORMAT);

        modelMap.addAttribute("planReceipt", planReceipt);
        modelMap.addAttribute("nextWeekMondayStr", nextWeekMondayStr);
        modelMap.addAttribute("nextWeekSundayStr", nextWeekSundayStr);
        modelMap.addAttribute("sysDateStr", sysDateStr);

        if ("0".equals(activityPlan.getMeetingFlag())) {

            return "pubinfo/schedule/leader-arrange/meeting-edit";

        } else {
            return "pubinfo/schedule/leader-arrange/no-meeting-edit";
        }
    }

    /**
     * 会议回执新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/meeting-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveWeekWork(PlanReceiptVo planReceiptVo) {

        Map<String, Object> map = new HashMap<>(1);

        DicUser dicUser = getCurUser();

        String feedbackTimeStr = planReceiptVo.getFeedbackTimeStr();

        if (!StringUtils.isEmpty(feedbackTimeStr)) {

            Date feedbackTime = DateUtil.stringToDate(feedbackTimeStr, DateUtil.FORMAT);
            planReceiptVo.setFeedbackTime(feedbackTime);
        }

        try {
            PlanReceipt planReceipt = planReceiptService.editSave(planReceiptVo, dicUser);
            LOG.info("ID为：" + planReceipt.getId() + "的会议回执保存成功！");
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("会议回执");
            if(StringUtils.isEmpty(planReceiptVo)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(planReceipt.getId());
            sysLogVo.setEntityName(planReceipt.getActivityPlan().getContent());
            sysLogService.record(sysLogVo);

        } catch (Exception e) {
            LOG.error("领导活动安排会议通知：" + e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 会议回执逻辑删除
     */
    @ResponseBody
    @RequestMapping(value = "/receipt-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDelete(String id) {

        Map<String, Object> map = new HashMap<>(1);

        try {
            PlanReceipt planReceipt = planReceiptService.get(id);
            //删除标志设为1
            planReceipt.setDelFlag("1");
            //最后更新时间
            Date sysDate = utilService.getSysTime();
            planReceipt.setUpdateTime(sysDate);
            //保存领导活动安排会议通知
            planReceiptService.save(planReceipt);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("会议回执");
                sysLogVo.setRecordType(2);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(planReceipt.getId());
            sysLogVo.setEntityName(planReceipt.getActivityPlan().getContent());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 反馈回执回执信息
     */
    @ResponseBody
    @RequestMapping(value = "/report-receipt.do", method = RequestMethod.POST)
    public Map<String, Object> report(String id) {

        Map<String, Object> map = new HashMap<>(1);
        //根据ID查找一周工作情况反馈信息
        try {
            PlanReceipt planReceipt = planReceiptService.get(id);
            planReceipt.setStatus("1");
            //最后更新时间
            Date sysDate = utilService.getSysTime();
            planReceipt.setUpdateTime(sysDate);
            //报送时间
            planReceipt.setFeedbackTime(sysDate);
            planReceiptService.save(planReceipt);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("会议回执");
            sysLogVo.setRecordType(15);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(planReceipt.getId());
            sysLogVo.setEntityName(planReceipt.getActivityPlan().getContent());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }
        return map;
    }

    /**
     * 撤回会议回执反馈
     */
    @ResponseBody
    @RequestMapping(value = "/back-receipt.do", method = RequestMethod.POST)
    public Map<String, Object> back(String id) {

        Map<String, Object> map = new HashMap<>(1);

        try {
            PlanReceipt planReceipt = planReceiptService.get(id);
            planReceipt.setStatus("0");
            //最后更新时间
            Date sysDate = utilService.getSysTime();
            planReceipt.setUpdateTime(sysDate);
            planReceiptService.save(planReceipt);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("会议回执");
            sysLogVo.setRecordType(16);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(planReceipt.getId());
            sysLogVo.setEntityName(planReceipt.getActivityPlan().getContent());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }
        return map;
    }

    /**
     * 查收会议回执反馈信息
     *
     * @param id 会议回执反馈ID
     */
    @ResponseBody
    @RequestMapping(value = "/check-plan-receipt.do", method = RequestMethod.POST)
    public Map<String, Object> checkReceipt(String id) {

        Map<String, Object> map = new HashMap<>(1);

        if (!StringUtils.isEmpty(id)) {
            //根据Id查找反馈信息
            try {
                PlanReceipt planReceipt = planReceiptService.get(id);
                planReceipt.setStatus("2");
                //最后更新时间
                Date sysDate = utilService.getSysTime();
                planReceipt.setUpdateTime(sysDate);
                planReceiptService.save(planReceipt);
                map.put("result", true);

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("会议回执");
                sysLogVo.setRecordType(9);
                sysLogVo.setResult("true");
                sysLogVo.setEntityId(planReceipt.getId());
                sysLogVo.setEntityName(planReceipt.getActivityPlan().getContent());
                sysLogService.record(sysLogVo);
            } catch (Exception e) {
                LOG.error("查收会议回执失败:" + e.getMessage(), e);
                map.put("result", false);
            }
        }
        return map;
    }

    /**
     * 根据ID查看领导活动安排反馈信息
     *
     * @param id 反馈ID
     */
    @RequestMapping(value = "/view-plan-receipt.do", method = RequestMethod.GET)
    public String viewFeedback(ModelMap modelMap, String id) {
        //根据ID查找反馈信息
        PlanReceipt planReceipt = planReceiptService.get(id);
        String meetingFlag = planReceipt.getActivityPlan().getMeetingFlag();
        modelMap.addAttribute("model", planReceipt);

        if ("0".equals(meetingFlag)) {
            return "pubinfo/schedule/leader-arrange/meeting-view";
        } else {
            return "pubinfo/schedule/leader-arrange/no-meeting-view";
        }
    }

    /**
     * 根据ids查找会议回执信息，会议回执导出预览
     */
    @RequestMapping(value = "/plan-receipt-preview.do", method = RequestMethod.GET)
    public String exportPlanReceipt(ModelMap modelMap, String id) {

        Date sysDate = utilService.getSysTime();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(sysDate);
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        PlanReceipt planReceipt = planReceiptService.get(id);

        modelMap.addAttribute("planReceipt", planReceipt);
        modelMap.addAttribute("year", year);
        modelMap.addAttribute("month", month);
        modelMap.addAttribute("day", day);
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("会议回执导出预览");
        sysLogVo.setRecordType(7);
        sysLogVo.setResult("true");
        sysLogVo.setEntityId(planReceipt.getId());
        sysLogVo.setEntityName(planReceipt.getActivityPlan().getContent());
        sysLogService.record(sysLogVo);
        String flag = planReceipt.getActivityPlan().getMeetingFlag();
        if ("0".equals(flag)) {
            return "pubinfo/schedule/leader-arrange/meeting-export";
        } else {
            return "pubinfo/schedule/leader-arrange/no-meeting-export";

        }
    }

    /**
     * 根据ids查找会议回执信息，会议回执打印
     */
    @ResponseBody
    @RequestMapping(value = "/get-planReceipt-list.do", method = RequestMethod.POST)
    public List<JSON> getPrintData(String data, String type) {

        List<PlanReceipt> planReceipts = getReceiptList(data, type);

        List<JSON> jsonObjectList = new ArrayList<>();

        for (PlanReceipt planReceipt : planReceipts) {

            jsonObjectList.add(planReceipt.getJsonObject());
        }
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("会议回执");
        sysLogVo.setRecordType(10);
        sysLogVo.setResult("true");
        sysLogVo.setEntityId("");
        sysLogVo.setEntityName("");
        sysLogService.record(sysLogVo);
        return jsonObjectList;
    }

    private List<PlanReceipt> getReceiptList(String data, String type) {
        List<PlanReceipt> planReceipts = new ArrayList<>();

        if ("part".equals(type)) {
            JSONArray array = JSONArray.fromObject(data);
            for (int i = 0; i < array.size(); i++) {
                PlanReceipt planReceipt = planReceiptService.get((String) array.get(i));
                if ("2".equals(planReceipt.getStatus())) {
                    planReceipts.add(planReceipt);
                }
            }
        } else {
            JSONObject jsonObject = JSONObject.fromObject(data);
            String planId = jsonObject.getString("planId");
            //根据planId查找会议回执信息
            planReceipts = planReceiptService.findReceiptByPlanId(planId);
        }
        return planReceipts;
    }
}
