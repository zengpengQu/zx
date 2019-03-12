package com.taiji.frame.controller.foreignaffairs.council;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.council.Attendance;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.council.CongressVo;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicUserService;
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
import org.springframework.web.bind.annotation.*;
import com.taiji.frame.service.foreignaffairs.council.CongressService;
import com.taiji.frame.service.foreignaffairs.council.AttendanceService;
import com.taiji.frame.model.entity.foreignaffairs.council.Congress;

import java.util.*;

/**
 * @author sy
 * Created by suny on 2018/7/4.
 * 会议记录controller
 */


@Controller
@RequestMapping(value="/council")
public class CongressController  extends BaseController<Congress> {
    private static final Logger LOG = LoggerFactory.getLogger(CongressController.class);

    @Autowired
    private CongressService congressService;

    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private DicUserService dicUserService;

    @Autowired
    private DicDeptService dicDeptService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/congress-info-list", method = RequestMethod.GET)
    public String congressInFoList(Map<String, Object> map) {
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        map.put("sysDate", sysDate);
        return "foreignaffairs/council/congress-info-list";
    }


    /**
     *会议记录查询
     * @param carrier
     * @param groupName  会议标题
     * @param leaderName 会议地点
     * @param startDate  会议时间
     * @return
     */
    @ResponseBody
    @RequestMapping( value = "/load-congress-list.do",produces = "text/html;charset=UTF-8")
    public String congressInFoListLoad (Carrier<Congress> carrier, String groupName, String leaderName,
                                        String startDate) {
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(groupName)) {
                map.put("title", "%" + groupName.replace(" ","") + "%");
            }
            if (!StringUtils.isEmpty(leaderName)) {
                map.put("meetingSite", "%" + leaderName.replace(" ","") + "%");
            }
            if (!StringUtils.isEmpty(startDate)) {
                map.put("time", startDate);
            }
            congressService.Load(carrier,map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 新增/编辑页面跳转
     */
    @RequestMapping(value = "/congress-info-edit", method = RequestMethod.GET)
    public String congressEdit(ModelMap modelMap,String id) {
        List<Congress> congressList = congressService.getAll();
        modelMap.addAttribute("congressList", congressList);
        String sysDate = DateUtil.dateToString(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        modelMap.put("sysDate", sysDate);
        //根据ID获取当前会议记录情况ID
        if (!StringUtils.isEmpty(id)) {
            Congress congress = congressService.get(id);
            modelMap.addAttribute("loadCongress", congress);
        }
        //查询到部门表中外事局ID
        // 根据ID查询外事局人员的姓名
        DicDept dicDept =  dicDeptService.getByDeptName("外事局");
        List<DicDept> belongDept = dicDeptService.getBelongDeptOrederById(dicDept.getId());
        Map<String, List<DicUser>> map = new LinkedHashMap<>(belongDept.size());
        for (int i=0;i<belongDept.size();i++) {
            DicDept dept = belongDept.get(i);
            if(!dicDept.getId().equals(dept.getId())){
                map.put(dept.getDeptName(),dicUserService.findByDept(dept.getId()));
            }
        }
        modelMap.put("dicUserListCongress", map);
        return "foreignaffairs/council/congress-edit";
    }


    /**
     * 添加会议记录信息
     */

    @ResponseBody
    @RequestMapping(value = "/congress-info-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveCongress(CongressVo congressVo) {
        Map<String, Object> map = new HashMap<>(1);
        try {
            Congress congress = new Congress();
            BeanUtils.copyProperties(congressVo, congress);
            congress.setAttendence(congressVo.getUserNames());
            congress.setDelFlag("0");
            congress.setTime(DateUtil.stringToDate(congressVo.getTimeStr(),DateUtil.FORMAT_DAY));
            congress.setCatTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT_DAY));
            //设置会议出勤情况
            List<Attendance> list = attendanceService.names(congressVo,congress);
            congress.setAttendanceList(list);
            congress.setTime(DateUtil.stringToDate(congressVo.getTimeStr(), DateUtil.FORMAT_DAY));
            congressService.save(congress);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("局务会议");
            if(org.apache.commons.lang.StringUtils.isEmpty(congressVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(congress.getTitle());
            sysLogVo.setEntityId(congress.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result", true);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除会议记录
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/congress-info-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteCongress(String id) {
        HashMap map = new HashMap(3);
        try {
            Congress congress = congressService.get(id);
            List<Attendance> list =congress.getAttendanceList();
            for(int i=0;i<list.size();i++){
                list.get(i).setDelFlag("1");
            }
            //删除标志设为1
            congress.setDelFlag("1");
            congress.setAttendanceList(list);
            //保存数据
            congressService.save(congress);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("局务会议");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(congress.getTitle());
            sysLogVo.setEntityId(congress.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }
}
