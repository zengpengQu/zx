package com.taiji.frame.controller.foreignaffairs.abroad;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadSchedule;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.abroad.AbroadScheduleVo;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadInfoService;
import com.taiji.frame.service.foreignaffairs.abroad.AbroadScheduleService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/abroad-schedule")
public class AbroadScheduleController extends BaseController<AbroadSchedule> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private AbroadInfoService abroadInfoService;

    @Autowired
    private AbroadScheduleService abroadScheduleService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/abroad-schedule-list", method = RequestMethod.GET)
    public String list(String abroadInfoId, ModelMap modelMap) {
        modelMap.addAttribute("abroadInfoId", abroadInfoId);
        AbroadInfo abroadInfo = abroadInfoService.get(abroadInfoId);
        modelMap.put("abroadInfo", abroadInfo);
        return "foreignaffairs/abroad/abroad-schedule-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-schedule-list.do", produces = "text/html;charset=UTF-8")
    public String scheduleListLoad(Carrier<AbroadSchedule> carrier, AbroadScheduleVo abroadScheduleVo) {
        HashMap map = new HashMap(16);
        try {
            if (StringUtils.isNotEmpty(abroadScheduleVo.getAbroadInfoId())) {
                map.put("abroadInfoId", abroadScheduleVo.getAbroadInfoId());
                abroadScheduleService.load(carrier, map);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 新增/编辑弹窗
     */
    @RequestMapping(value = "/load-schedule-edit.do", method = RequestMethod.GET)
    public String abroadScheduleEdit(ModelMap modelMap, String id) {
        AbroadSchedule abroadSchedule = null;
        if (StringUtils.isNotEmpty(id)) {
            abroadSchedule = abroadScheduleService.get(id);
        }
        modelMap.addAttribute("abroadSchedule", abroadSchedule);
        return "foreignaffairs/abroad/abroad-schedule-edit";
    }

    /**
     * 新增/编辑保存
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-schedule-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveAbroadSchedule(HttpServletRequest request, AbroadScheduleVo abroadScheduleVo) {
        Map<String, Object> map = new HashMap<>(2);

        AbroadSchedule abroadSchedule;
        String id = abroadScheduleVo.getId();
        if (id != null) {
            abroadSchedule = abroadScheduleService.get(id);
        } else {
            abroadSchedule = new AbroadSchedule();
            abroadSchedule.setCreateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
        }

        try {
            AbroadInfo abroadInfo = abroadInfoService.get(abroadScheduleVo.getAbroadInfoId());
            abroadSchedule.setAbroadInfo(abroadInfo);

            if (StringUtils.isNotEmpty(abroadScheduleVo.getDayStr())) {
                Date day = DateUtil.stringToDate(abroadScheduleVo.getDayStr(), DateUtil.FORMAT_DAY);
                abroadSchedule.setDay(day);
            }
            abroadSchedule.setPeriod(abroadScheduleVo.getPeriod());
            abroadSchedule.setContent(abroadScheduleVo.getContent());
            abroadSchedule.setNoteInfo(abroadScheduleVo.getNoteInfo());

            abroadSchedule.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAYTIME));
            abroadSchedule.setDelFlag("0");

            abroadScheduleService.save(abroadSchedule);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
            if(org.apache.commons.lang.StringUtils.isEmpty(abroadScheduleVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(abroadSchedule.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadSchedule.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除
     */
    @ResponseBody
    @RequestMapping(value = "/abroad-schedule-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteAbroadSchedule(String id) {
        Map<String, Object> map = new HashMap<>(2);
        try {
            AbroadSchedule abroadSchedule = abroadScheduleService.get(id);
            abroadScheduleService.delete(abroadSchedule);
            map.put("result", true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("出访信息");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(abroadSchedule.getAbroadInfo().getAbroadType());
            sysLogVo.setEntityId(abroadSchedule.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }


}
