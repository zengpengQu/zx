package com.taiji.frame.controller.pubinfo.schedule;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.hkmacao.HkMaCao;
import com.taiji.frame.model.entity.pubinfo.schedule.WeekWork;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkFeedback;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkGuide;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkStudy;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkFeedbackVo;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkGuideVo;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkStudyVo;
import com.taiji.frame.service.pubinfo.schedule.WeekWorkService;
import com.taiji.frame.service.pubinfo.schedule.WorkFeedbackService;
import com.taiji.frame.service.pubinfo.schedule.WorkGuideService;
import com.taiji.frame.service.pubinfo.schedule.WorkStudyService;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.UtilService;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.*;

/**
 * @author BT4900 
 * 一周工作情况反馈
 */
@Controller
@RequestMapping(value = "/work-feedback")
public class WorkFeedbackController extends BaseController<WorkFeedback> {


    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private WorkFeedbackService workFeedbackService;

    @Autowired
    private WorkGuideService workGuideService;

    @Autowired
    private WorkStudyService workStudyService;

    @Autowired
    private WeekWorkService weekWorkService;

    @Autowired
    private UtilService utilService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 导出报表
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "/export-excel.do",method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response){
        try {
            String workId = request.getParameter("workId");
            //一周工作情况反馈
            List<WorkFeedback> list = workFeedbackService.getByWorkId(workId);
            List<WorkGuide> workGuideList = null;
            List<WorkStudy> workStudyList = null;
            for (WorkFeedback workFeedback : list){
                String feedbackId = workFeedback.getId();
                //法定节假日局级领导带班情况
                workGuideList = workGuideService.getByFeedbackId(feedbackId);
                //局级领导离京和脱产学习情况
                workStudyList = workStudyService.getByFeedbackId(feedbackId);
            }
            String fileName = "一周工作情况反馈,局级领导带班情况,局级领导离京和脱产学习情况";
            //设置输入流参数
            OutputStream os = OtherUtil.getOutputStream("一周工作情况反馈.xls", request, response);
            //导出报表
            createExcel(os, fileName, list,workGuideList,workStudyList);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("导出报表");
            sysLogVo.setRecordType(7);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId("");
            sysLogVo.setEntityName("");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            LOG.error(e.getMessage(),e);
        }
    }

    /**
     * 导出报表
     * */
    public void createExcel(OutputStream os, String fileName,List<WorkFeedback> list,List<WorkGuide> workGuideList,List<WorkStudy> workStudyList)
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        String[] sheetNameArr = fileName.split(",");
        HSSFSheet sheet = workbook.createSheet(sheetNameArr[0]);
        HSSFSheet sheet1 = workbook.createSheet(sheetNameArr[1]);
        HSSFSheet sheet2 = workbook.createSheet(sheetNameArr[2]);
        process(workbook, sheet,sheet1,sheet2, list,workGuideList,workStudyList);
        workbook.write(os);
    }

    /**
     * 将数据写入Excel中
     * @param workbook
     * @param sheet
     * @param list
     */
    private void process(HSSFWorkbook workbook,
                         HSSFSheet sheet,HSSFSheet sheet1,HSSFSheet sheet2,
                         List<WorkFeedback> list,List<WorkGuide> workGuideList,List<WorkStudy> workStudyList) {
        String name1 = "一周工作情况反馈";
        String name2 = "局级领导带班情况";
        String name3 = "局级领导离京和脱产学习情况";
        CellStyle style1 = sheet(workbook,sheet,name1,3);
        CellStyle style2 = sheet(workbook,sheet1,name2,3);
        CellStyle style3 = sheet(workbook,sheet2,name3,4);

        table1(workbook,sheet,list,style1);
        table2(workbook,sheet1,workGuideList,style2);
        table3(workbook,sheet2,workStudyList,style3);
    }

    private CellStyle sheet(HSSFWorkbook workbook,HSSFSheet sheet,String name,int call){
        sheet.setDefaultColumnWidth(20);
        //标题样式
        CellStyle style3 = workbook.createCellStyle();
        //设置标题字体格式
        Font font3 = workbook.createFont();
        //设置字体样式
        font3.setFontHeightInPoints((short)18);
        font3.setFontName("宋体");
        font3.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        style3.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        style3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style3.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style3.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style3.setFont(font3);
        //第一行
        Row titleRow = sheet.createRow(0);
        sheet.addMergedRegion(new CellRangeAddress(0,(short)0,0,(short)call));
        //创建第一个单元格
        Cell cell1 = titleRow.createCell(0);
        cell1.setCellStyle(style3);
        cell1.setCellValue(name);
        sheet.autoSizeColumn(0);

        //表头样式
        CellStyle style31 = workbook.createCellStyle();
        style31.setFillForegroundColor(HSSFColor.WHITE.index);
        style31.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

        //设置标题字体格式
        Font font31 = workbook.createFont();
        //设置字体样式
        font31.setFontHeightInPoints((short) 14);
        font31.setFontName("黑体");
        font31.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style31.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style31.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        style31.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style31.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style31.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style31.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style31.setFont(font31);
        return style31;
    }

    private CellStyle sheetRowstyle(HSSFWorkbook workbook){

        CellStyle style3_2 = workbook.createCellStyle();
        //设置标题字体格式
        Font font3_2 = workbook.createFont();
        //设置字体样式
        font3_2.setFontHeightInPoints((short) 10);
        font3_2.setFontName("黑体");
        font3_2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style3_2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style3_2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        style3_2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style3_2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style3_2.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style3_2.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style3_2.setFont(font3_2);
        style3_2.setWrapText(true);
        return style3_2;
    }

    private void table1(HSSFWorkbook workbook,HSSFSheet sheet,List<WorkFeedback> list,CellStyle style1){

        //第2行
        Row row4 = sheet.createRow(1);
        Cell cell5_0 = row4.createCell(0);
        cell5_0.setCellStyle(style1);
        cell5_0.setCellValue("      单位      ");
        sheet.autoSizeColumn(0);
        Cell cell5_1 = row4.createCell(1);
        cell5_1.setCellStyle(style1);
        cell5_1.setCellValue("本周工作情况");
        sheet.autoSizeColumn(1);
        Cell cell5_2 = row4.createCell(2);
        cell5_2.setCellStyle(style1);
        cell5_2.setCellValue("下周工作安排");
        sheet.autoSizeColumn(2);
        Cell cell5_3 = row4.createCell(3);
        cell5_3.setCellStyle(style1);
        cell5_3.setCellValue("近期重点工作");
        sheet.autoSizeColumn(3);


        for (int i = 0; i < list.size(); i++) {
            int count = 2;
            WorkFeedback workFeedback = list.get(i);
            Row row = sheet.createRow(count + i);
            String deptName = null == workFeedback.getDicDept() ? "" : workFeedback.getDicDept().getDeptName();
            String workContent = null == workFeedback.getWorkContent() ? "" : workFeedback.getWorkContent();
            String workSchedule = null == workFeedback.getWorkSchedule() ? "" : workFeedback.getWorkSchedule();
            String majorWork = null == workFeedback.getMajorWork() ? "" : workFeedback.getMajorWork();
            Cell cell_0 = row.createCell(0);
            cell_0.setCellValue(deptName);
            cell_0.setCellStyle(sheetRowstyle(workbook));

            Cell cell_1 = row.createCell(1);
            cell_1.setCellValue(workContent);
            cell_1.setCellStyle(sheetRowstyle(workbook));

            Cell cell_2 = row.createCell(2);
            cell_2.setCellValue(workSchedule);
            cell_2.setCellStyle(sheetRowstyle(workbook));

            Cell cell_3 = row.createCell(3);
            cell_3.setCellValue(majorWork);
            cell_3.setCellStyle(sheetRowstyle(workbook));

            sheet.autoSizeColumn(count + i);
        }
    }

    private void table2(HSSFWorkbook workbook,HSSFSheet sheet,List<WorkGuide> workGuideList,CellStyle style1){

        //第2行
        Row row4 = sheet.createRow(1);
        Cell cell5_0 = row4.createCell(0);
        cell5_0.setCellStyle(style1);
        cell5_0.setCellValue("姓名");
        sheet.autoSizeColumn(0);
        Cell cell5_1 = row4.createCell(1);
        cell5_1.setCellStyle(style1);
        cell5_1.setCellValue("开始日期");
        sheet.autoSizeColumn(1);
        Cell cell5_2 = row4.createCell(2);
        cell5_2.setCellStyle(style1);
        cell5_2.setCellValue("截止日期");
        sheet.autoSizeColumn(2);
        Cell cell5_3 = row4.createCell(3);
        cell5_3.setCellStyle(style1);
        cell5_3.setCellValue("手机号");
        sheet.autoSizeColumn(3);

        for (int i = 0; i < workGuideList.size(); i++) {
            int count = 2;
            WorkGuide workGuide = workGuideList.get(i);
            Row row = sheet.createRow(count + i);
            String name = null == workGuide.getName() ? "" : workGuide.getName();
            String startDate = null == DateUtil.dateToString(workGuide.getStartDate(),DateUtil.FORMAT_DAY) ? "" : DateUtil.dateToString(workGuide.getStartDate(),DateUtil.FORMAT_DAY);
            String endDate = null == DateUtil.dateToString(workGuide.getEndDate(),DateUtil.FORMAT_DAY)? "" : DateUtil.dateToString(workGuide.getEndDate(),DateUtil.FORMAT_DAY);
            String phone = null == workGuide.getPhone() ? "" : workGuide.getPhone();
            Cell cell_0 = row.createCell(0);
            cell_0.setCellValue(name);
            cell_0.setCellStyle(sheetRowstyle(workbook));
            Cell cell_1 = row.createCell(1);
            cell_1.setCellValue(startDate);
            cell_1.setCellStyle(sheetRowstyle(workbook));
            Cell cell_2 = row.createCell(2);
            cell_2.setCellValue(endDate);
            cell_2.setCellStyle(sheetRowstyle(workbook));
            Cell cell_3 = row.createCell(3);
            cell_3.setCellValue(phone);
            cell_3.setCellStyle(sheetRowstyle(workbook));

            sheet.autoSizeColumn(count + i);
        }
    }

    private void table3(HSSFWorkbook workbook,HSSFSheet sheet,List<WorkStudy> workStudyList,CellStyle style1){
        //第五行
        Row row4 = sheet.createRow(1);
        Cell cell5_0 = row4.createCell(0);
        cell5_0.setCellStyle(style1);
        cell5_0.setCellValue("姓名");
        sheet.autoSizeColumn(0);
        Cell cell5_1 = row4.createCell(1);
        cell5_1.setCellStyle(style1);
        cell5_1.setCellValue("开始日期");
        sheet.autoSizeColumn(1);
        Cell cell5_2 = row4.createCell(2);
        cell5_2.setCellStyle(style1);
        cell5_2.setCellValue("截止日期");
        sheet.autoSizeColumn(2);
        Cell cell5_3 = row4.createCell(3);
        cell5_3.setCellStyle(style1);
        cell5_3.setCellValue("手机号");
        sheet.autoSizeColumn(3);
        Cell cell5_4 = row4.createCell(4);
        cell5_4.setCellStyle(style1);
        cell5_4.setCellValue("离京事由或脱产学习情况");
        sheet.autoSizeColumn(4);

        for (int i = 0; i < workStudyList.size(); i++) {
            int count = 2;
            WorkStudy workStudy = workStudyList.get(i);
            Row row = sheet.createRow(count + i);
            String name = null == workStudy.getName() ? "" : workStudy.getName();
            String startDate = null == DateUtil.dateToString(workStudy.getStartDate(),DateUtil.FORMAT_DAY) ? "" : DateUtil.dateToString(workStudy.getStartDate(),DateUtil.FORMAT_DAY);
            String endDate = null == DateUtil.dateToString(workStudy.getEndDate(),DateUtil.FORMAT_DAY)? "" : DateUtil.dateToString(workStudy.getEndDate(),DateUtil.FORMAT_DAY);
            String phone = null == workStudy.getPhone() ? "" : workStudy.getPhone();
            String reason = null == workStudy.getReason() ? "" : workStudy.getReason();
            Cell cell_0 = row.createCell(0);
            cell_0.setCellValue(name);
            cell_0.setCellStyle(sheetRowstyle(workbook));

            Cell cell_1 = row.createCell(1);
            cell_1.setCellValue(startDate);
            cell_1.setCellStyle(sheetRowstyle(workbook));

            Cell cell_2 = row.createCell(2);
            cell_2.setCellValue(endDate);
            cell_2.setCellStyle(sheetRowstyle(workbook));

            Cell cell_3 = row.createCell(3);
            cell_3.setCellValue(phone);
            cell_3.setCellStyle(sheetRowstyle(workbook));

            Cell cell_4 = row.createCell(4);
            cell_4.setCellValue(reason);
            cell_4.setCellStyle(sheetRowstyle(workbook));

            sheet.autoSizeColumn(count + i);
        }
    }



    /**
     * 一周工作情况反馈页面跳转
     * */
    @RequestMapping(value = "/load-feedback-list.do", method = RequestMethod.GET)
    public String load(ModelMap modelMap, String id,String feedbackDeptId) {
        //当前部门
        DicUser dicUser = getCurUser();
        //用户所在部门
        DicDept curDept = dicUser.getDicDept();
        modelMap.addAttribute("curDept", curDept.getJsonObject());

        if (null != feedbackDeptId && !"".equals(feedbackDeptId)) {

            WeekWork weekWork = weekWorkService.get(id);
            //根据部门ID和workId查找部门反馈信息
            WorkFeedback workFeedback = workFeedbackService.findFeedbackByWorkIdAndDeptId(id,feedbackDeptId);

            if (workFeedback == null) {

                WorkFeedback feedback = new WorkFeedback();
                feedback.setWeekWork(weekWork);
                feedback.setDicDept(dicDeptService.get(feedbackDeptId));
                feedback.setStatus("0");
                feedback.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT));
                feedback.setDelFlag("0");
                workFeedbackService.save(feedback);
            }
        }
        modelMap.addAttribute("workId",id);
        modelMap.addAttribute("feedbackDeptId",feedbackDeptId);

        return "pubinfo/schedule/week-work/work-feedback-list";
    }

    /**
     * load一周工作情况反馈数据
     * */
    @ResponseBody
    @RequestMapping(value = "/work-feedback-list.do", produces = "text/html;charset=UTF-8")
    public String dutyListLoad(Carrier<WorkFeedback> carrier, WorkFeedbackVo workFeedbackVo) {

        HashMap map = new HashMap(2);

        if (!StringUtils.isEmpty(workFeedbackVo.getWorkId())) {
            map.put("workId",workFeedbackVo.getWorkId());
        }

        if (!StringUtils.isEmpty(workFeedbackVo.getDeptId())) {
            map.put("deptId",workFeedbackVo.getDeptId());
        }
        if (!StringUtils.isEmpty(workFeedbackVo.getStatus())) {
            List<String> statusList = OtherUtil.strToStringList(workFeedbackVo.getStatus());
            map.put("statusList", statusList);
        }
        try {
            workFeedbackService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 根据一周工作情况ID和反馈部门查找部门反馈信息
     * @param id 一周工作情况ID
     * @param deptId 反馈部门ID
     * */
    @RequestMapping(value = "/view-feedback-list.do", method = RequestMethod.GET)
    public String view(ModelMap modelMap,String id,String deptId) {

        //根据一周工作情况ID和反馈部门查找部门反馈信息


        return "pubinfo/schedule/week-work/work-feedback-view";
    }

    /**
     * 查收一周工作情况反馈信息
     * @param id 一周工作情况反馈ID
     * */
    @ResponseBody
    @RequestMapping(value = "/check-work-feedback.do",method = RequestMethod.POST)
    public Map<String,Object> checkFeedback(String id) {

        Map<String,Object> map = new HashMap<>(1);

        if (!StringUtils.isEmpty(id)) {
            //根据Id查找反馈信息
            try {
                WorkFeedback workFeedback = workFeedbackService.get(id);
                workFeedback.setStatus("2");
                workFeedbackService.save(workFeedback);
                map.put("result",true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("一周工作情况反馈信息");
                sysLogVo.setRecordType(9);
                sysLogVo.setResult("true");
                sysLogVo.setEntityId(workFeedback.getId());
                sysLogVo.setEntityName(workFeedback.getCreateName());
                sysLogService.record(sysLogVo);
            } catch (Exception e) {
                LOG.error("查收一周工作失败:" + e.getMessage(),e);
                map.put("result",false);
            }
        }
        return map;
    }

    /**
     * 根据ID查看一周工作情况反馈信息
     * @param id 反馈ID
     * */
    @RequestMapping(value = "/view-work-feedback.do", method = RequestMethod.GET)
    public String viewFeedback(ModelMap modelMap,String id) {
        //根据ID查找反馈信息
        WorkFeedback workFeedback = workFeedbackService.get(id);


        List<WorkGuideVo> workGuideVoList = workGuideService.findWorkGuideByFeedbackId(id);
        List<WorkStudyVo> workStudyVoList = workStudyService.findWorkStudyByFeedbackId(id);

        WorkFeedbackVo workFeedbackVo = new WorkFeedbackVo();
        BeanUtils.copyProperties(workFeedback,workFeedbackVo);
        workFeedbackVo.setWorkGuideList(workGuideVoList);
        workFeedbackVo.setWorkStudyList(workStudyVoList);
        //报送日期
        String feedbackDateStr = DateUtil.dateToString(workFeedbackVo.feedbackDate,DateUtil.FORMAT_DAY);
        workFeedbackVo.setFeedbackDateStr(feedbackDateStr);
        modelMap.addAttribute("workFeedbackVo",workFeedbackVo);

        return "pubinfo/schedule/week-work/work-feedback-view";
    }

    /**
     * 删除一周工作情况反馈信息
     * @param id 反馈信息ID
     * */
    @ResponseBody
    @RequestMapping(value = "/feedback-delete.do",method = RequestMethod.POST)
    public Map<String,Object> logicDelete(String id) {

        Map<String,Object> map = new HashMap<>();
        try {
            //删除法定节假日局级领导带班情况
            List<WorkGuide> workGuideList = workGuideService.findWordGuideList(id);
            for (WorkGuide workGuide : workGuideList) {
                workGuide.setDelFlag("1");
                workGuideService.save(workGuide);
            }
            //删除下周局级领导离京和脱产学习情况
            List<WorkStudy> workStudyList = workStudyService.findWordStudyList(id);
            for (WorkStudy workStudy : workStudyList) {

                workStudy.setDelFlag("1");
                workStudyService.save(workStudy);
            }
            //删除反馈信息
            WorkFeedback workFeedback = workFeedbackService.get(id);
            workFeedback.setDelFlag("1");
            workFeedbackService.save(workFeedback);

            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("一周工作情况反馈信息");
            sysLogVo.setRecordType(2);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workFeedback.getId());
            sysLogVo.setEntityName(workFeedback.getCreateName());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 保存局级领导离京和脱产学习情况
     * */
    @ResponseBody
    @RequestMapping(value = "/save-workStudy.do",method = RequestMethod.POST)
    public Map<String,Object> saveStudy(WorkStudyVo workStudyVo) {

        Map<String,Object> map = new HashMap<>(2);

        try {
            WorkStudy workStudy = workStudyService.saveWorkStudy(workStudyVo);

            map.put("result",true);
            map.put("workStudy",workStudy.getJsonObject());
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("局级领导离京和脱产学习情况");
            sysLogVo.setRecordType(0);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workStudy.getId());
            sysLogVo.setEntityName(workStudy.getName());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error("保存局级领导离京和脱产学习情况：失败，" + e.getMessage());
            map.put("result",false);
        }
        return map;
    }

    /**
     * 保存法定节假日局级领导带班情况
     * */
    @ResponseBody
    @RequestMapping(value = "/save-workGuide.do",method = RequestMethod.POST)
    public Map<String,Object> saveGuide(WorkGuideVo workGuideVo) {

        Map<String,Object> map = new HashMap<>(3);

        try {
            WorkGuide workGuide = workGuideService.saveWorkGuide(workGuideVo);
            WorkFeedback workFeedback = workGuide.getWorkFeedback();
            String workFeedbackId = workFeedback.getId();
            map.put("result",true);
            map.put("workFeedbackId",workFeedbackId);
            map.put("workGuide",workGuide.getJsonObject());

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("法定节假日局级领导带班情况");
            sysLogVo.setRecordType(0);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workGuide.getId());
            sysLogVo.setEntityName(workGuide.getName());
            sysLogService.record(sysLogVo);

        } catch (Exception e) {
            LOG.error("保存法定节假日局级领导带班情况：失败，" + e.getMessage());
            map.put("result",false);
        }
        return map;
    }

    //上报一周工作情况
    @ResponseBody
    @RequestMapping(value = "/report-feedback.do",method = RequestMethod.POST)
    public Map<String,Object> report(String id) {

        Map<String,Object> map = new HashMap<>(1);
        //根据ID查找一周工作情况反馈信息
        try {
            WorkFeedback workFeedback = workFeedbackService.get(id);
            workFeedback.setStatus("1");
            workFeedbackService.save(workFeedback);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("一周工作情况反馈");
            sysLogVo.setRecordType(8);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workFeedback.getId());
            sysLogVo.setEntityName(workFeedback.getCreateName());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result",false);
        }
        return map;
    }

    /**
     * 撤回一周工作情况反馈
     * */
    @ResponseBody
    @RequestMapping(value = "/back-feedback.do",method = RequestMethod.POST)
    public Map<String,Object> back(String id) {

        Map<String,Object> map = new HashMap<>(1);

        try {
            WorkFeedback workFeedback = workFeedbackService.get(id);
            workFeedback.setStatus("0");
            workFeedbackService.save(workFeedback);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("一周工作情况反馈");
            sysLogVo.setRecordType(16);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workFeedback.getId());
            sysLogVo.setEntityName(workFeedback.getCreateName());
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result",false);
        }
        return map;
    }

    /**
     * 编辑---法定节假日局级领导带班情况
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/edit-workGuide.do",method = RequestMethod.POST)
    public Map<String,Object> getWorkGuideById(String id){
        Map<String,Object> map = new HashMap<>(3);
        try {
            WorkGuide workGuide = workGuideService.get(id);
            WorkFeedback workFeedback = workGuide.getWorkFeedback();
            String workFeedbackId = workFeedback.getId();
            map.put("workGuide",workGuide.getJsonObject());
            map.put("workFeedbackId",workFeedbackId);
            map.put("result",true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("法定节假日局级领导带班情况");
            sysLogVo.setRecordType(1);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workGuide.getId());
            sysLogVo.setEntityName(workGuide.getName());
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            e.printStackTrace();
            map.put("result",false);
        }
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/edit-workStudy.do",method = RequestMethod.POST)
    public Map<String,Object> getWorkStudyById(String id){
        Map<String,Object> map = new HashMap<>(3);
        try {
            WorkStudy workStudy = workStudyService.get(id);
            WorkFeedback workFeedback = workStudy.getWorkFeedback();
            String workFeedbackId = workFeedback.getId();
            map.put("workStudy",workStudy.getJsonObject());
            map.put("sWorkFeedbackId",workFeedbackId);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("局级领导离京和脱产学习情况信息");
            sysLogVo.setRecordType(1);
            sysLogVo.setResult("true");
            sysLogVo.setEntityId(workStudy.getId());
            sysLogVo.setEntityName(workStudy.getName());
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            e.printStackTrace();
            map.put("result",false);
        }
        return map;
    }

}
