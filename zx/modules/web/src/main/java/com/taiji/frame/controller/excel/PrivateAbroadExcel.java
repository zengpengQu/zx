package com.taiji.frame.controller.excel;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.privateAbroad.PrivateAbroad;
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

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;

/**
 * 因私出国(境)Excel导出
 * Created by yuLei on 2018/8/3.
 * @author
 */
public class PrivateAbroadExcel {

    /**
     * 创建Excel文件
     * @param os
     * @param fileName
     * @param curDate
     * @param curUser
     * @param privateAbroadList
     * @throws IOException
     * @throws IndexOutOfBoundsException
     */
    public static void createExcel(OutputStream os, String fileName, List<PrivateAbroad> privateAbroadList, 
                                   HashMap<String, HashMap<String, String>> map)
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        process(workbook, sheet, privateAbroadList,map);
        workbook.write(os);
    }


    /**
     * 将数据写入Excel中
     * @param curDate
     * @param curUser
     * @param workbook
     * @param sheet
     * @param privateAbroadList
     */
    public static void process(HSSFWorkbook workbook, HSSFSheet sheet, List<PrivateAbroad> privateAbroadList,
                               HashMap<String, HashMap<String, String>> map) {
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
        fon.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
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
        String strTitle;
        if(privateAbroadList==null){
            strTitle = "违规因私出国(境)详细信息";
        }else {
            strTitle = "因私出国(境)详细信息";
        }
        cell1.setCellValue(strTitle);
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
        cell5_0.setCellValue(" 姓名  ");

        Cell cell5_1 = row4.createCell(1);
        cell5_1.setCellStyle(style1);
        cell5_1.setCellValue("  工作部门    ");

        Cell cell5_2 = row4.createCell(2);
        cell5_2.setCellStyle(style1);
        cell5_2.setCellValue("  团组名称    ");

        Cell cell5_3 = row4.createCell(3);
        cell5_3.setCellStyle(style1);
        cell5_3.setCellValue("  组团单位    ");

        Cell cell5_4 = row4.createCell(4);
        cell5_4.setCellStyle(style1);
        cell5_4.setCellValue("出国开始时间");

        Cell cell5_5 = row4.createCell(5);
        cell5_5.setCellStyle(style1);
        cell5_5.setCellValue("出国结束时间");

        Cell cell5_6 = row4.createCell(6);
        cell5_6.setCellStyle(style1);
        cell5_6.setCellValue("     备    注         ");

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

        if(privateAbroadList!=null) {
            for (int i = 0; i < privateAbroadList.size(); i++) {
                PrivateAbroad privateAbroad = privateAbroadList.get(i);
                Row row = sheet.createRow(count + i);
                String userName = null == privateAbroad.getDicUser() ? "" : privateAbroad.getDicUser().getEmpName();
                String deptName = null == privateAbroad.getDicDept() ? "" : privateAbroad.getDicDept().getDeptName();
                String groupName = null == privateAbroad.getGroupName() ? "" : privateAbroad.getGroupName();
                String deptNameForFroup = null == privateAbroad.getDicDeptForGroup() ? "" : privateAbroad.getDicDeptForGroup().getDeptName();
                String startTime = null == privateAbroad.getStartTime() ? "" : DateUtil.dateToString(privateAbroad.getStartTime(), DateUtil.FORMAT_DAY);
                String endTime = null == privateAbroad.getEndTime() ? "" : DateUtil.dateToString(privateAbroad.getEndTime(), DateUtil.FORMAT_DAY);
                String notes = null == privateAbroad.getNotes() ? "" : privateAbroad.getNotes();

                Cell cell_0 = row.createCell(0);
                cell_0.setCellValue(userName);
                cell_0.setCellStyle(style);

                Cell cell_1 = row.createCell(1);
                cell_1.setCellValue(deptName);
                cell_1.setCellStyle(style);

                Cell cell_2 = row.createCell(2);
                cell_2.setCellValue(groupName);
                cell_2.setCellStyle(style);

                Cell cell_3 = row.createCell(3);
                cell_3.setCellValue(deptNameForFroup);
                cell_3.setCellStyle(style);

                Cell cell_4 = row.createCell(4);
                cell_4.setCellValue(startTime);
                cell_4.setCellStyle(style);

                Cell cell_5 = row.createCell(5);
                cell_5.setCellValue(endTime);
                cell_5.setCellStyle(style);

                Cell cell_6 = row.createCell(6);
                cell_6.setCellValue(notes);
                cell_6.setCellStyle(style);


            }
        }else if(map!=null){
            int j=0;
            for (int i=0;i<map.size();i++){
                HashMap<String, String> hashMap = map.get("cellResultMap" + i);
                if(hashMap!=null) {
                    String name = hashMap.get("cellValue" + 0);
                    String dept = hashMap.get("cellValue" + 1);
                    String groupName = hashMap.get("cellValue" + 2);
                    String deptNameForFroup = hashMap.get("cellValue" + 3);

                    String staStr = hashMap.get("cellValue" + 4);
                    String enfStr = hashMap.get("cellValue" + 5);

                    Row row = sheet.createRow(count + j);
                    Cell cell_0 = row.createCell(0);
                    cell_0.setCellValue(name);
                    cell_0.setCellStyle(style);

                    Cell cell_1 = row.createCell(1);
                    cell_1.setCellValue(dept);
                    cell_1.setCellStyle(style);

                    Cell cell_2 = row.createCell(2);
                    cell_2.setCellValue(groupName);
                    cell_2.setCellStyle(style);

                    Cell cell_3 = row.createCell(3);
                    cell_3.setCellValue(deptNameForFroup);
                    cell_3.setCellStyle(style);

                    Cell cell_4 = row.createCell(4);
                    cell_4.setCellValue(staStr);
                    cell_4.setCellStyle(style);

                    Cell cell_5 = row.createCell(5);
                    cell_5.setCellValue(enfStr);
                    cell_5.setCellStyle(style);

                    Cell cell_6 = row.createCell(6);
                    cell_6.setCellValue("");
                    cell_6.setCellStyle(style);
                    j++;
                }
            }
        }
    }


}
