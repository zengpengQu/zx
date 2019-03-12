package com.taiji.frame.controller.pubinfo.batch;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.OtherUtil;
import com.taiji.frame.common.util.StringUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatchOut;
import com.taiji.frame.model.entity.pubinfo.batch.RegisterBatch;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.batch.*;
import com.taiji.frame.service.pubinfo.batch.*;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.SysLogService;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @author wsh 2018-09-06
 * 呈批件导出
 */
@Controller
@RequestMapping(value = "/data-batch")
public class DataExportBatchController extends BaseController{
    private static final Logger log = LoggerFactory.getLogger(DataExportBatchController.class);

    @Autowired
    private DraftBatchService draftBatchService;
    @Autowired
    private DraftBatchOutService draftBatchOutService;
    @Autowired
    private DataExportService dataExportService;
    @Autowired
    private DicDeptService dicDeptService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 页面跳转
     */
    @RequestMapping(value = "/batch-data-export", method = RequestMethod.GET)
    public String batchData(ModelMap modelMap, String id) {
        return "pubinfo/batch/data-batch/batch-data-export-list";
    }

    /**
     * 数据导出时页面集合
     *
     */
    @ResponseBody
    @RequestMapping(value = "/load-batch-data-list.do", produces = "text/html;charset=UTF-8")
    public String batchSubmitList(Carrier<DataExportVo> carrier, DataExportVo dataExportVo) {

        HashMap map = new HashMap(16);
        try {
            String startDateStr = dataExportVo.getStartTime();
            String endDateStr = dataExportVo.getEndTime();
            String keyWord = dataExportVo.getKeyWord();
            String leader = dataExportVo.getLeader();
            String deptId = dataExportVo.getDeptId();
            String counterSignFlag = dataExportVo.getCounterSignFlag();
            if(!org.apache.commons.lang.StringUtils.isEmpty(startDateStr)){
                map.put("startDate", startDateStr);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(endDateStr)){
                map.put("endDate", endDateStr);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(keyWord)){
                map.put("title", keyWord);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(leader)){
                map.put("leader", leader);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(deptId)){
                DicDept dept = dicDeptService.get(deptId);
                String strId = dept.getAbsCode();
                String []strs = strId.split("/");
                if (strs.length>=3){
                    String medId = strs[2];
                    DicDept medDept = dicDeptService.get(medId);
                    map.put("medDept",medDept.getDeptName());
                }
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(counterSignFlag)){
                map.put("counterSignFlag", counterSignFlag);
            }
             dataExportService.load(carrier,map);
        } catch (Exception e) {
            log.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 导出报表
     * @param request
     * @param response
     */
    @ResponseBody
    @RequestMapping(value = "/export-excel.do",method = RequestMethod.GET)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response,
                           String startDate, String endDate,String keyword,String type,
                            String deptId,String counterSignFlag,String leader){
        HashMap map = new HashMap(16);

        try {
            if (org.apache.commons.lang.StringUtils.isEmpty(startDate)){
                startDate = lastWeek();
                map.put("startDate", startDate);
            }else {
                map.put("startDate", startDate);
            }
            if (org.apache.commons.lang.StringUtils.isEmpty(endDate)){
                endDate = DateUtil.getDateStr(getCurDate());
                map.put("endDate", endDate);
            } else {
                map.put("endDate", endDate);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(keyword)){
                map.put("title", keyword);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(deptId)){
                DicDept dept = dicDeptService.get(deptId);
                String strId = dept.getAbsCode();
                String []strs = strId.split("/");
                if (strs.length>=3){
                    String medId = strs[2];
                    DicDept medDept = dicDeptService.get(medId);
                    map.put("medDept",medDept.getDeptName());
                }

            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(counterSignFlag)){
                map.put("counterSignFlag", counterSignFlag);
            }
            if(!org.apache.commons.lang.StringUtils.isEmpty(leader)){
                map.put("leader", leader);
            }

            List<DataExportVo> list = null;

            List<RegisterBatchVo> list1 = null;

            List<RegisterBatchVo> reglist = new ArrayList<RegisterBatchVo>();

            String fileName = "";
            String titleName = "";
            String sysStr = "";
            if("0".equals(type)){
                fileName = "领导批示导出.xls";
                titleName = "领导同志批示情况";
                sysStr="领导批示";
                list1 =  dataExportService.findConments(map);

                //查出数据后的封装
                if (list1 != null){
                    for (int i=0; i<list1.size();i++){
                        RegisterBatchVo registerBatchVo = list1.get(i);
                        if(null!= registerBatchVo){
                            String bachId = registerBatchVo.getBatchId();
                            String bachOutId = registerBatchVo.getBatchOutId();
                            List<LeaderConmentsVo> conlist = new ArrayList<LeaderConmentsVo>();
                            for (int j=0;j<list1.size();j++){
                                if (i != j){
                                    RegisterBatchVo registerBatchVo1 = list1.get(j);
                                    LeaderConmentsVo leaderConmentsVo = new LeaderConmentsVo();
                                    if(null!= registerBatchVo1){
                                        String bachId1 = registerBatchVo1.getBatchId();
                                        String bachOutId1 = registerBatchVo1.getBatchOutId();
                                        if(StringUtils.isNotEmpty(bachId)&&StringUtils.isNotEmpty(bachId1)&&bachId.equals(bachId1)){
                                            DraftBatch draftBatch = draftBatchService.get(bachId);
                                            String title = draftBatch.getTitle();
                                            String orgName = draftBatch.getMediUnit();
                                            registerBatchVo.setTitle(title);
                                            registerBatchVo.setDeptName(orgName);
                                            leaderConmentsVo.setLeaderName(registerBatchVo1.getReportLeader());
                                            leaderConmentsVo.setDutyName(registerBatchVo1.getDutyName());
                                            leaderConmentsVo.setTimeStr(registerBatchVo1.getUpdateTimeStr());
                                            leaderConmentsVo.setConments(registerBatchVo1.getConmentsLeader());
                                            conlist.add(leaderConmentsVo);
                                            list1.set(j,null);
                                        }
                                        if(StringUtils.isNotEmpty(bachOutId)&&StringUtils.isNotEmpty(bachOutId1)&&bachOutId.equals(bachOutId1)){
                                            DraftBatchOut draftBatchOut = draftBatchOutService.get(bachOutId);
                                            String title = draftBatchOut.getTitle();
                                            String deptName = draftBatchOut.getMediUnit();
                                            registerBatchVo.setTitle(title);
                                            registerBatchVo.setDeptName(deptName);
                                            leaderConmentsVo.setLeaderName(registerBatchVo1.getReportLeader());
                                            leaderConmentsVo.setDutyName(registerBatchVo1.getDutyName());
                                            leaderConmentsVo.setTimeStr(registerBatchVo1.getUpdateTimeStr());
                                            leaderConmentsVo.setConments(registerBatchVo1.getConmentsLeader());
                                            conlist.add(leaderConmentsVo);
                                            list1.set(j,null);
                                        }
                                    }
                                }
                            }
                            registerBatchVo.setLeaderConmentsList(conlist);
                            reglist.add(registerBatchVo);
                            list1.set(i,null);
                        }

                    }
                }

            }else {
                fileName = "上报呈批件导出.xls";
                titleName = "各部门上报呈批件情况";
                sysStr="各部门上报呈批件";
                list = dataExportService.findByWeek(map);
            }
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName(sysStr+"信息");
            sysLogVo.setRecordType(7);
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            //设置输入流参数
            OutputStream os = OtherUtil.getOutputStream(fileName, request, response);
            //导出报表
            createExcel(os, fileName, startDate,endDate,list,type,titleName,reglist);

        } catch (Exception e) {
            log.error(e.getMessage(),e);
        }
    }
    //导出报表
    public void createExcel(OutputStream os, String fileName, String startDate,String endDate,
                            List<DataExportVo> list,String type,String titleName,List<RegisterBatchVo> list1) throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        process(startDate, endDate, workbook, sheet, list,type,titleName,list1);
        workbook.write(os);
    }

    //获得一周前的日期
    public String lastWeek(){
        Date date = new Date();
        int year=Integer.parseInt(new SimpleDateFormat("yyyy").format(date));
        int month=Integer.parseInt(new SimpleDateFormat("MM").format(date));
        int day=Integer.parseInt(new SimpleDateFormat("dd").format(date))-6;

        if(day<1){
            month-=1;
            if(month==0){
                year-=1;month=12;
            }
            if(month==4||month==6||month==9||month==11){
                day=30+day;
            }else if(month==1||month==3||month==5||month==7||month==8||month==10||month==12)
            {
                day=31+day;
            }else if(month==2){
                if(year%400==0||(year %4==0&&year%100!=0)){
                    day=29+day;
                }
                else {
                    day=28+day;
                }
            }
        }
        String y = year+"";String m ="";String d ="";
        if(month<10){
            m = "0"+month;
        }
        else {
            m=month+"";
        }
        if(day<10){
            d = "0"+day;
        }
        else {
            d = day+"";
        }

        return y+"-"+m+"-"+d;
    }


    /**
     * 将数据写入Excel中
     * @param workbook
     * @param sheet
     * @param list
     */
    private void process(String startDate, String endDate, HSSFWorkbook workbook, HSSFSheet sheet, List<DataExportVo> list,
                         String type,String titleName,List<RegisterBatchVo> list1) {
        String startDateStr = DateUtil.dateToString(DateUtil.stringToDate(startDate,DateUtil.FORMAT_DAY),DateUtil.FORMAT_DAY_CN);
        String endDateStr = DateUtil.dateToString(DateUtil.stringToDate(endDate,DateUtil.FORMAT_DAY),DateUtil.FORMAT_DAY_CN);
        int count=0,types=0;
        String titles = "";
        if("0".equals(type)){
            types=4;
            titles = "("+startDateStr+" 至 "+endDateStr+")";
        }else {
            types=5;
            titles = "("+startDateStr+" 至 "+endDateStr+" ，共计"+list.size()+"件)";
        }
        sheet.setDefaultColumnWidth(20);
        //标题样式

        CellStyle style3 = workbook.createCellStyle();
        //设置标题字体格式
        Font font3 = workbook.createFont();
        //设置字体样式
        font3.setFontHeightInPoints((short) 32);
        font3.setFontName("宋体");
        font3.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style3.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        style3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style3.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style3.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style3.setFont(font3);
        //第一行
        Row titleRow = sheet.createRow(count);
        CellRangeAddress CellRangeAddress_0 =  new CellRangeAddress(count,(short)count,0,(short)types);
        sheet.addMergedRegion(CellRangeAddress_0);
        Cell cell1 = titleRow.createCell(0);
        cell1.setCellStyle(style3);
        cell1.setCellValue(titleName);
        sheet.autoSizeColumn(count);
        count++;


        CellStyle style2 = workbook.createCellStyle();
        //设置标题字体格式
        Font font2 = workbook.createFont();
        //设置字体样式
        font2.setFontHeightInPoints((short) 26);
        font2.setFontName("宋体");
        font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style2.setFont(font2);


        //第二行
        CellRangeAddress CellRangeAddress_1 =  new CellRangeAddress(count,(short)count,0,(short)types);
        sheet.addMergedRegion(CellRangeAddress_1);
        Row row1 = sheet.createRow(count);
        Cell cell2 = row1.createCell(0);
        cell2.setCellStyle(style2);
        cell2.setCellValue(titles);
        sheet.autoSizeColumn(count);
        count++;

        //表头样式
        CellStyle style31 = workbook.createCellStyle();
        style31.setFillForegroundColor(HSSFColor.LIME.index);
        style31.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

        //设置标题字体格式
        Font font31 = workbook.createFont();
        //设置字体样式
        font31.setFontHeightInPoints((short) 22);
        font31.setFontName("宋体");
        font31.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);

        font31.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style31.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style31.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        style31.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style31.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style31.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style31.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style31.setFont(font31);
        style31.setWrapText(true);

        //数据样式
        if("1".equals(type)&&list != null){
            Row row4 = sheet.createRow(count);
            Cell cell5_0 = row4.createCell(0);
            cell5_0.setCellStyle(style31);
            cell5_0.setCellValue("序号");

            Cell cell5_1 = row4.createCell(1);
            cell5_1.setCellStyle(style31);
            cell5_1.setCellValue("事由");

            Cell cell5_2 = row4.createCell(2);
            cell5_2.setCellStyle(style31);
            cell5_2.setCellValue("报送领导");

            Cell cell5_3 = row4.createCell(3);
            cell5_3.setCellStyle(style31);
            cell5_3.setCellValue("日期");

            Cell cell5_4 = row4.createCell(4);
            cell5_4.setCellStyle(style31);
            cell5_4.setCellValue("签报人");

            Cell cell5_5 = row4.createCell(5);
            cell5_5.setCellStyle(style31);
            cell5_5.setCellValue("报送单位");
            sheet.autoSizeColumn(count);
            count++;
                CellStyle style3_2 = workbook.createCellStyle();
                //设置标题字体格式
                Font font3_2 = workbook.createFont();
                //设置字体样式
                font3_2.setFontHeightInPoints((short) 18);
                font3_2.setFontName("宋体");
                font3_2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
                style3_2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
                style3_2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
                //表格边框
                style3_2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
                style3_2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
                style3_2.setBorderRight(HSSFCellStyle.BORDER_THIN);
                style3_2.setBorderTop(HSSFCellStyle.BORDER_THIN);
                style3_2.setFont(font3_2);
                //自动换行
                style3_2.setWrapText(true);

                for (int i = 0; i < list.size(); i++) {
                    DataExportVo dataExportVo = list.get(i);
                    Row row = sheet.createRow(count + i);
                    String number = null == dataExportVo.getNumber() ? "" : dataExportVo.getNumber();
                    String title = null == dataExportVo.getTitle() ? "" : dataExportVo.getTitle();
                    String leader = null == dataExportVo.getLeaName() ? "" : dataExportVo.getLeaName();
                    String sendTime = null == dataExportVo.getSendTime() ? "" : dataExportVo.getSendTime();
                    String signature = null == dataExportVo.getSignature() ? "" : dataExportVo.getSignature();
                    String orgName = null == dataExportVo.getOrgName()? "" : dataExportVo.getOrgName();

                    Cell cell_00 = row.createCell(0);
                    cell_00.setCellStyle(style3_2);
                    cell_00.setCellValue(number);
                    Cell cell_0 = row.createCell(1);
                    cell_0.setCellStyle(style3_2);
                    cell_0.setCellValue(title);
                    Cell cell_1 = row.createCell(2);
                    cell_1.setCellStyle(style3_2);
                    cell_1.setCellValue(leader);
                    Cell cell_2 = row.createCell(3);
                    cell_2.setCellStyle(style3_2);
                    cell_2.setCellValue(sendTime);
                    Cell cell_3 = row.createCell(4);
                    cell_3.setCellStyle(style3_2);
                    cell_3.setCellValue(signature);
                    Cell cell_4 = row.createCell(5);
                    cell_4.setCellStyle(style3_2);
                    cell_4.setCellValue(orgName);
                    sheet.autoSizeColumn(count+i);
                }
                sheet.setColumnWidth(1,20000);
        }else if ("0".equals(type)&&list1 != null){
            Row row4 = sheet.createRow(count);
            Cell cell5_0 = row4.createCell(0);
            cell5_0.setCellStyle(style31);
            cell5_0.setCellValue("序号");

            Cell cell5_1 = row4.createCell(1);
            cell5_1.setCellStyle(style31);
            cell5_1.setCellValue("事由");

            Cell cell5_2 = row4.createCell(2);
            cell5_2.setCellStyle(style31);
            cell5_2.setCellValue("主席、副主席批示");

            Cell cell5_3 = row4.createCell(3);
            cell5_3.setCellStyle(style31);
            cell5_3.setCellValue("办公厅和专委会领导批示");

            Cell cell5_5 = row4.createCell(4);
            cell5_5.setCellStyle(style31);
            cell5_5.setCellValue("报送单位");
            sheet.autoSizeColumn(count);
            CellStyle style3_3 = workbook.createCellStyle();
            //设置标题字体格式
            Font font3_2 = workbook.createFont();
            //设置字体样式
            font3_2.setFontHeightInPoints((short) 18);
            font3_2.setFontName("宋体");
            font3_2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
            style3_3.setAlignment(HSSFCellStyle.ALIGN_CENTER);
            style3_3.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            //表格边框
            style3_3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            style3_3.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            style3_3.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style3_3.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style3_3.setFont(font3_2);
            //自动换行
            style3_3.setWrapText(true);
            Row rowi[] = new Row[list1.size()];
            Cell []celli = new Cell[5];
                for (int i = 0; i < list1.size(); i++) {
                    RegisterBatchVo registerBatchVo = list1.get(i);
                    //获取数据
                    String title = null == registerBatchVo.getTitle() ? "" : registerBatchVo.getTitle();
                    String leaName = null == registerBatchVo.getReportLeader() ? "" :registerBatchVo.getReportLeader();
                    String duty = null == registerBatchVo.getDutyName() ? "" :registerBatchVo.getDutyName();
                    String comTime = null == registerBatchVo.getUpdateTimeStr() ? "" :registerBatchVo.getUpdateTimeStr();
                    String conments = null == registerBatchVo.getConmentsLeader() ? "" :registerBatchVo.getConmentsLeader();
                    String comStr = leaName + comTime + conments;
                    String deptName = null == registerBatchVo.getDeptName() ? "" :registerBatchVo.getDeptName();
                    List<LeaderConmentsVo> conlist = registerBatchVo.getLeaderConmentsList();
                    //计算行数
                    int rowNum = conlist.size()/2;
                    Row []rown = new Row[rowNum];
                    Cell []celln = new Cell[5];
                    //首先把实体本身的信息放入表格
                    rowi[i] = sheet.createRow(++count);
                    //rowi[i].setHeight((short)500);
                    celli[0] = rowi[i].createCell(0);
                    celli[0].setCellStyle(style3_3);
                    celli[0].setCellValue(i+1);
                    celli[1] = rowi[i].createCell(1);
                    celli[1].setCellStyle(style3_3);
                    celli[1].setCellValue(title);
                    for (int m=0;m<conlist.size();m++){
                        if ("主席".equals(duty)||"副主席".equals(duty)){
                            celli[2] = rowi[i].createCell(2);
                            celli[2].setCellStyle(style3_3);
                            celli[2].setCellValue(comStr);
                            duty = null;
                            break;
                        }else if (null != conlist.get(m)){
                            LeaderConmentsVo leaderConmentsVo = conlist.get(m);
                            String leaNames = null == leaderConmentsVo.getLeaderName() ? "" :leaderConmentsVo.getLeaderName();
                            String dutys = null == leaderConmentsVo.getDutyName() ? "" :leaderConmentsVo.getDutyName();
                            String comTimes = null == leaderConmentsVo.getTimeStr() ? "" :leaderConmentsVo.getTimeStr();
                            String conment = null == leaderConmentsVo.getConments() ? "" :leaderConmentsVo.getConments();
                            String Strs = leaNames + comTimes + conment;
                            if ("主席".equals(dutys)||"副主席".equals(dutys)){
                                celli[2] = rowi[i].createCell(2);
                                celli[2].setCellStyle(style3_3);
                                celli[2].setCellValue(Strs);
                                conlist.set(m,null);
                                break;
                            }
                        }
                    }
                    for (int n=0;n<conlist.size();n++){
                        if ("办公厅领导".equals(duty)||"专委会领导".equals(duty)){
                            celli[3] = rowi[i].createCell(3);
                            celli[3].setCellStyle(style3_3);
                            celli[3].setCellValue(comStr);
                            duty = null;
                            break;
                        }else if (null != conlist.get(n)){
                            LeaderConmentsVo leaderConmentsVo = conlist.get(n);
                            String leaNames = null == leaderConmentsVo.getLeaderName() ? "" :leaderConmentsVo.getLeaderName();
                            String dutys = null == leaderConmentsVo.getDutyName() ? "" :leaderConmentsVo.getDutyName();
                            String comTimes = null == leaderConmentsVo.getTimeStr() ? "" :leaderConmentsVo.getTimeStr();
                            String conment = null == leaderConmentsVo.getConments() ? "" :leaderConmentsVo.getConments();
                            String Strs = leaNames + comTimes + conment;
                            if ("办公厅领导".equals(dutys)||"专委会领导".equals(dutys)){
                                celli[3] = rowi[i].createCell(3);
                                celli[3].setCellStyle(style3_3);
                                celli[3].setCellValue(Strs);
                                conlist.set(n,null);
                                break;
                            }

                        }
                    }
                    celli[4] = rowi[i].createCell(4);
                    celli[4].setCellStyle(style3_3);
                    celli[4].setCellValue(deptName);

                    sheet.setColumnWidth(0,5000);
                    sheet.setColumnWidth(1,13000);
                    sheet.setColumnWidth(2,13000);
                    sheet.setColumnWidth(3,13000);
                    sheet.setColumnWidth(4,8000);

                    for (int j=0;j<rowNum;j++){
                        rown[j] = sheet.createRow(++count);
                        //rown[j].setHeight((short)500);
                        celln[0] = rown[j].createCell(0);
                        celln[0].setCellStyle(style3_3);
                        //celln[0].setCellValue(i);
                        celln[1] = rown[j].createCell(1);
                        celln[1].setCellStyle(style3_3);
                        //celln[1].setCellValue(title);
                        for (int m=0;m<conlist.size();m++){
                            if ("主席".equals(duty)||"副主席".equals(duty)){
                                celln[2] = rowi[j].createCell(2);
                                celln[2].setCellStyle(style3_3);
                                celln[2].setCellValue(comStr);
                                duty = null;
                                break;
                            }else if (null != conlist.get(m)){
                                LeaderConmentsVo leaderConmentsVo = conlist.get(m);
                                String leaNames = null == leaderConmentsVo.getLeaderName() ? "" :leaderConmentsVo.getLeaderName();
                                String dutys = null == leaderConmentsVo.getDutyName() ? "" :leaderConmentsVo.getDutyName();
                                String comTimes = null == leaderConmentsVo.getTimeStr() ? "" :leaderConmentsVo.getTimeStr();
                                String conment = null == leaderConmentsVo.getConments() ? "" :leaderConmentsVo.getConments();
                                String Strs = leaNames + comTimes + conment;
                                if ("主席".equals(dutys)||"副主席".equals(dutys)){
                                    celln[2] = rown[j].createCell(2);
                                    celln[2].setCellStyle(style3_3);
                                    celln[2].setCellValue(Strs);
                                    conlist.set(m,null);
                                    break;
                                }
                            }
                        }
                        for (int n=0;n<conlist.size();n++){
                            if ("办公厅领导".equals(duty)||"专委会领导".equals(duty)){
                                celln[3] = rown[j].createCell(3);
                                celln[3].setCellStyle(style3_3);
                                celln[3].setCellValue(comStr);
                                duty = null;
                                break;
                            }else if (null != conlist.get(n)){
                                LeaderConmentsVo leaderConmentsVo = conlist.get(n);
                                String leaNames = null == leaderConmentsVo.getLeaderName() ? "" :leaderConmentsVo.getLeaderName();
                                String dutys = null == leaderConmentsVo.getDutyName() ? "" :leaderConmentsVo.getDutyName();
                                String comTimes = null == leaderConmentsVo.getTimeStr() ? "" :leaderConmentsVo.getTimeStr();
                                String conment = null == leaderConmentsVo.getConments() ? "" :leaderConmentsVo.getConments();
                                String Strs = leaNames + comTimes + conment;
                                if ("办公厅领导".equals(dutys)||"专委会领导".equals(dutys)){
                                    celln[3] = rown[j].createCell(3);
                                    celln[3].setCellStyle(style3_3);
                                    celln[3].setCellValue(Strs);
                                    conlist.set(n,null);
                                    break;
                                }

                            }
                        }

                        celln[4] = rown[j].createCell(4);
                        celln[4].setCellStyle(style3_3);
                        //celln[4].setCellValue(deptName);
                        //合并单元格
                        CellRangeAddress rangeAddress = new CellRangeAddress(count-1,count,0,0);
                        CellRangeAddress rangeAddress1 = new CellRangeAddress(count-1,count,1,1);
                        CellRangeAddress rangeAddress2 = new CellRangeAddress(count-1,count,4,4);
                        sheet.addMergedRegion(rangeAddress);
                        sheet.addMergedRegion(rangeAddress1);
                        sheet.addMergedRegion(rangeAddress2);
                        sheet.setColumnWidth((short) 0,5000);
                        sheet.setColumnWidth(1,13000);
                        sheet.setColumnWidth(2,13000);
                        sheet.setColumnWidth(3,13000);
                        sheet.setColumnWidth(4,8000);

                    }

                }
            sheet.setColumnWidth((short) 0,5000);
            sheet.setColumnWidth(1,13000);
            sheet.setColumnWidth(2,13000);
            sheet.setColumnWidth(3,13000);
            sheet.setColumnWidth(4,8000);


        }else if(list == null||list.size() == 0 || list1 == null||list1.size() == 0 ){
            //默认七天内无数据时展示
            if (types == 4){
                count++;
            }
            CellRangeAddress CellRangeAddress_2 =  new CellRangeAddress(count,count,0,(short)types);
            sheet.addMergedRegion(CellRangeAddress_2);
            Row row2 = sheet.createRow(count);
            Cell cell2_1 = row2.createCell(0);
            cell2_1.setCellStyle(style2);
            cell2_1.setCellValue("暂无数据");
            sheet.autoSizeColumn(count);
            setRegionBorder(1,CellRangeAddress_2,sheet,workbook);
        }
        setRegionBorder(1,CellRangeAddress_0,sheet,workbook);
        setRegionBorder(1,CellRangeAddress_1,sheet,workbook);
    }
    public static void setRegionBorder(int border,CellRangeAddress address,HSSFSheet sheet,Workbook wb){
        RegionUtil.setBorderBottom(border,address,sheet,wb);
        RegionUtil.setBorderLeft(border,address,sheet,wb);
        RegionUtil.setBorderRight(border,address,sheet,wb);
        RegionUtil.setBorderTop(border,address,sheet,wb);
    }
}
