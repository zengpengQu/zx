package com.taiji.frame.controller.inspection.place;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.inspection.place.Feedback;
import com.taiji.frame.model.entity.inspection.place.Place;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.inspection.place.FeedbackVo;
import com.taiji.frame.service.inspection.place.FeedbackService;
import com.taiji.frame.service.inspection.place.PlaceService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author sy
 * 视察考察调研活动
 */
@Controller
@RequestMapping(value = "/feedback")
public class FeedbackController extends BaseController<Feedback> {

    private static final Logger LOG = LoggerFactory.getLogger(FeedbackController.class);

    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private PlaceService placeService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 新增反馈  页面跳转
     */
    @RequestMapping(value = "/handle-feedback", method = RequestMethod.GET)
    public String placeFeedback(String id, ModelMap modelMap) {
        Place place = new Place();
        if (!StringUtils.isEmpty(id)) {
            //根据ID查找活动安排信息，作数据回显
            place = placeService.get(id);
        }
        modelMap.addAttribute("placeList", place);
        return "inspection/place/place-feedback-up";
    }

    /**
     * 新增 反馈信息保存
     */
    @ResponseBody
    @RequestMapping(value = "/feedback-place-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveFeedback(FeedbackVo feedbackVo ) {
        Map<String, Object> map = new HashMap<>(16);
        Feedback feedback = new Feedback();
        try {
            DicUser user = getCurUser();
            //当前用户部门 ，即反馈部门
            DicDept curDept = user.getDicDept();
            BeanUtils.copyProperties(feedbackVo, feedback);
            //设置活动信息,当前用户部门
            Place place =  placeService.get(feedbackVo.getPlaceId());
            if("1".equals(feedbackVo.getFeedbackFlag())){
                place.setReportState("8");
            }
            feedback.setPlace(place);
            feedback.setDicDept(curDept);
            //设置实际开始，结束时间 反馈部门名称
            feedback.setActualBeginTime(DateUtil.stringToDate(feedbackVo.getBeginTimeStr(), DateUtil.FORMAT_DAY));
            feedback.setActualEndTime(DateUtil.stringToDate(feedbackVo.getEndTimeStr(), DateUtil.FORMAT_DAY));
            feedback.setOrgName(curDept.getDeptName());
            //设置系统时间做 反馈时间，反馈人
            feedback.setFeedbackTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT));
            feedback.setFeedbackMan(user.getEmpName());
            //添加反馈信息
            feedbackService.save(feedback);
            map.put("result",true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("视察考察调研活动反馈");
                sysLogVo.setRecordType(15);
                sysLogVo.setEntityId(feedback.getId());
                sysLogVo.setEntityName(feedback.getFeedbackMan());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 查看反馈页面跳转
     */
    @RequestMapping(value = "/load-feedback-place.do", method = RequestMethod.GET)
    public String loadPlaceFeedback(String id, ModelMap modelMap) {
        Place place = new Place();
        List<Feedback> feedback= new ArrayList<>();
        if (!StringUtils.isEmpty(id)) {
            //根据ID查找活动安排信息，作数据回显
            place = placeService.get(id);
            feedback = feedbackService.find(" from Feedback where place.id = '"+id+"'");
        }
        modelMap.addAttribute("placeList", place);
        modelMap.addAttribute("feedbackList", feedback);
        return "inspection/place/place-feedback-load";
    }


}
