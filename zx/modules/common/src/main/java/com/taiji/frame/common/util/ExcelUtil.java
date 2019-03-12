package com.taiji.frame.common.util;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.list.TreeList;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.util.CellRangeAddress;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

/**
 * 模板导出
 * Created by CHX on 2016/4/19.
 * 导入导出Excel
 */
public class ExcelUtil {

    public static final Logger logger = LoggerFactory.getLogger(ExcelUtil.class);

    /**
     *值班模板导出
     * @param os
     * @param fileName
     * @param orgName
     * @param dutyName
     * @param date
     * @param dateList
     * @throws IOException
     * @throws IndexOutOfBoundsException
     */
    public static void createExcel(OutputStream os, String fileName,String orgName,String dutyName, String date, List<String> dateList)
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        process(date, orgName, dutyName, workbook, sheet, dateList);
        workbook.write(os);
    }

    /**
     * 模板导出写入数据
     * @param date
     * @param workbook
     * @param sheet
     * @param dateList
     */
    public static void process(String date,String orgName,String dutyName,HSSFWorkbook workbook,HSSFSheet sheet,List<String> dateList){
        //标题样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 16);//字体大小；
        font.setFontName("宋体");
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        titleStyle.setFillForegroundColor(HSSFColor.BROWN.index);
        titleStyle.setFillForegroundColor(HSSFColor.GREY_50_PERCENT.index);
        titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setFont(font);
        //日期备注样式
        HSSFCellStyle cowStyle = workbook.createCellStyle();
        Font cowFont = workbook.createFont();
        cowFont.setFontHeightInPoints((short) 14);//字体大小；
        cowFont.setFontName("宋体");
        cowFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        cowStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cowStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        cowStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cowStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cowStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        cowStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        cowStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cowStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        cowStyle.setFont(cowFont);

        //小标题样式
        HSSFCellStyle colStyle = workbook.createCellStyle();
        Font colFont = workbook.createFont();
        colFont.setFontHeightInPoints((short) 14);//字体大小；
        colFont.setFontName("宋体");
        colFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        colStyle.setFillForegroundColor(HSSFColor.BROWN.index);
        colStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        colStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        colStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        colStyle.setFont(colFont);

        //标题
        HSSFRow titleRow = sheet.createRow(0);
        sheet.addMergedRegion(new CellRangeAddress(0, (short) 1, 0, (short) 7));//合并单元格
        HSSFCell cell = titleRow.createCell(0);//第一个单元格
        cell.setCellStyle(titleStyle);
        cell.setCellValue(orgName+dutyName+"值班表");

        //表头
        HSSFRow tableRow = sheet.createRow(2);
        sheet.addMergedRegion(new CellRangeAddress(2, (short) 3, 0, (short) 0));//合并单元格
        sheet.addMergedRegion(new CellRangeAddress(2, (short) 2, 1, (short) 3));//合并单元格
        sheet.addMergedRegion(new CellRangeAddress(2, (short) 2, 4, (short) 6));//合并单元格
        sheet.addMergedRegion(new CellRangeAddress(2, (short) 3, 7, (short) 7));//合并单元格

        HSSFCell dateCell = tableRow.createCell(0);//第一个单元格
        dateCell.setCellStyle(cowStyle);
        dateCell.setCellValue("日期");

        HSSFCell rmksCell = tableRow.createCell(7);
        rmksCell.setCellValue("备注");
        rmksCell.setCellStyle(cowStyle);

        HSSFCell personCell = tableRow.createCell(4);
        personCell.setCellStyle(colStyle);
        personCell.setCellValue("值班员");
        HSSFCell blankCell = tableRow.createCell(1);
        blankCell.setCellStyle(colStyle);
        HSSFCell blankCell1 = tableRow.createCell(2);
        blankCell1.setCellStyle(colStyle);
        HSSFCell blankCell2 = tableRow.createCell(3);
        blankCell2.setCellStyle(colStyle);
        HSSFCell blankCell6 = tableRow.createCell(6);
        blankCell6.setCellStyle(colStyle);
        HSSFCell blankCell5 = tableRow.createCell(5);
        blankCell5.setCellStyle(colStyle);

        HSSFRow tableRow2 = sheet.createRow(3);
        HSSFCell blankCell8 = tableRow2.createCell(0);
        blankCell8.setCellStyle(colStyle);
        HSSFCell blankCell9 = tableRow2.createCell(7);
        blankCell9.setCellStyle(colStyle);
        HSSFCell leaderCell = tableRow2.createCell(1);
        leaderCell.setCellStyle(colStyle);
        HSSFCell jobCell = tableRow2.createCell(2);
        jobCell.setCellStyle(colStyle);
        HSSFCell telCell = tableRow2.createCell(3);
        telCell.setCellStyle(colStyle);
        HSSFCell dayCell = tableRow2.createCell(4);
        dayCell.setCellStyle(colStyle);
        HSSFCell nightCell = tableRow2.createCell(5);
        nightCell.setCellStyle(colStyle);
        HSSFCell dutyPhoneCell = tableRow2.createCell(6);
        dutyPhoneCell.setCellStyle(colStyle);
        leaderCell.setCellValue("领导");
        jobCell.setCellValue("职务");
        telCell.setCellValue("电话");
        dayCell.setCellValue("白天");
        nightCell.setCellValue("晚上");
        dutyPhoneCell.setCellValue("值班电话");

        //数据题样式
        HSSFCellStyle dataStyle = workbook.createCellStyle();
        dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);

        //数据
        for(int i = 0 ; i<dateList.size() ;i++){
            HSSFRow dataRow = sheet.createRow(4 + i);
            dataRow.setHeight((short)300);
            sheet.setColumnWidth(0,5000);
            HSSFCell dataCell = dataRow.createCell(0);
            dataCell.setCellStyle(dataStyle);
            dataCell.setCellValue(dateList.get(i));
            for(int j = 1;j < 8;j++){
                sheet.setColumnWidth(j,5000);
                HSSFCell blankTCell = dataRow.createCell(j);
                blankTCell.setCellStyle(dataStyle);
            }
        }
        sheet.addMergedRegion(new CellRangeAddress(4, (short)3+dateList.size(), 6, (short) 6));//值班电话
        sheet.addMergedRegion(new CellRangeAddress(4, (short)3+dateList.size(), 7, (short) 7));//备注单元格

        //填报时间
        HSSFRow lastRow = sheet.createRow(dateList.size()+5);
        lastRow.setHeight((short) 400);
        HSSFCell lastCell = lastRow.createCell(6);
        lastCell.setCellStyle(colStyle);
        lastCell.setCellValue("报送时间：");
        HSSFCell timeCell = lastRow.createCell(7);
        timeCell.setCellStyle(colStyle);
        timeCell.setCellValue(date);
    }

    public static void createPersonExcel(OutputStream os, String fileName,JSONArray jsonArray )
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        processPerson(sheet, jsonArray, workbook, fileName);
        workbook.write(os);
    }

    public static void processPerson(HSSFSheet sheet,JSONArray jsonArray,HSSFWorkbook workbook,String fileName){
//标题样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 18);//字体大小；
        font.setFontName("宋体");
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setFont(font);

        sheet.addMergedRegion(new CellRangeAddress(0, (short) 1, 0, (short) 8));//合并单元格
        HSSFRow titleRow = sheet.createRow(0);
        HSSFCell cell = titleRow.createCell(0);//第一个单元格
        cell.setCellStyle(titleStyle);
        cell.setCellValue(fileName);

        //表头

        //样式
        HSSFCellStyle colStyle = workbook.createCellStyle();
        Font colFont = workbook.createFont();
        colFont.setFontHeightInPoints((short) 12);//字体大小；
        colFont.setFontName("宋体");
        colFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        colStyle.setFillForegroundColor(HSSFColor.BROWN.index);
        colStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        colStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        colStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        colStyle.setFont(colFont);

        HSSFRow tableRow = sheet.createRow(2);
        HSSFCell orgCell = tableRow.createCell(0);
        orgCell.setCellStyle(colStyle);
        orgCell.setCellValue("机构");
        HSSFCell dateCell = tableRow.createCell(1);
        dateCell.setCellStyle(colStyle);
        dateCell.setCellValue("日期");
        HSSFCell leaderCell = tableRow.createCell(2);
        leaderCell.setCellStyle(colStyle);
        leaderCell.setCellValue("带班领导");
        HSSFCell jobCell = tableRow.createCell(3);
        jobCell.setCellStyle(colStyle);
        jobCell.setCellValue("职务");
        HSSFCell telCell = tableRow.createCell(4);
        telCell.setCellStyle(colStyle);
        telCell.setCellValue("联系电话");
        HSSFCell dayCell = tableRow.createCell(5);
        dayCell.setCellStyle(colStyle);
        dayCell.setCellValue("白班");
        HSSFCell nightCell = tableRow.createCell(6);
        nightCell.setCellStyle(colStyle);
        nightCell.setCellValue("晚班");
        HSSFCell dutyPhoneCell = tableRow.createCell(7);
        dutyPhoneCell.setCellStyle(colStyle);
        dutyPhoneCell.setCellValue("值班电话");
        HSSFCell rmksCell = tableRow.createCell(8);
        rmksCell.setCellStyle(colStyle);
        rmksCell.setCellValue("备注");

        for(int i = 0 ;i< 9;i++){
            sheet.setColumnWidth(i,5000);
        }

        //数据题样式
        HSSFCellStyle dataStyle = workbook.createCellStyle();
        dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        dataStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        dataStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        dataStyle.setWrapText(true);

        int comNum = 3;
        for(int i = 0 ;i <jsonArray.size();i++){
            JSONObject jsonObject = (JSONObject) jsonArray.get(i);
            String orgName = jsonObject.getString("orgName");
            JSONArray array = jsonObject.getJSONArray("upList");
            sheet.addMergedRegion(new CellRangeAddress(comNum, (short) comNum+array.size()-1, 0, (short) 0));//合并单元格
            sheet.addMergedRegion(new CellRangeAddress(comNum, (short) comNum+array.size()-1, 7, (short) 7));//合并单元格
            sheet.addMergedRegion(new CellRangeAddress(comNum, (short) comNum+array.size()-1, 8, (short) 8));//合并单元格

            for(int j = 0 ; j <array.size();j++){
                JSONObject object = (JSONObject) array.get(j);
                HSSFRow row = sheet.createRow(comNum + j);
                if(j == 0){
                    HSSFCell org = row.createCell(0);
                    org.setCellValue(orgName);
                    HSSFCell phoneCom = row.createCell(7);
                    phoneCom.setCellStyle(dataStyle);
                    org.setCellStyle(dataStyle);
                    HSSFCell rmksCom = row.createCell(8);
                    String dutyPhone = object.getString("dutyPhone");
                    String rmks = object.getString("rmks");
                    phoneCom.setCellValue(dutyPhone);
                    phoneCom.setCellStyle(dataStyle);
                    rmksCom.setCellValue(rmks);
                    rmksCom.setCellStyle(dataStyle);
                }else{
                    HSSFCell blankOrg = row.createCell(0);
                    blankOrg.setCellStyle(dataStyle);
                    HSSFCell blankPhoneCom = row.createCell(7);
                    blankPhoneCom.setCellStyle(dataStyle);

                    HSSFCell blankRmksCom = row.createCell(8);
                    blankRmksCom.setCellStyle(dataStyle);
                }
                String dutyDate = object.getString("dutyDate");
                String leader = object.getString("leader");
                String leaderPosition = object.getString("leaderPosition");
                String leaderPhone = object.getString("leaderPhone");
                String dayname = object.getString("dayname");
                String nightname = object.getString("nightname");


                HSSFCell dateCom = row.createCell(1);
                dateCom.setCellValue(dutyDate);
                dateCom.setCellStyle(dataStyle);

                HSSFCell leaderCom = row.createCell(2);
                leaderCom.setCellValue(leader);
                leaderCom.setCellStyle(dataStyle);

                HSSFCell jobCom = row.createCell(3);
                jobCom.setCellValue(leaderPosition);
                jobCom.setCellStyle(dataStyle);

                HSSFCell leadPhoneCom = row.createCell(4);
                leadPhoneCom.setCellValue(leaderPhone);
                leadPhoneCom.setCellStyle(dataStyle);

                HSSFCell dayCom = row.createCell(5);
                dayCom.setCellValue(dayname);
                dayCom.setCellStyle(dataStyle);

                HSSFCell nightCom = row.createCell(6);
                nightCom.setCellValue(nightname);
                nightCom.setCellStyle(dataStyle);


            }
            comNum+=array.size();
        }

        //数据
    }

    public static void createAddressExcel(OutputStream os, String fileName,JSONArray jsonArray )
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        processAddress(sheet, jsonArray, workbook, fileName);
        workbook.write(os);
    }

    public static void processAddress(HSSFSheet sheet,JSONArray jsonArray,HSSFWorkbook workbook,String fileName){

        //标题样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 18);//字体大小；
        font.setFontName("宋体");
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setFont(font);

        sheet.addMergedRegion(new CellRangeAddress(0, (short) 1, 0, (short) 5));//合并单元格
        HSSFRow titleRow = sheet.createRow(0);
        HSSFCell cell = titleRow.createCell(0);//第一个单元格
        cell.setCellStyle(titleStyle);
        cell.setCellValue(fileName);

        //表头

        //样式
        HSSFCellStyle colStyle = workbook.createCellStyle();
        Font colFont = workbook.createFont();
        colFont.setFontHeightInPoints((short) 12);//字体大小；
        colFont.setFontName("宋体");
        colFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        colStyle.setFillForegroundColor(HSSFColor.BROWN.index);
        colStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        colStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        colStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        colStyle.setFont(colFont);

        HSSFRow tableRow = sheet.createRow(2);
        HSSFCell empName = tableRow.createCell(0);
        empName.setCellStyle(colStyle);
        empName.setCellValue("姓名");
        HSSFCell dicDept = tableRow.createCell(1);
        dicDept.setCellStyle(colStyle);
        dicDept.setCellValue("部门");
        HSSFCell position = tableRow.createCell(2);
        position.setCellStyle(colStyle);
        position.setCellValue("职位");
        HSSFCell phone = tableRow.createCell(3);
        phone.setCellStyle(colStyle);
        phone.setCellValue("办公电话");
        HSSFCell mobile = tableRow.createCell(4);
        mobile.setCellStyle(colStyle);
        mobile.setCellValue("手机");
        HSSFCell email = tableRow.createCell(5);
        email.setCellStyle(colStyle);
        email.setCellValue("E-mail");

        for(int i = 0 ;i< 6;i++){
            sheet.setColumnWidth(i,5000);
        }

        //数据题样式
        HSSFCellStyle dataStyle = workbook.createCellStyle();
        dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        dataStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        dataStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        dataStyle.setWrapText(true);


            for(int j = 0 ; j <jsonArray.size();j++){
                JSONObject object = (JSONObject) jsonArray.get(j);
                HSSFRow row = sheet.createRow(j+3);

                String empName1 = object.getString("empName");
                String dicDept1 = object.getString("dicDept");
                String position1 = object.getString("position");
                String phone1 = object.getString("phone");
                String mobile1 = object.getString("mobile");
                String email1 = object.getString("email");

                HSSFCell empNameCom = row.createCell(0);
                empNameCom.setCellValue(empName1);
                empNameCom.setCellStyle(dataStyle);

                HSSFCell dicDeptCom = row.createCell(1);
                dicDeptCom.setCellValue(dicDept1);
                dicDeptCom.setCellStyle(dataStyle);

                HSSFCell positionCom = row.createCell(2);
                positionCom.setCellValue(position1);
                positionCom.setCellStyle(dataStyle);

                HSSFCell phoneCom = row.createCell(3);
                phoneCom.setCellValue(phone1);
                phoneCom.setCellStyle(dataStyle);

                HSSFCell mobileCom = row.createCell(4);
                mobileCom.setCellValue(mobile1);
                mobileCom.setCellStyle(dataStyle);

                HSSFCell emailCom = row.createCell(5);
                emailCom.setCellValue(email1);
                emailCom.setCellStyle(dataStyle);

            }
//            comNum+=jsonArray.size();


        //数据


    }

    public static void createEmegStatisticsExcel(OutputStream os, String fileName,JSONArray jsonArray )
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        processEmegStatistics(sheet, jsonArray, workbook, fileName);
        workbook.write(os);
    }

    public static void processEmegStatistics(HSSFSheet sheet,JSONArray jsonArray,HSSFWorkbook workbook,String fileName){

        //标题样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 18);//字体大小；
        font.setFontName("宋体");
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setFont(font);

        sheet.addMergedRegion(new CellRangeAddress(0, (short) 1, 0, (short) 10));//合并单元格
        HSSFRow titleRow = sheet.createRow(0);
        HSSFCell cell = titleRow.createCell(0);//第一个单元格
        cell.setCellStyle(titleStyle);
        cell.setCellValue(fileName);

        //表头

        //样式
        HSSFCellStyle colStyle = workbook.createCellStyle();
        Font colFont = workbook.createFont();
        colFont.setFontHeightInPoints((short) 12);//字体大小；
        colFont.setFontName("宋体");
        colFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        colStyle.setFillForegroundColor(HSSFColor.BROWN.index);
        colStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        colStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        colStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        colStyle.setFont(colFont);

        HSSFRow tableRow = sheet.createRow(2);
        HSSFCell num1 = tableRow.createCell(0);
        num1.setCellStyle(colStyle);
        num1.setCellValue("序号");
        HSSFCell typeName = tableRow.createCell(3);
        typeName.setCellStyle(colStyle);
        typeName.setCellValue("类别");
        HSSFCell orderNum = tableRow.createCell(1);
        orderNum.setCellStyle(colStyle);
        orderNum.setCellValue("编号");
        HSSFCell newTitle = tableRow.createCell(2);
        newTitle.setCellStyle(colStyle);
        newTitle.setCellValue("应急内容");
        HSSFCell newEmlevel = tableRow.createCell(4);
        newEmlevel.setCellStyle(colStyle);
        newEmlevel.setCellValue("级别");
        HSSFCell statusl = tableRow.createCell(5);
        statusl.setCellStyle(colStyle);
        statusl.setCellValue("状态");
        HSSFCell issueEmp = tableRow.createCell(6);
        issueEmp.setCellStyle(colStyle);
        issueEmp.setCellValue("签发人");
        HSSFCell issueTime = tableRow.createCell(7);
        issueTime.setCellStyle(colStyle);
        issueTime.setCellValue("签发时间");
        HSSFCell days = tableRow.createCell(8);
        days.setCellStyle(colStyle);
        days.setCellValue("应急天数");
        HSSFCell sumDays1 = tableRow.createCell(9);
        sumDays1.setCellStyle(colStyle);
        sumDays1.setCellValue("总天数");
        HSSFCell provNames1 = tableRow.createCell(10);
        provNames1.setCellStyle(colStyle);
        provNames1.setCellValue("响应区域");

        for(int i = 0 ;i< 11;i++){
            sheet.setColumnWidth(i,5000);
        }

        //数据题样式
        HSSFCellStyle dataStyle = workbook.createCellStyle();
        dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        dataStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        dataStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        dataStyle.setWrapText(true);
        Integer count = 1;

        Set<String> emegIdSet = new LinkedHashSet<>();
        for(Object object:jsonArray){
            emegIdSet.add(JSONObject.fromObject(object).getString("emegId"));
        }
        JSONArray viEmegArray = new JSONArray();
        for(String str :emegIdSet){
            TreeList treeList = new TreeList();
            for(Object object:jsonArray){
                if(JSONObject.fromObject(object).getString("emegId").equals(str)){
                    treeList.add(object);
                }
            }
            viEmegArray.add(treeList);
        }

        int k=0;
        JSONObject obj = new JSONObject();
        JSONArray jsonArray1 = new JSONArray();
        for(int i = 0 ;i <viEmegArray.size();i++){
            JSONArray array = JSONArray.fromObject(viEmegArray.get(i));
            Double numDays = 0.0;
            for(int l = 0 ; l <array.size();l++){
                JSONObject object1 = JSONObject.fromObject(array.get(l));
                if(!"0".equals(object1.getString("days"))) {
                    numDays += Double.parseDouble(object1.getString("days"));
                }
            }
            for(int j = 0 ; j <array.size();j++){
                JSONObject object = (JSONObject) array.get(j);
                HSSFRow row = sheet.createRow(k+3);


                if(j==0){
                    Integer num = count;
                    String typeName1 = object.getString("typeName");
                    Double sumDays = numDays;
                    String provNames = object.getString("provNames");

                    HSSFCell numCom = row.createCell(0);
                    numCom.setCellValue(num);
                    numCom.setCellStyle(dataStyle);

                    HSSFCell typeNameCom = row.createCell(3);
                    typeNameCom.setCellValue(typeName1);
                    typeNameCom.setCellStyle(dataStyle);

                    HSSFCell sumDaysCom = row.createCell(9);
                    sumDaysCom.setCellValue(sumDays);
                    sumDaysCom.setCellStyle(dataStyle);

                    HSSFCell provNamesCom = row.createCell(10);
                    provNamesCom.setCellValue(provNames);
                    provNamesCom.setCellStyle(dataStyle);

                }else{
                    HSSFCell numCom = row.createCell(0);
                    numCom.setCellValue("");
                    numCom.setCellStyle(dataStyle);

                    HSSFCell typeNameCom = row.createCell(3);
                    typeNameCom.setCellValue("");
                    typeNameCom.setCellStyle(dataStyle);

                    HSSFCell sumDaysCom = row.createCell(9);
                    sumDaysCom.setCellValue("");
                    sumDaysCom.setCellStyle(dataStyle);

                    HSSFCell provNamesCom = row.createCell(10);
                    provNamesCom.setCellValue("");
                    provNamesCom.setCellStyle(dataStyle);
                }

                String orderNum1 = object.getString("orderNum");
                String newTitle1 = object.getString("newTitle");
                String newEmlevel1 = object.getString("newEmLevel");
                String issueEmp1 = object.getString("issueEmp");
                String issueTime1 = object.getString("issueTime");
                String days1 = object.getString("days");
                String orderTypeName = object.getString("orderTypeName");

                HSSFCell orderNumCom = row.createCell(1);
                orderNumCom.setCellValue(orderNum1);
                orderNumCom.setCellStyle(dataStyle);

                HSSFCell newTitleCom = row.createCell(2);
                newTitleCom.setCellValue(newTitle1);
                newTitleCom.setCellStyle(dataStyle);

                HSSFCell newEmlevelCom = row.createCell(4);
                newEmlevelCom.setCellValue(newEmlevel1);
                newEmlevelCom.setCellStyle(dataStyle);

                HSSFCell orderTypeNameCom = row.createCell(5);
                orderTypeNameCom.setCellValue(orderTypeName);
                orderTypeNameCom.setCellStyle(dataStyle);

                HSSFCell issueEmp1Com = row.createCell(6);
                issueEmp1Com.setCellValue(issueEmp1);
                issueEmp1Com.setCellStyle(dataStyle);

                HSSFCell issueTimeCom = row.createCell(7);
                issueTimeCom.setCellValue(issueTime1);
                issueTimeCom.setCellStyle(dataStyle);

                HSSFCell daysCom = row.createCell(8);
                daysCom.setCellValue(days1);
                daysCom.setCellStyle(dataStyle);

                if(j==1){
                    obj.put("start",k+2);
                    obj.put("end",array.size()+k+1);
                    jsonArray1.add(obj);
                }
                k++;
            }
            count++;
        }
        if(jsonArray1.size()>0){
            for(Object object:jsonArray1){
                int start = (int)JSONObject.fromObject(object).get("start");
                int end = (int) JSONObject.fromObject(object).get("end");
                sheet.addMergedRegion(new CellRangeAddress(start, end, 0, (short) 0));
                sheet.addMergedRegion(new CellRangeAddress(start, end, 3, (short) 3));
                sheet.addMergedRegion(new CellRangeAddress(start, end, 9, (short) 9));
                sheet.addMergedRegion(new CellRangeAddress(start, end, 10, (short) 10));
            }
        }
        //数据
    }

    public static void createAccdTypeStatisticsExcel(OutputStream os, String fileName,JSONArray jsonArray )
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        processAccdTypeStatistics(sheet, jsonArray, workbook, fileName);
        workbook.write(os);
    }

    public static void processAccdTypeStatistics(HSSFSheet sheet,JSONArray jsonArray,HSSFWorkbook workbook,String fileName){

        //标题样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 18);//字体大小；
        font.setFontName("宋体");
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setFont(font);

        sheet.addMergedRegion(new CellRangeAddress(0, (short) 1, 0, (short) 6));//合并单元格
        HSSFRow titleRow = sheet.createRow(0);
        HSSFCell cell = titleRow.createCell(0);//第一个单元格
        cell.setCellStyle(titleStyle);
        cell.setCellValue(fileName);

        //表头

        //样式
        HSSFCellStyle colStyle = workbook.createCellStyle();
        Font colFont = workbook.createFont();
        colFont.setFontHeightInPoints((short) 12);//字体大小；
        colFont.setFontName("宋体");
        colFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        colStyle.setFillForegroundColor(HSSFColor.BROWN.index);
        colStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        colStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        colStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        colStyle.setFont(colFont);

        HSSFRow tableRow = sheet.createRow(2);
        HSSFCell num1 = tableRow.createCell(0);
        num1.setCellStyle(colStyle);
        num1.setCellValue("序号");
        HSSFCell accdType1 = tableRow.createCell(1);
        accdType1.setCellStyle(colStyle);
        accdType1.setCellValue("事件属性");
        HSSFCell repType1 = tableRow.createCell(2);
        repType1.setCellStyle(colStyle);
        repType1.setCellValue("状态");
        HSSFCell firstTitle1 = tableRow.createCell(3);
        firstTitle1.setCellStyle(colStyle);
        firstTitle1.setCellValue("标题");
        HSSFCell orgName1 = tableRow.createCell(4);
        orgName1.setCellStyle(colStyle);
        orgName1.setCellValue("报送机构");
        HSSFCell issuer1 = tableRow.createCell(5);
        issuer1.setCellStyle(colStyle);
        issuer1.setCellValue("签发人");
        HSSFCell submitDate1 = tableRow.createCell(6);
        submitDate1.setCellStyle(colStyle);
        submitDate1.setCellValue("报送时间");

        for(int i = 0 ;i< 7;i++){
            sheet.setColumnWidth(i,5000);
        }

        //数据题样式
        HSSFCellStyle dataStyle = workbook.createCellStyle();
        dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        dataStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        dataStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        dataStyle.setWrapText(true);
        Integer count = 1;

        Set<String> accdIdSet = new LinkedHashSet<>();
        for(Object object:jsonArray){
            accdIdSet.add(JSONObject.fromObject(object).getString("accdId"));
        }
        JSONArray viReportArray = new JSONArray();
        for(String str :accdIdSet){
            TreeList treeList = new TreeList();
            for(Object object:jsonArray){
                if(JSONObject.fromObject(object).getString("accdId").equals(str)){
                    treeList.add(object);
                }
            }
            viReportArray.add(treeList);
        }

        int k=0;
        //存放合并单元格起始位置
        JSONObject obj = new JSONObject();
        JSONArray jsonArray1 = new JSONArray();
        for(int i = 0 ;i <viReportArray.size();i++){
            JSONArray array = JSONArray.fromObject(viReportArray.get(i));
            for(int j = 0 ; j <array.size();j++){
                JSONObject object = JSONObject.fromObject(array.get(j));
                HSSFRow row = sheet.createRow(k + 3);
                if(j==0){
                    Integer num = count;
                    String accdType = object.getString("accdType");

                    HSSFCell numCom = row.createCell(0);
                    numCom.setCellValue(num);
                    numCom.setCellStyle(dataStyle);

                    HSSFCell accdTypeCom = row.createCell(1);
                    accdTypeCom.setCellValue(accdType);
                    accdTypeCom.setCellStyle(dataStyle);
                }else{
                    HSSFCell numCom = row.createCell(0);
                    numCom.setCellValue("");
                    numCom.setCellStyle(dataStyle);

                    HSSFCell accdTypeCom = row.createCell(1);
                    accdTypeCom.setCellValue("");
                    accdTypeCom.setCellStyle(dataStyle);
                }
                String repType = object.getString("repType");
                String firstTitle = object.getString("firstTitle");
                String orgName = object.getString("orgName");
                String issuer = object.getString("issuer");
                String submitDate = object.getString("submitDate");



                HSSFCell repTypeCom = row.createCell(2);
                repTypeCom.setCellValue(repType);
                repTypeCom.setCellStyle(dataStyle);

                HSSFCell firstTitleCom = row.createCell(3);
                firstTitleCom.setCellValue(firstTitle);
                firstTitleCom.setCellStyle(dataStyle);

                HSSFCell orgNameCom = row.createCell(4);
                orgNameCom.setCellValue(orgName);
                orgNameCom.setCellStyle(dataStyle);

                HSSFCell issuerCom = row.createCell(5);
                issuerCom.setCellValue(issuer);
                issuerCom.setCellStyle(dataStyle);

                HSSFCell submitDateCom = row.createCell(6);
                submitDateCom.setCellValue(submitDate);
                submitDateCom.setCellStyle(dataStyle);
                //如果大于1则需要合并获取开始和结束位置
                if(j==1){
                    obj.put("start",k+2);
                    obj.put("end",array.size()+k+1);
                    jsonArray1.add(obj);
                }
                k++;
            }
            count++;
        }
        if(jsonArray1.size()>0){
            for(Object object:jsonArray1){
                int start = (int)JSONObject.fromObject(object).get("start");
                int end = (int) JSONObject.fromObject(object).get("end");
                sheet.addMergedRegion(new CellRangeAddress(start, end, 0, (short) 0));
                sheet.addMergedRegion(new CellRangeAddress(start, end, 1, (short) 1));
            }
        }
        //数据


    }

    public static void createSpecStatisticsExcel(OutputStream os, String fileName,JSONArray jsonArray )
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        processSpecStatistics(sheet, jsonArray, workbook, fileName);
        workbook.write(os);
    }

    public static void processSpecStatistics(HSSFSheet sheet,JSONArray jsonArray,HSSFWorkbook workbook,String fileName){

        //标题样式
        HSSFCellStyle titleStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 18);//字体大小；
        font.setFontName("宋体");
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setFont(font);

        sheet.addMergedRegion(new CellRangeAddress(0, (short) 1, 0, (short) 7));//合并单元格
        HSSFRow titleRow = sheet.createRow(0);
        HSSFCell cell = titleRow.createCell(0);//第一个单元格
        cell.setCellStyle(titleStyle);
        cell.setCellValue(fileName);

        //表头

        //样式
        HSSFCellStyle colStyle = workbook.createCellStyle();
        Font colFont = workbook.createFont();
        colFont.setFontHeightInPoints((short) 12);//字体大小；
        colFont.setFontName("宋体");
        colFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
        colStyle.setFillForegroundColor(HSSFColor.BROWN.index);
        colStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        colStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        colStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        colStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        colStyle.setFont(colFont);

        HSSFRow tableRow = sheet.createRow(2);
        HSSFCell num1 = tableRow.createCell(0);
        num1.setCellStyle(colStyle);
        num1.setCellValue("序号");
        HSSFCell specTitle = tableRow.createCell(1);
        specTitle.setCellStyle(colStyle);
        specTitle.setCellValue("特别工作状态");
        HSSFCell status1 = tableRow.createCell(2);
        status1.setCellStyle(colStyle);
        status1.setCellValue("状态");
        HSSFCell issueEmp1 = tableRow.createCell(3);
        issueEmp1.setCellStyle(colStyle);
        issueEmp1.setCellValue("签发人");
        HSSFCell issueTime1 = tableRow.createCell(4);
        issueTime1.setCellStyle(colStyle);
        issueTime1.setCellValue("签发时间");
        HSSFCell days1 = tableRow.createCell(5);
        days1.setCellStyle(colStyle);
        days1.setCellValue("响应天数");
        HSSFCell sumDays1 = tableRow.createCell(6);
        sumDays1.setCellStyle(colStyle);
        sumDays1.setCellValue("总天数");
        HSSFCell provName1 = tableRow.createCell(7);
        provName1.setCellStyle(colStyle);
        provName1.setCellValue("区域信息");

        for(int i = 0 ;i< 8;i++){
            sheet.setColumnWidth(i,5000);
        }

        //数据题样式
        HSSFCellStyle dataStyle = workbook.createCellStyle();
        dataStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        dataStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        dataStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        dataStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        dataStyle.setWrapText(true);
        Integer count = 1;

        Set<String> specIdSet = new LinkedHashSet<>();
        for(Object object:jsonArray){
            specIdSet.add(JSONObject.fromObject(object).getString("specId"));
        }
        JSONArray viSpecArray = new JSONArray();
        for(String str :specIdSet){
            TreeList treeList = new TreeList();
            for(Object object:jsonArray){
                if(JSONObject.fromObject(object).getString("specId").equals(str)){
                    treeList.add(object);
                }
            }
            viSpecArray.add(treeList);
        }

        int k=0;
        //存放合并单元格起始位置
        JSONObject obj = new JSONObject();
        JSONArray jsonArray1 = new JSONArray();
        for(int i = 0 ;i <viSpecArray.size();i++){
            JSONArray array = JSONArray.fromObject(viSpecArray.get(i));
            Double numDays = 0.0;
            for(int l = 0 ; l <array.size();l++){
                JSONObject object1 = JSONObject.fromObject(array.get(l));
                if(!"0".equals(object1.getString("days")) && ("1".equals(object1.getString("orderType"))||"5".equals(object1.getString("orderType")))) {
                    numDays += Double.parseDouble(object1.getString("days"));
                }
            }
            for(int j = 0 ; j <array.size();j++){
                JSONObject object = JSONObject.fromObject(array.get(j));
                HSSFRow row = sheet.createRow(k + 3);

                if(j==0){
                    Integer num = count;
                    String title = object.getString("title");
                    Double sumDays = numDays;
                    String provNames = object.getString("provNames");

                    HSSFCell numCom = row.createCell(0);
                    numCom.setCellValue(num);
                    numCom.setCellStyle(dataStyle);

                    HSSFCell titleCom = row.createCell(1);
                    titleCom.setCellValue(title);
                    titleCom.setCellStyle(dataStyle);

                    HSSFCell sumDaysCom = row.createCell(6);
                    sumDaysCom.setCellValue(sumDays);
                    sumDaysCom.setCellStyle(dataStyle);

                    HSSFCell provNamesCom = row.createCell(7);
                    provNamesCom.setCellValue(provNames);
                    provNamesCom.setCellStyle(dataStyle);
                }else{
                    HSSFCell numCom = row.createCell(0);
                    numCom.setCellValue("");
                    numCom.setCellStyle(dataStyle);

                    HSSFCell accdTypeCom = row.createCell(1);
                    accdTypeCom.setCellValue("");
                    accdTypeCom.setCellStyle(dataStyle);

                    HSSFCell sumDaysCom = row.createCell(6);
                    sumDaysCom.setCellValue("");
                    sumDaysCom.setCellStyle(dataStyle);

                    HSSFCell provNamesCom = row.createCell(7);
                    provNamesCom.setCellValue("");
                    provNamesCom.setCellStyle(dataStyle);
                }
                String status = object.getString("orderTypeName");
                String issueEmp = object.getString("issueEmp");
                String issueTime = object.getString("issueTime");
                String days = object.getString("days");

                HSSFCell statusCom = row.createCell(2);
                statusCom.setCellValue(status);
                statusCom.setCellStyle(dataStyle);

                HSSFCell issueEmpCom = row.createCell(3);
                issueEmpCom.setCellValue(issueEmp);
                issueEmpCom.setCellStyle(dataStyle);

                HSSFCell issueTimeCom = row.createCell(4);
                issueTimeCom.setCellValue(issueTime);
                issueTimeCom.setCellStyle(dataStyle);

                HSSFCell daysCom = row.createCell(5);
                daysCom.setCellValue(days);
                daysCom.setCellStyle(dataStyle);


                //如果大于1则需要合并获取开始和结束位置
                if(j==1){
                    obj.put("start",k+2);
                    obj.put("end",array.size()+k+1);
                    jsonArray1.add(obj);
                }
                k++;
            }
            count++;
        }
        if(jsonArray1.size()>0){
            for(Object object:jsonArray1){
                int start = (int)JSONObject.fromObject(object).get("start");
                int end = (int) JSONObject.fromObject(object).get("end");
                sheet.addMergedRegion(new CellRangeAddress(start, end, 0, (short) 0));
                sheet.addMergedRegion(new CellRangeAddress(start, end, 1, (short) 1));
                sheet.addMergedRegion(new CellRangeAddress(start, end, 6, (short) 6));
                sheet.addMergedRegion(new CellRangeAddress(start, end, 7, (short) 7));
            }
        }
        //数据
    }

}
