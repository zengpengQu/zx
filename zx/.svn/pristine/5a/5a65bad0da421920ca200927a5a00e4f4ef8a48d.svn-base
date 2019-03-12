package com.taiji.frame.controller.inspection.place;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.inspection.place.*;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.inspection.place.DateTypeVo;
import com.taiji.frame.model.vo.inspection.place.PlaceVo;
import com.taiji.frame.service.inspection.place.*;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.ExecuteDAO;
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

import java.util.*;


/**
 * @author sy
 * 活动安排
 */
@Controller
@RequestMapping(value = "/place")
public class PlaceController extends BaseController<Place> {

    private static final Logger LOG = LoggerFactory.getLogger(PlaceController.class);

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private PlaceService placeService;

    @Autowired
    private DateTypeService dateTypeService;

    @Autowired
    private ExecuteDAO executeDAO;

    @Autowired
    private UtilService utilService;

    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private CorrectService correctService;

    @Autowired
    private DistrictService districtService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 页面跳转
     */
    @RequestMapping(value = "/place-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map,String id) {

        //当前用户
        DicUser dicUser = getCurUser();
        //用户所在部门
        DicDept curDept = dicUser.getDicDept();
        map.put("curDept", curDept.getJsonObject());
        map.put("dicDept",curDept.getId());
        map.put("placeIndexMainId", id);
        return "inspection/place/place-list";
    }



    /**
     * load grid单位表格数据
     * placeIndexMainId 主页传来的placeID
     */
    @ResponseBody
    @RequestMapping(value = "/load-place-List.do", produces = "text/html;charset=UTF-8")
    public String placeListLoad(Carrier<Place> carrier, String title,String status,
                                String deptName, String place,String nodeTime,String actType,String deptId,
                                String createTime,String placeIndexMainId) {
        HashMap map = new HashMap(16);
        try {
            if (StringUtils.isNotEmpty(title)) {
                map.put("title", title.replace(" ","")); }
            if (StringUtils.isNotEmpty(deptName)) {
                map.put("deptName", deptName); }
            if (StringUtils.isNotEmpty(deptId)) {
                map.put("deptId", deptId); }
            if (StringUtils.isNotEmpty(status)) {
                map.put("status", status); }
            if (StringUtils.isNotEmpty(place)) {
                map.put("place", place); }
            if (StringUtils.isNotEmpty(nodeTime)) {
                map.put("nodeTime", nodeTime); }
            if (StringUtils.isNotEmpty(actType)) {
                map.put("actType", actType); }
            if (StringUtils.isNotEmpty(createTime)) {
                map.put("createTime", createTime); }
            if (StringUtils.isNotEmpty(placeIndexMainId)) {
                map.put("placeIndexMainId", placeIndexMainId); }
            placeService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 上报/查收 活动安排
     */
    @ResponseBody
    @RequestMapping(value = "/handle-place.do", method = RequestMethod.POST)
    public Map<String, Object> handleDuty(String id, String type) {
        Map<String, Object> map = new HashMap<>(1);
        try {
            //根据id查找活动安排信息
            Place pace = placeService.get(id);
            List<DateType> lists = pace.getDateTypeLists();
            //更新状态
            pace.setReportState(type);
            //记录操作时间
            Date sysDate = utilService.getSysTime();
            pace.setCreateTime(DateUtil.dateToDateByFormat(sysDate, DateUtil.FORMAT));
            //保存数据
            placeService.save(pace);

            if (pace.getDateTypeLists() != null) {
                pace.setDateTypeLists(placeService.clashSaveNew(pace.getDateTypeLists(),lists));
            }
            String isResult = "0";
            if (pace.getDateTypeLists() != null) {
                for (int i = 0; i < pace.getDateTypeLists().size(); i++) {
                    if (!"0".equals(pace.getDateTypeLists().get(i).getIsClash())) {
                        isResult = pace.getDateTypeLists().get(i).getIsClash();
                        break;
                    }
                    if (!"0".equals(pace.getDateTypeLists().get(i).getIsClashDay())) {
                        isResult = pace.getDateTypeLists().get(i).getIsClashDay();
                        break;
                    }
                    if (!"0".equals(pace.getDateTypeLists().get(i).getIsClashYear())) {
                        isResult = pace.getDateTypeLists().get(i).getIsClashYear();
                        break;
                    }
                }
            }
            map.put("isResult",isResult);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("视察考察调研活动安排");
            if("1".equals(type)){
                sysLogVo.setRecordType(8);
            }else if("2".equals(type) || "6".equals(type)){
                sysLogVo.setRecordType(9);
            }
                sysLogVo.setEntityId(pace.getId());
                sysLogVo.setEntityName(pace.getTitle());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);


        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 新增/编辑页面跳转
     */
    @RequestMapping(value = "/load-place-edit", method = RequestMethod.GET)
    public String placeEdit(String id, ModelMap modelMap,String type) {
        //获取调整信息
        if("correct".equals(type)){
            List<Correct> corrects = correctService.findByPlaceId(id,true);
            modelMap.addAttribute("correctType", corrects);
            modelMap.addAttribute("correctOuUpdate", "correct");

        }
        //获取当前用户信息
        DicUser user = getCurUser();
        modelMap.addAttribute("dicUser", user);

        //获取省份信息
        List<District> districtList =  districtService.districtParentCode();
        modelMap.addAttribute("districtList", districtList);

        Place place = new Place();
        if (StringUtils.isNotEmpty(id)) {
            //根据ID查找活动安排信息，作数据回显
            place = placeService.get(id);
            modelMap.addAttribute("systemDateAddYear",  place.getNowTime());

        }else {
            Date date = new Date();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            calendar.add(Calendar.YEAR, 1);
            String da = DateUtil.dateToString(calendar.getTime(),DateUtil.FORMAT_YYYY);
            modelMap.addAttribute("systemDateAddYear",da);
        }
        modelMap.addAttribute("placeList", place);
        return "inspection/place/place-edit";
    }


    @ResponseBody
    @RequestMapping(value = "/place-cancel.do", method = RequestMethod.POST)
    public Map<String, Object> cancelPlace(String id, String status) {
        Map<String, Object> map = new HashMap<>(1);

        try {
            Place pace = placeService.get(id);
            pace.setReportState("0");
            List<DateType> date = pace.getDateTypeLists();
            for (DateType da:date) {
                da.setIsClash("0");
                da.setIsClashDay("0");
                da.setIsClashYear("0");
                String ids = da.getPlace().getId();
                placeService.clashUpDateNew(da.getBeginTime(),ids,da.getId());
            }
            if ("yes".equals(status)) {
                pace.setDelFlag("0");
            } else {
                pace.setDelFlag("1");
            }
            placeService.save(pace);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }



    /**
     * 删除活动安排 保存
     */
    @ResponseBody
    @RequestMapping(value = "/place-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deletePlace(String id ,String status) {
        Map<String, Object> map = new HashMap<>(1);
        try {
            Place pace = placeService.get(id);
            List<DateType> date = pace.getDateTypeLists();
            for (DateType da:date) {
                String ids = da.getPlace().getId();
                placeService.clashUpDateNew(da.getBeginTime(),ids,da.getId());
                da.setDelFlag("1");
            }
            pace.setDateTypeLists(date);
            if("yes".equals(status)){
                pace.setDelFlag("0");
            }else {
                pace.setDelFlag("1");
            }
            placeService.save(pace);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("视察考察调研活动安排");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityId(pace.getId());
            sysLogVo.setEntityName(pace.getTitle());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 安排冲突 页面跳转 默认省份冲突
     */
    @RequestMapping(value = "/load-clash",method = RequestMethod.GET)
    public String clashListLoad(ModelMap modelMap,String place) {
        return "inspection/place/place-clash-list";
    }





    /**
     * 新增/编辑活动安排 保存
     */
    @ResponseBody
    @RequestMapping(value = "/place-save.do", method = RequestMethod.POST)
    public Map<String, Object> savePlaceNew(PlaceVo placeVo ) {
        Map<String, Object> map = new HashMap<>(4);
        Place pace = new Place();
        try{
            if("5".equals(placeVo.getReportState())){
                //状态为5，调整操作，将调整数据状态改变为2（已调整）
                correctService.findByPlaceId(placeVo.getId(),false);
            }
            if("correct".equals(placeVo.getCorrectPlace())){
                placeVo.setReportState("5");
            }

            BeanUtils.copyProperties(placeVo, pace);
            String nowTime = placeVo.getNowTime();
            pace.setNowTime(nowTime);
            //设置保存修改时间

            if("1".equals(placeVo.getReportState())){
                //状态为5，调整操作，将调整数据状态改变为2（已调整）
                pace.setCreateTime(utilService.getSysTime());
            }
            pace.setBeginTime(utilService.getSysTime());
            if(StringUtils.isNotEmpty(placeVo.getId())){
                //place1  数据库已有数据，确保部门不变
                Place place1 = placeService.get(pace.getId());
                pace.setCreateTime(place1.getCreateTime());
                pace.setDicDept(place1.getDicDept());
            }
            //pace.setId(placeVo.getId());
            pace.setActTypeId(placeVo.getActTypeName());
            pace.setDelFlag("0");
            //获取当前登陆用户信息，进行保存
            DicUser user = getCurUser();
            pace.setDicUser(user);
            //反馈状态
            Feedback feedback = new Feedback();
            if(StringUtils.isNotEmpty(placeVo.getFeedbackId())){
                feedback = feedbackService.get(placeVo.getFeedbackId());
            }else {
                feedback.setId("0");
            }
            pace.setFeedback(feedback);

            try {
                if (placeVo.getDateTypeList() != null) {
                    if (0 < placeVo.getDateTypeList().size()) {
                        for (int i = 0; i < placeVo.getDateTypeList().size(); i++) {
                            DateTypeVo dateTypeVo = placeVo.getDateTypeList().get(i);
                            //判断开始时间是否为空和师傅与年度相符
                            if(StringUtils.isEmpty(dateTypeVo.getBeginTimeStr())){
                                map.put("result", true);
                                map.put("resultNo","yes");
                                map.put("resultNoStr","第"+(i+1)+"行开始时间不能为空");
                                return map;
                            }else {
                                if(!nowTime.equals(DateUtil.stringToString(dateTypeVo.getBeginTimeStr(),DateUtil.FORMAT_YYYY))){
                                    map.put("result", true);
                                    map.put("resultNo","yes");
                                    map.put("resultNoStr","第"+(i+1)+"行开始时间与年度不相符");
                                    return map;
                                }

                            }
                            //判断结束时间是否为空和师傅与年度相符
                            if(StringUtils.isEmpty(dateTypeVo.getEndTimeStr())){
                                map.put("result", true);
                                map.put("resultNo","yes");
                                map.put("resultNoStr","第"+(i+1)+"行结束时间不能为空");
                                return map;
                            }else {
                                if(!nowTime.equals(DateUtil.stringToString(dateTypeVo.getEndTimeStr(),DateUtil.FORMAT_YYYY))){
                                    map.put("result", true);
                                    map.put("resultNo","yes");
                                    map.put("resultNoStr","第"+(i+1)+"行结束时间与年度不相符");
                                    return map;
                                }
                            }
                            //判断省份
                            if(StringUtils.isEmpty(dateTypeVo.getPlaceIdStr())){
                                map.put("result", true);
                                map.put("resultNo","yes");
                                map.put("resultNoStr","第"+(i+1)+"行省份不能为空");
                                return map;
                            }
                            District district = districtService.get(dateTypeVo.getPlaceIdStr());
                            dateTypeVo.setPlace(district);
                        }
                    }
                }
                List<DateType> list = new ArrayList<>();
                if (StringUtils.isNotEmpty(placeVo.getId())) {
                    List<DateTypeVo> p = placeVo.getDateTypeList();
                    List<DateType> p1 = new ArrayList<>();
                    //修改 已有或无数据
                    if (p != null) {
                       for (int i = 0; i < p.size(); i++) {
                            String id = p.get(i).getId();
                            if (id != null) {
                                DateType dateType = dateTypeService.get(id);
                                if (dateType != null) {
                                    list.add(dateType);
                                }
                            }
                        }
                        p1 = placeService.clashSaveNew(p, p1, pace);
                    }
                    pace.setDateTypeLists(p1);
                } else {
                    List<DateTypeVo> p = placeVo.getDateTypeList();
                    List<DateType> p1 = new ArrayList<>();
                    if (p != null) {
                        p1 = placeService.clashSaveNew(p, p1, pace);
                    }
                    pace.setDateTypeLists(p1);
                }
                executeDAO.clear();
                placeService.save(pace);
                if (pace.getId() != null) {
                    map.put("placeIdStr", pace.getId());
                }

                if (pace.getDateTypeLists() != null) {
                    pace.setDateTypeLists(placeService.clashSaveNew(pace.getDateTypeLists(),list));
                }
                String isResult = "0";
               if (pace.getDateTypeLists() != null) {
                    for (int i = 0; i < pace.getDateTypeLists().size(); i++) {
                        if (!"0".equals(pace.getDateTypeLists().get(i).getIsClash())) {
                            isResult = pace.getDateTypeLists().get(i).getIsClash();
                            break;
                        }
                        if (!"0".equals(pace.getDateTypeLists().get(i).getIsClashDay())) {
                            isResult = pace.getDateTypeLists().get(i).getIsClashDay();
                            break;
                        }
                        if (!"0".equals(pace.getDateTypeLists().get(i).getIsClashYear())) {
                            isResult = pace.getDateTypeLists().get(i).getIsClashYear();
                            break;
                        }
                    }
                }
                map.put("isResult",isResult);
            }catch (Exception e){
                map.put("resultNo","yes");
            }
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("视察考察调研活动安排");
            if (StringUtils.isNotEmpty(placeVo.getId())){
                sysLogVo.setRecordType(1);
            }else {
                sysLogVo.setRecordType(0);
            }
            sysLogVo.setEntityId(pace.getId());
            sysLogVo.setEntityName(pace.getTitle());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


}
