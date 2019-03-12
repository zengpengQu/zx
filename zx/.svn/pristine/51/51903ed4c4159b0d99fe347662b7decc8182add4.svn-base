package com.taiji.frame.controller.pubinfo.schedule;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.schedule.WeekWork;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkFeedback;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkGuide;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkStudy;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.schedule.WeekWorkVo;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkFeedbackVo;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkGuideVo;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkStudyVo;
import com.taiji.frame.service.pubinfo.schedule.WeekWorkService;
import com.taiji.frame.service.pubinfo.schedule.WorkFeedbackService;
import com.taiji.frame.service.pubinfo.schedule.WorkGuideService;
import com.taiji.frame.service.pubinfo.schedule.WorkStudyService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * @author admin
 * 一周工作安排
 */
@Controller
@RequestMapping(value = "/week-work")
public class WeekWorkController extends BaseController<WeekWork> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private WeekWorkService weekWorkService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private WorkFeedbackService workFeedbackService;

    @Autowired
    private WorkGuideService workGuideService;

    @Autowired
    private WorkStudyService workStudyService;

    @Autowired
    private DicUserService dicUserService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     * id(indexmain) 孙毅添加
     * */
    @RequestMapping(value = "/week-work-list", method = RequestMethod.GET)
    public  String list(Map<String, Object> map,String id){
        //当前用户
        DicUser dicUser = getCurUser();
        //用户所在部门
        DicDept curDept = dicUser.getDicDept();
        map.put("curDept", curDept);
        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(),DateUtil.FORMAT_DAY);
        map.put("sysDate",sysDate);
        //孙毅添加
        map.put("weekWorkIndexMain",id);

        return "pubinfo/schedule/week-work/week-work-list";
    }


    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-work-list.do", produces = "text/html;charset=UTF-8")
    public String workListLoad(Carrier<WeekWork> carrier, WeekWorkVo weekWorkVo,String weekWorkIndexMain) {
        HashMap map = new HashMap(16);
        try {

            String startDateStr = weekWorkVo.getStartDateStr();
            String endDateStr = weekWorkVo.getEndDateStr();
            if(!StringUtils.isEmpty(startDateStr)){
                map.put("startDate", startDateStr);
            }
            if(!StringUtils.isEmpty(endDateStr)){
                map.put("endDate", endDateStr);
            }
            if (!StringUtils.isEmpty(weekWorkVo.getStatus())) {
                List<String> statusList = OtherUtil.strToStringList(weekWorkVo.getStatus());
                map.put("statusList", statusList);
            }
            //孙毅添加
            if(StringUtils.isNotEmpty(weekWorkIndexMain)){
                map.put("weekWorkIndexMain", weekWorkIndexMain);
            }
            weekWorkService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 一周工作情况发起页面跳转
     * */
    @RequestMapping(value = "/load-work-start.do",method = RequestMethod.GET)
    public String weekWorkStart(ModelMap modelMap,String id) {

        //根据id查找一周工作情况
        WeekWork weekWork = new WeekWork();
        if (!StringUtils.isEmpty(id)) {
            weekWork = weekWorkService.get(id);
        }
        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(),DateUtil.FORMAT);
        modelMap.addAttribute("sysDate",sysDate);
        modelMap.addAttribute("model",weekWork);
        return "pubinfo/schedule/week-work/week-work-start";
    }

    /**
     * 一周工作情况新增/编辑保存
     * */
    @ResponseBody
    @RequestMapping(value = "/start-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveWeekWork(WeekWorkVo weekWorkVo) {

        Map<String,Object> map = new HashMap<>(1);

        try {
            WeekWork weekWork = weekWorkService.editSave(weekWorkVo);
            LOG.info("ID为：" + weekWork.getId() + "的一周工作安排保存成功！");
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("一周工作安排");
            if(StringUtils.isEmpty(weekWorkVo.getId())){
                sysLogVo.setRecordType(0);
            }else{
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(weekWork.getId());
            sysLogVo.setEntityName(weekWork.getMeeting());
            sysLogService.record(sysLogVo);

        } catch (Exception e) {
            LOG.error("一周工作安排：" + e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 一周工作情况删除
     * */
    @ResponseBody
    @RequestMapping(value = "/work-delete.do", method = RequestMethod.POST)
    public Map<String,Object> logicDelete(String id) {

        Map<String, Object> map = new HashMap<>(1);

        try {
            WeekWork weekWork = weekWorkService.get(id);
            //删除标志设为1
            weekWork.setDelFlag("1");
            //保存一周工作情况
            weekWorkService.save(weekWork);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("一周工作安排");
                sysLogVo.setRecordType(2);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(weekWork.getId());
            sysLogVo.setEntityName(weekWork.getMeeting());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 下发一周工作安排
     * */
    @ResponseBody
    @RequestMapping(value = "/send-week-work.do", method = RequestMethod.POST)
    public Map<String,Object> sendWeekWork(String id) {

        Map<String, Object> map = new HashMap<>(1);
        try {
            WeekWork weekWork = weekWorkService.get(id);
            //下发
            weekWork.setStatus("1");
            //下发日期
            Date sysDate = DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT);
            weekWork.setSendDate(sysDate);
            //保存
            weekWorkService.save(weekWork);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("一周工作安排");
            sysLogVo.setRecordType(17);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(weekWork.getId());
            sysLogVo.setEntityName(weekWork.getMeeting());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 一周工作情况反馈页面跳转
     * */
    @RequestMapping(value = "/load-work-feedback.do",method = RequestMethod.GET)
    public String workFeedback(ModelMap modelMap,String id) {

        WeekWork weekWork = new WeekWork();
        WorkFeedbackVo workFeedbackVo = new WorkFeedbackVo();
        //获取当前登陆的用户信息
        DicUser user = getCurUser();
        //根据ID获取一周工作情况基础信息
        if (StringUtils.isNotEmpty(id)) {
            weekWork = weekWorkService.get(id);
            //根据部门ID和workId查找部门反馈信息
            WorkFeedback workFeedback = workFeedbackService.findFeedbackByWorkIdAndDeptId(id,user.getDicDept().getId());
            String feedbackId;
            List<WorkGuideVo> workGuideList = new ArrayList<>();
            List<WorkStudyVo> workStudyList = new ArrayList<>();

            if (workFeedback != null) {
                feedbackId = workFeedback.getId();
                //根据feedbackId查找下周局级领导带班情况
                workGuideList = workGuideService.findWorkGuideByFeedbackId(feedbackId);
                //根据feedbackId查找下周局级领导离京和脱产学习情况
                workStudyList = workStudyService.findWorkStudyByFeedbackId(feedbackId);
                //组装workFeedbackVo
                BeanUtils.copyProperties(workFeedback,workFeedbackVo);
                //报送日期格式化
                String feedbackDateStr = DateUtil.dateToString(workFeedback.getFeedbackDate(),DateUtil.FORMAT_DAY);
                workFeedbackVo.setFeedbackDateStr(feedbackDateStr);
            }else {
                WorkFeedback feedback = new WorkFeedback();
                feedback.setWeekWork(weekWork);
                feedback.setDicDept(user.getDicDept());
                feedback.setStatus("0");
                feedback.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT));
                feedback.setDelFlag("0");
                workFeedbackService.save(feedback);
                feedbackId = feedback.getId();
                //组装workFeedbackVo
                BeanUtils.copyProperties(feedback,workFeedbackVo);
            }
            workFeedbackVo.setWorkGuideList(workGuideList);
            workFeedbackVo.setWorkStudyList(workStudyList);
        }
        //部门人员信息
        List<DicUser> userList = dicUserService.findByDept(user.getDicDept().getId());
        //系统时间
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.addAttribute("user",user);
        modelMap.addAttribute("userList",userList);
        modelMap.addAttribute("sysDate",sysDate);
        modelMap.addAttribute("weekWork",weekWork);
        modelMap.addAttribute("workFeedbackVo",workFeedbackVo);

        return "pubinfo/schedule/week-work/week-work-feedback";
    }

    /**
     * 一周工作情况反馈保存
     * */
    @ResponseBody
    @RequestMapping(value = "/work-feedback-save.do", method = RequestMethod.POST)
    public Map<String,Object> saveFeedback(WorkFeedbackVo workFeedbackVo) {

        Map<String,Object> map = new HashMap<>(5);

        //保存一周工作情况反馈信息
        try {
            WorkFeedback workFeedback = workFeedbackService.saveFeedback(workFeedbackVo);
            map.put("result",true);
            map.put("id",workFeedback.getWeekWork().getId());
            map.put("feedbackDeptId",workFeedback.getDicDept().getId());
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("一周工作安排反馈");
            sysLogVo.setRecordType(15);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workFeedback.getId());
            sysLogVo.setEntityName(workFeedback.getCreateName());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error("一周工作情况反馈失败" + e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 法定节假日局级领导带班情况删除
     * */
    @ResponseBody
    @RequestMapping(value = "/work-guide-delete.do", method = RequestMethod.POST)
    public Map<String,Object> logicGuideDelete(String id) {

        Map<String,Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            try {
                WorkGuide workGuide = workGuideService.get(id);
                workGuide.setDelFlag("1");
                workGuideService.save(workGuide);
                map.put("result",true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("局级领导带班情况删除");
                sysLogVo.setRecordType(2);
                sysLogVo.setResult("true");
                sysLogVo.setEntityId(workGuide.getId());
                sysLogVo.setEntityName(workGuide.getName());
                sysLogService.record(sysLogVo);
            } catch (Exception e) {
                LOG.error("法定节假日局级领导带班情况删除失败" + e.getMessage(),e);
                map.put("result",false);
            }
        } else {
            map.put("result",true);
        }
        return map;
    }

    /**
     * 下周局级领导离京和脱产学习情况信息删除
     * */
    @ResponseBody
    @RequestMapping(value = "/work-study-delete.do", method = RequestMethod.POST)
    public Map<String,Object> logicStudyDelete(String id) {

        Map<String,Object> map = new HashMap<>(1);

        try {
            WorkStudy workStudy = workStudyService.get(id);
            workStudy.setDelFlag("1");
            workStudyService.save(workStudy);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("下周局级领导离京和脱产学习情况信息删除");
            sysLogVo.setRecordType(2);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workStudy.getId());
            sysLogVo.setEntityName(workStudy.getName());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error("下周局级领导离京和脱产学习情况信息删除失败" + e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 定时任务工作动态
     * */
    @ResponseBody
    @RequestMapping(value = "/week-work-time.do", method = RequestMethod.POST)
    public Map<String,Object> planTime() {

        Map<String, Object> map = new HashMap<>(3);
        try {
            List<WeekWork> weekWorks = weekWorkService.loadIndexMain(1, null, "-1");

            List<HashMap<String,String>> list = weekWorkService.loadIndexMainDate(weekWorks);

            map.put("activityPlans",list);
            map.put("result",true);
        } catch (Exception e) {
            LOG.error(e.getMessage(), e);
            map.put("result",false);
        }
        return map;
    }






}
