package com.taiji.frame.controller.foreignaffairs.come;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.rtf.RtfWriter2;
import com.lowagie.text.rtf.style.RtfFont;
import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeSchedule;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeScheduleListVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeScheduleVo;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.service.foreignaffairs.come.ComeSchedulesService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.filechooser.FileSystemView;
import java.awt.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.List;

/**
 * 来访日程管理 controller
 *
 * @author yx
 */
@Controller
@RequestMapping(value = "/come/come-schedule")
public class ComeScheduleController extends BaseController<ComeSchedule> {

    private static final Logger LOG = LoggerFactory.getLogger(ComeScheduleController.class);

    @Autowired
    ComeSchedulesService comeSchedulesService;

    @Autowired
    ComeInfoService comeInfoService;

    /**
     * 加载来访日程页面
     *
     * @param modelMap
     * @param comeInfoId
     * @return
     */
    @RequestMapping(value = "/load-come-schedule", method = RequestMethod.GET)
    public String loadSchedule(ModelMap modelMap, String comeInfoId) {

        // 日期列表
        List<Date> dates;
        List<String> dateStrList = new ArrayList<>();

        if (StringUtils.isNotEmpty(comeInfoId)) {

            ComeInfo comeInfo = comeInfoService.get(comeInfoId);
            dates = DateUtil.getDateList(comeInfo.getStartDate(), comeInfo.getEndDate());
            for (Date date : dates) {
                dateStrList.add(DateUtil.dateToString(date, DateUtil.FORMAT_DAY));
            }

            // 接待计划列表
            List<ComeSchedule> comeScheduleList = comeSchedulesService.findSchedulesByComeInfoId(comeInfoId);

            modelMap.addAttribute("comeScheduleList", comeScheduleList);
            modelMap.addAttribute("dateList", dateStrList);

        }

        return "foreignaffairs/come/come-schedule-list";
    }

    /**
     * load grid表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-schedule-list.do", produces = "text/html;charset=UTF-8")
    public String loadScheduleList(Carrier<ComeSchedule> carrier, String comeInfoId) {
        HashMap map = new HashMap(16);
        try {
            if (!StringUtils.isEmpty(comeInfoId)) {
                map.put("comeInfoId", comeInfoId);
            }
            comeSchedulesService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }


    /**
     * 加载日程信息编辑页面
     *
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-schedule-edit", method = RequestMethod.GET)
    public String loadReceptionEdit(ModelMap modelMap, String id, String comeInfoId) {

        if (StringUtils.isNotEmpty(id)) {
            ComeSchedule comeSchedule = comeSchedulesService.get(id);

            modelMap.addAttribute("comeSchedule", comeSchedule);
        }

        if (StringUtils.isNotEmpty(comeInfoId)) {
            ComeInfo comeInfo = comeInfoService.get(comeInfoId);

            // 日期列表
            List<Date> dates;
            List<String> dateStrList = new ArrayList<>();

            dates = DateUtil.getDateList(comeInfo.getStartDate(), comeInfo.getEndDate());
            for (Date date : dates) {
                dateStrList.add(DateUtil.dateToString(date, DateUtil.FORMAT_DAY));
            }
            modelMap.addAttribute("dateList", dateStrList);
        }

        return "foreignaffairs/come/come-schedule-edit";
    }


    /**
     * 新增/编辑日程信息
     */
    @ResponseBody
    @RequestMapping(value = "/schedule-edit.do", method = RequestMethod.POST)
    public Map<String, Object> editSchedule(ComeScheduleListVo scheduleList, String comeInfoId) {

        Map<String, Object> map = new HashMap<>(1);

        try {
            comeSchedulesService.saveSchedules(scheduleList, comeInfoId,getSysLogVo());
            map.put("result", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }

        map.put("result", true);

        return map;
    }


    /**
     * 新增/编辑一条日程信息
     */
    @ResponseBody
    @RequestMapping(value = "/add-schedule-row.do", method = RequestMethod.POST)
    public Map<String, Object> addScheduleRow(ComeScheduleVo comeScheduleVo) {
        Map<String, Object> map = new HashMap<>(2);

        try {
            ComeInfo comeInfo = comeInfoService.get(comeScheduleVo.getComeInfoId());
            ComeSchedule comeSchedule = new ComeSchedule();

            BeanUtils.copyProperties(comeScheduleVo, comeSchedule);

            comeSchedule.setComeInfo(comeInfo);

            String activityDateStr = comeScheduleVo.getActivityDateStr();
            Date activityDate = DateUtil.stringToDate(activityDateStr, DateUtil.FORMAT_DAY);
            comeSchedule.setActivityDate(activityDate);

            String timeStr = comeScheduleVo.getActivityTimeStr();
            String activityTimeStr = activityDateStr + " " + timeStr;

            // 输入的时间没有秒数，则添加秒
            if (timeStr.length() < 8) {
                activityTimeStr += ":00";
            }

            Date activityTime = DateUtil.stringToDate(activityTimeStr, DateUtil.FORMAT_DAYTIME);
            comeSchedule.setActivityTime(activityTime);

            comeSchedule.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT_DAY_HOUR_MIN));
            comeSchedule.setDelFlag("0");

            comeSchedulesService.save(comeSchedule);
            map.put("result", true);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }

        return map;
    }

    /**
     * 获取一条日程信息
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/get-one-schedule.do", method = RequestMethod.POST)
    public Map<String, Object> getOneSchedule(String id) {

        Map<String, Object> map = new HashMap<>(2);

        if (StringUtils.isNotEmpty(id)) {

            try {
                ComeSchedule comeSchedule = comeSchedulesService.get(id);

                map.put("schedule", comeSchedule.getJsonObject());
                map.put("result", true);
            } catch (Exception e) {
                map.put("result", false);
                LOG.debug(e.getMessage(), e);
            }
        }
        return map;
    }

    /**
     * 删除一条日程信息
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/schedule-delete.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteSchedule(String id) {
        Map<String, Object> map = new HashMap<>(1);

        try {
            ComeSchedule comeSchedule = comeSchedulesService.get(id);
            comeSchedule.setDelFlag("1");
            comeSchedulesService.save(comeSchedule);
            map.put("result", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }

        return map;
    }

    /**
     * 导出Word文件
     */
    @RequestMapping(value = "/come-schedule-export.do", method = RequestMethod.POST)
    public void exportWord(String comeInfoId, HttpServletRequest request,
                                          HttpServletResponse response) {
        if (StringUtils.isNotEmpty(comeInfoId)) {
            ComeInfo comeInfo = comeInfoService.get(comeInfoId);
            List<ComeSchedule> comeScheduleList = comeSchedulesService.findSchedulesByComeInfoId(comeInfoId);
            //导出Word
            try {
                this.export(comeInfo, comeScheduleList, request, response);
            } catch (DocumentException e) {
                LOG.debug(e.getMessage(), e);
            } catch (IOException e) {
                LOG.debug(e.getMessage(), e);
            }
        }
    }


    /**
     * 导出Word文件
     *
     * @param comeScheduleList
     * @param request
     * @throws DocumentException
     * @throws IOException
     */
    private void export(ComeInfo comeInfo, List<ComeSchedule> comeScheduleList,
                        HttpServletRequest request, HttpServletResponse response)
            throws DocumentException, IOException {
        //设置纸张大小
        Document document = new Document(PageSize.A4, 90.0F, 90.0F, 72.0F, 72.0F);

        // 创建临时文件
        String uploadPath = request.getSession().getServletContext().getRealPath("upload");
        File f = new File(uploadPath);
        //文件夹不存在
        if(!f.exists())
        {
            f.mkdirs();
        }
        String fileName = comeInfo.getGroupName() + "初步日程.doc";
        String tempPath = uploadPath + File.separator + fileName;
        File file = new File(tempPath);

        RtfWriter2.getInstance(document, new FileOutputStream(file));
        document.open();

        //设置标题字体风格
        RtfFont titleFont = new RtfFont("华文中宋", 22, Font.BOLD, Color.BLACK);

        //设置正文字体风格
        float contextFontSize = 14;
        RtfFont contextFont = new RtfFont("宋体", contextFontSize, Font.NORMAL);

        // 标题
        String titleStr = comeInfo.getGroupName() + "初步日程";
        Paragraph title = new Paragraph(titleStr);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setFont(titleFont);
        title.setSpacingAfter(36);
        document.add(title);

        List<Date> dateList = DateUtil.getDateList(comeInfo.getStartDate(), comeInfo.getEndDate());

        // 按日期排列日程信息
        for (Date date : dateList) {
            // 日期信息
            String activityDateStr = DateUtil.dateToString(date, DateUtil.FORMAT_DAY_CN_MD);
            String week = getWeekDay(date);
            String dateInfoStr = activityDateStr + "（" + week + "）";
            Paragraph dateInfo = new Paragraph(dateInfoStr);
            dateInfo.setFont(contextFont);

            document.add(dateInfo);

            for (ComeSchedule comeSchedule : comeScheduleList) {
                Date activityDate = comeSchedule.getActivityDate();
                if (DateUtil.compareDate(activityDate, date, 0) == 0) {
                    // 时间与日程
                    String activityTimeStr = DateUtil.dateToString(comeSchedule.getActivityTime(),
                            DateUtil.FORMAT_TIME_SHORT);
                    Paragraph schedule = new Paragraph(activityTimeStr + "     " + comeSchedule.getActivity());
                    schedule.setFirstLineIndent(contextFontSize * 2);
                    schedule.setSpacingBefore(contextFontSize / 2);
                    schedule.setSpacingAfter(contextFontSize / 2);
                    schedule.setFont(contextFont);

                    document.add(schedule);
                }
            }
        }

        document.close();

        FileUtil.downOrPreview(fileName, tempPath, response, request, "0");

        // 删除临时文件
        file.delete();
    }

    private String getWeekDay(Date date) {
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar c = Calendar.getInstance();
        c.setTime(date);

        int w = c.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0) {
            w = 0;
        }

        return weekDays[w];
    }
}
