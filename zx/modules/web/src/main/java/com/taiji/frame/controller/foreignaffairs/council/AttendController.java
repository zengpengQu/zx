package com.taiji.frame.controller.foreignaffairs.council;


import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.council.Attendance;
import com.taiji.frame.model.entity.foreignaffairs.council.Congress;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.council.AttendanceVo;
import com.taiji.frame.service.foreignaffairs.council.AttendanceService;
import com.taiji.frame.service.foreignaffairs.council.CongressService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import lombok.AllArgsConstructor;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author sy
 * Created by suny on 2018/7/4.
 */
@Controller
@RequestMapping(value="/attendance")
public class AttendController   extends BaseController<Attendance> {
    private static final Logger LOG = LoggerFactory.getLogger(AttendController.class);

    @Autowired
    private AttendanceService attendanceService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     */

    @RequestMapping(value = "/attendance-info-list", method = RequestMethod.GET)
    public String attendance(ModelMap modelMap ,Map<String, Object> map) {
        return "foreignaffairs/council/attendance-info-list";
    }


    /**
     * 新增/编辑页面跳转
     */

    @RequestMapping(value = "/attendance-info-edit.do", method = RequestMethod.GET)
    public String attendanceEditTo(ModelMap modelMap,String id) {

        if (null != id) {
            //根据ID获取当前出勤情况ID
            Attendance loadAttendance = attendanceService.get(id);
            modelMap.addAttribute("loadAttendance", loadAttendance);
        }
        //查询到用户表中局务会议人员的姓名 根据部门id=056的(新增时可能需要先注释部分)
       /* String ids = "056";
        List<DicUser> list = dicUserService.findByDept(ids);
        modelMap.put("DicUserList", list);

        List<Congress> list1 = congressService.findByCongressTitle();
        modelMap.put("CongressTitleList", list1);*/
        return "foreignaffairs/council/attendance-edit";
    }

    /**
     * 编辑
     */
    @ResponseBody
    @RequestMapping(value = "/attendance-info-save.do", method = RequestMethod.POST)
    public  Map<String, Object> attendanceEdit(AttendanceVo vo) {
        Map<String, Object> map = new HashMap<>(1);
        try {
            Attendance attendance = new Attendance();
            BeanUtils.copyProperties(vo, attendance);
            attendance.setDelFlag("0");
            attendanceService.save(attendance);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("局务会议出勤情况");
                sysLogVo.setRecordType(1);
            sysLogVo.setEntityName(attendance.getAttendName());
            sysLogVo.setEntityId(attendance.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


    /**
     * 出勤情况 数据查询
     * @return
     */
    @ResponseBody
    @RequestMapping( value = "/load-attendance-list.do" ,produces = "text/html;charset=UTF-8")
    public String attendanceInFoListLoad (Carrier<Attendance> carrier, String groupName, String leaderName,
                                          String meetingTitle) {
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(groupName)) {
                //人员姓名
                map.put("attendName", "%" + groupName.replace(" ","") + "%");
            }
            if (!StringUtils.isEmpty(leaderName)) {
                //出勤状态
                map.put("attendEnce", "%" + leaderName + "%");
            }
            if (!StringUtils.isEmpty(meetingTitle)) {
                //会议标题
                map.put("meetingTitle", "%" + meetingTitle.replace(" ","") + "%");
            }
            attendanceService.Load(carrier,map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 根据ID删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/attendance-info-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteAttendance(String id) {

        HashMap map = new HashMap(3);
        try {
            Attendance attendance = attendanceService.get(id);
            //删除标志设为1
            attendance.setDelFlag("1");
            //保存数据
            attendanceService.save(attendance);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("局务会议出勤情况");
            sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(attendance.getAttendName());
            sysLogVo.setEntityId(attendance.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

}
