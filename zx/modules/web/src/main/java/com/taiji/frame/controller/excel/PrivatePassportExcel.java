package com.taiji.frame.controller.excel;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.privateAbroad.PrivatePassport;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;

import java.io.IOException;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.List;

/**
 * 因私护照Excel导出
 * Created by yuLei on 2018/8/2.
 */
public class PrivatePassportExcel {

    /**
     * 创建Excel文件
     * @param os
     * @param fileName
     * @param curDate
     * @param curUser
     * @param privatePassportList
     * @throws IOException
     * @throws IndexOutOfBoundsException
     */
    public static void createExcel(OutputStream os, String fileName, String curDate, String curUser, List<PrivatePassport> privatePassportList)
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        process(curDate, curUser, workbook, sheet, privatePassportList);
        workbook.write(os);
    }


    /**
     * 将数据写入Excel中
     * @param curDate
     * @param curUser
     * @param workbook
     * @param sheet
     * @param privatePassportList
     */
    public static void process(String curDate, String curUser, HSSFWorkbook workbook, HSSFSheet sheet, List<PrivatePassport> privatePassportList) {
        int count = 0;
        //第一行 标题样式
        CellStyle sty = workbook.createCellStyle();
        //设置标题字体格式
        Font fon = workbook.createFont();
        //设置字体样式, 设置字体大小
        fon.setFontHeightInPoints((short) 18);
        // 设置字体，是什么类型例如：宋体
        fon.setFontName("宋体");
        //加粗,居中
        fon.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        sty.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        sty.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        sty.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        sty.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        sty.setBorderRight(HSSFCellStyle.BORDER_THIN);
        sty.setBorderTop(HSSFCellStyle.BORDER_THIN);
        // 将字体格式加入到style中
        sty.setFont(fon);
        Row titleRow = sheet.createRow(count);
        sheet.addMergedRegion(new CellRangeAddress(count, (short) count, 0, (short) 6));
        //创建一个单元格
        Cell cell1 = titleRow.createCell(count);
        cell1.setCellStyle(sty);
        cell1.setCellValue("因私护照详细信息");
        count++;



        //表头样式
        CellStyle style1 = workbook.createCellStyle();
        style1.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        style1.setFillForegroundColor(HSSFColor.WHITE.index);
        style1.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style1.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style1.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style1.setBorderTop(HSSFCellStyle.BORDER_THIN);
        //设置标题字体格式
        Font font1 = workbook.createFont();
        //设置字体样式
        font1.setFontHeightInPoints((short) 14);
        font1.setFontName("黑体");
        font1.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style1.setFont(font1);

        //第五行（表头）
        Row row4 = sheet.createRow(count);
        Cell cell5_0 = row4.createCell(0);
        cell5_0.setCellStyle(style1);
        cell5_0.setCellValue(" 姓名 ");

        Cell cell5_1 = row4.createCell(1);
        cell5_1.setCellStyle(style1);
        cell5_1.setCellValue(" 性别 ");

        Cell cell5_2 = row4.createCell(2);
        cell5_2.setCellStyle(style1);
        cell5_2.setCellValue("  工作部门   ");

        Cell cell5_3 = row4.createCell(3);
        cell5_3.setCellStyle(style1);
        cell5_3.setCellValue("  证件编号   ");

        Cell cell5_4 = row4.createCell(4);
        cell5_4.setCellStyle(style1);
        cell5_4.setCellValue("  签发机关   ");

        Cell cell5_5 = row4.createCell(5);
        cell5_5.setCellStyle(style1);
        cell5_5.setCellValue("  签发日期   ");

        Cell cell5_6 = row4.createCell(6);
        cell5_6.setCellStyle(style1);
        cell5_6.setCellValue("  有效期至   ");

        sheet.autoSizeColumn(0);
        sheet.autoSizeColumn(1);
        sheet.autoSizeColumn(2);
        sheet.autoSizeColumn(3);
        sheet.autoSizeColumn(4);
        sheet.autoSizeColumn(5);
        sheet.autoSizeColumn(6);
        count++;


        //样式对象 数据样式
        CellStyle style = workbook.createCellStyle();
        //设置标题字体格式
        Font font = workbook.createFont();
        //设置字体样式, 设置字体大小
        font.setFontHeightInPoints((short) 10);
        // 设置字体，是什么类型例如：宋体
        font.setFontName("黑体");
        //加粗,居中
        font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        //表格边框
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        //自动换行,不能设置 行高
        style.setFont(font);
        style.setWrapText(true);


        for (int i = 0; i < privatePassportList.size(); i ++) {
            PrivatePassport privatePassport = privatePassportList.get(i);
            Row row = sheet.createRow(count + i);
            String userName = null == privatePassport.getDicUser() ? "" : privatePassport.getDicUser().getEmpName();
            String sex = null == privatePassport.getDicUser() ? "" : privatePassport.getDicUser().getSexStr();
            String deptName = null == privatePassport.getDicDept() ? "" : privatePassport.getDicDept().getDeptName();
            String passportCode = null == privatePassport.getPassportCode() ? "" : privatePassport.getPassportCode();
            String signOrg = null == privatePassport.getSignOrg() ? "" : privatePassport.getSignOrg();
            String signDate = null == privatePassport.getSignDate() ? "" : DateUtil.dateToString(privatePassport.getSignDate(), DateUtil.FORMAT_DAY);
            String validDate = null == privatePassport.getValidDate() ? "" : DateUtil.dateToString(privatePassport.getValidDate(), DateUtil.FORMAT_DAY);

            Cell cell_0 = row.createCell(0);
            cell_0.setCellValue(userName);
            cell_0.setCellStyle(style);

            Cell cell_1 = row.createCell(1);
            cell_1.setCellValue(sex);
            cell_1.setCellStyle(style);

            Cell cell_2 = row.createCell(2);
            cell_2.setCellValue(deptName);
            cell_2.setCellStyle(style);

            Cell cell_3 = row.createCell(3);
            cell_3.setCellValue(passportCode);
            cell_3.setCellStyle(style);

            Cell cell_4 = row.createCell(4);
            cell_4.setCellValue(signOrg);
            cell_4.setCellStyle(style);

            Cell cell_5 = row.createCell(5);
            cell_5.setCellValue(signDate);
            cell_5.setCellStyle(style);

            Cell cell_6 = row.createCell(6);
            cell_6.setCellValue(validDate);
            cell_6.setCellStyle(style);

        }

    }

}
