package com.taiji.frame.controller.pubinfo.contacts;

import com.taiji.frame.model.entity.pubinfo.contacts.CmmList;
import com.taiji.frame.model.entity.pubinfo.contacts.CmmListt;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

/**
 * 通讯录Excel导出
 * @author sy
 */

public class AddressTeamExcel {

    /**
     * 创建Excel文件
     * @param os
     * @param fileName
     * @throws IOException
     * @throws IndexOutOfBoundsException
     */
    public static void createExce3(OutputStream os, String fileName, List<CmmListt> deptList)
            throws IOException,IndexOutOfBoundsException{
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        process3(workbook, sheet,deptList);
        workbook.write(os);
    }

    /**
     * 将数据写入Excel中
     * @param deptList 通讯录数据
     */

    public static void process3(HSSFWorkbook workbook, HSSFSheet sheet,List<CmmListt> deptList) {
        int count = 0;
        sheet.setDefaultColumnWidth(20);
        //标题样式
        CellStyle style3 = workbook.createCellStyle();
        //设置标题字体格式
        Font font3 = workbook.createFont();
        //设置字体样式
        font3.setFontHeightInPoints((short) 18);
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
            CellRangeAddress cellRangeAddress0_0 = new CellRangeAddress(count, (short) count, 0, (short) 7);
            sheet.addMergedRegion(cellRangeAddress0_0);
            Cell cell1 = titleRow.createCell(0);
            cell1.setCellStyle(style3);
            cell1.setCellValue("机关通讯录信息");
            sheet.autoSizeColumn(count);
            count ++;

        if(deptList!=null) {
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

            //第二行（表头）
            Row row2 = sheet.createRow(count);
            CellRangeAddress cellRangeAddress_er_0 = new CellRangeAddress(count, (short) (count+1), 0, (short) 0);
            sheet.addMergedRegion(cellRangeAddress_er_0);
            Cell cell2_er_0 = row2.createCell(0);
            cell2_er_0.setCellStyle(style31);
            cell2_er_0.setCellValue("组名");

            CellRangeAddress cellRangeAddress0 = new CellRangeAddress(count, (short) (count+1), 1, (short) 1);
            sheet.addMergedRegion(cellRangeAddress0);
            Cell cell2_0 = row2.createCell(1);
            cell2_0.setCellStyle(style31);
            cell2_0.setCellValue("部门");

            Cell cell2_1 = row2.createCell(2);
            CellRangeAddress cellRangeAddress1 = new CellRangeAddress(count, (short) (count+1), 2, (short) 2);
            sheet.addMergedRegion(cellRangeAddress1);
            cell2_1.setCellStyle(style31);
            cell2_1.setCellValue("姓名");

            Cell cell2_2 = row2.createCell(3);
            CellRangeAddress cellRangeAddress2 = new CellRangeAddress(count, (short) (count+1), 3, (short) 3);
            sheet.addMergedRegion(cellRangeAddress2);
            cell2_2.setCellStyle(style31);
            cell2_2.setCellValue("职务");

            Cell cell2_3 = row2.createCell(4);
            CellRangeAddress cellRangeAddress3 = new CellRangeAddress(count, (short) count, 4, (short) 6);
            sheet.addMergedRegion(cellRangeAddress3);
            cell2_3.setCellStyle(style31);
            cell2_3.setCellValue("电话");

            Cell cell2_4 = row2.createCell(7);
            CellRangeAddress cellRangeAddress4 = new CellRangeAddress(count, (short) (count+1), 7, (short) 7);
            sheet.addMergedRegion(cellRangeAddress4);
            cell2_4.setCellStyle(style31);
            cell2_4.setCellValue("办公室");
            sheet.autoSizeColumn(count);

            count++;
            //第三行（表头）
            Row row3 = sheet.createRow(count);
            Cell cell3_3 = row3.createCell(4);
            cell3_3.setCellStyle(style31);
            cell3_3.setCellValue("办公室电话");
            Cell cell3_4 = row3.createCell(5);
            cell3_4.setCellStyle(style31);
            cell3_4.setCellValue("移动电话");
            Cell cell3_5 = row3.createCell(6);
            cell3_5.setCellStyle(style31);
            cell3_5.setCellValue("司机电话");
            sheet.autoSizeColumn(count);
            count++;

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
            //kk为合并行数，0不合并，kkkk判断部门是否相等时的标记点，下次从这里开始
            for (int i = 0; i < deptList.size(); i ++) {
                CmmListt cmmListt = deptList.get(i);
                List<CmmList> cmmLists = cmmListt.getCmmListUsers();
                Row row = sheet.createRow(count);
                String deptName = null == cmmListt.getDicDept().getDeptName() ? "" : cmmListt.getDicDept().getDeptName();
                String teamName =  cmmListt.getAddressTeam().getTeamName();
                //第一列
                Cell cell_0_0 = row.createCell(0);
                cell_0_0.setCellStyle(style3_2);
                cell_0_0.setCellValue(teamName);
                //第一列
                Cell cell_0 = row.createCell(1);
                cell_0.setCellStyle(style3_2);
                cell_0.setCellValue(deptName);

                Cell cell_1 = row.createCell(2);
                Cell cell_2 = row.createCell(3);
                Cell cell_3 = row.createCell(4);
                Cell cell_4 = row.createCell(5);
                Cell cell_5 = row.createCell(6);
                Cell cell_6 = row.createCell(7);

                String location = null == cmmListt.getLocation() || "".equals(cmmListt.getLocation())? "无" : cmmListt.getLocation();
                String jobTelDept = null == cmmListt.getJobTel() || "".equals(cmmListt.getJobTel())? "无" : cmmListt.getJobTel();
                if(cmmLists.size()>0) {
                    int j;
                    for (j = 0; j < cmmLists.size(); j++) {
                        CmmList cmmList = cmmLists.get(j);
                        String name = null == cmmList.getName() ? "" : cmmList.getName();
                        String proTypeId = null == cmmList.getProTypeId() ? "无" : cmmList.getProTypeId();
                        String jobTel = null == cmmList.getJobTel() || "".equals(cmmList.getJobTel()) ? "无" : cmmList.getJobTel();
                        String mobile = null == cmmList.getMobile() || "".equals(cmmList.getMobile()) ? "无" : cmmList.getMobile();
                        String driMobile = null == cmmList.getDriMobile() || "".equals(cmmList.getDriMobile()) ? "无" : cmmList.getDriMobile();
                        if (j == 0) {
                            //姓名
                            cell_1.setCellStyle(style3_2);
                            cell_1.setCellValue(name);
                            //职务
                            cell_2.setCellStyle(style3_2);
                            cell_2.setCellValue(proTypeId);
                            //办公室电话
                            cell_3.setCellStyle(style3_2);
                            cell_3.setCellValue(jobTel);
                            //移动电话
                            cell_4.setCellStyle(style3_2);
                            cell_4.setCellValue(mobile);
                            //司机电话
                            cell_5.setCellStyle(style3_2);
                            cell_5.setCellValue(driMobile);

                        } else {
                            Row row1 = sheet.createRow(count + j);
                            Cell cell_0_0_0 = row1.createCell(0);
                            cell_0_0_0.setCellStyle(style3_2);
                            cell_0_0_0.setCellValue(teamName);

                            Cell cell_0_1 = row1.createCell(1);
                            cell_0_1.setCellStyle(style3_2);
                            cell_0_1.setCellValue(deptName);
                            //姓名
                            Cell cell_1_1 = row1.createCell(2);
                            cell_1_1.setCellStyle(style3_2);
                            cell_1_1.setCellValue(name);
                            //职务
                            Cell cell_2_2 = row1.createCell(3);
                            cell_2_2.setCellStyle(style3_2);
                            cell_2_2.setCellValue(proTypeId);
                            //办公室电话
                            Cell cell_3_3 = row1.createCell(4);
                            cell_3_3.setCellStyle(style3_2);
                            cell_3_3.setCellValue(jobTel);
                            //移动电话
                            Cell cell_4_4 = row1.createCell(5);
                            cell_4_4.setCellStyle(style3_2);
                            cell_4_4.setCellValue(mobile);
                            //司机电话
                            Cell cell_5_5 = row1.createCell(6);
                            cell_5_5.setCellStyle(style3_2);
                            cell_5_5.setCellValue(driMobile);
                        }
                    }
                    //合并最后一列
                    CellRangeAddress address = new CellRangeAddress(count, (short) (count + j-1), 7, (short) 7);
                    CellRangeAddress address1 = new CellRangeAddress(count, (short) (count + j-1), 4, (short) 4);
                    sheet.addMergedRegion(address1);
                    sheet.addMergedRegion(address);
                    cell_6.setCellStyle(style3_2);
                    cell_6.setCellValue(location);
                    setRegionBorder(1,address,sheet,workbook);
                    setRegionBorder(1,address1,sheet,workbook);
                    count += j;
                }else {
                    cell_1.setCellStyle(style3_2);
                    cell_1.setCellValue("");
                    //职务
                    cell_2.setCellStyle(style3_2);
                    cell_2.setCellValue("");
                    //办公室电话
                    cell_3.setCellStyle(style3_2);
                    cell_3.setCellValue(jobTelDept);
                    //移动电话
                    cell_4.setCellStyle(style3_2);
                    cell_4.setCellValue("");
                    //司机电话
                    cell_5.setCellStyle(style3_2);
                    cell_5.setCellValue("");

                    cell_6.setCellStyle(style3_2);
                    cell_6.setCellValue(location);
                    count++;
                    }

                }

                //合并第一列，根据值相同进行合并
            tableRowSpan(sheet,3,0,workbook,0);
            //合并第二列，根据值相同进行合并
            tableRowSpan(sheet,3,1,workbook,1);

            setRegionBorder(1,cellRangeAddress_er_0,sheet,workbook);
            setRegionBorder(1,cellRangeAddress0_0,sheet,workbook);
            setRegionBorder(1,cellRangeAddress1,sheet,workbook);
            setRegionBorder(1,cellRangeAddress2,sheet,workbook);
            setRegionBorder(1,cellRangeAddress3,sheet,workbook);
            setRegionBorder(1,cellRangeAddress4,sheet,workbook);
        }
    }

    /**
     * POI 表格合并根据值相同进行合并
     * @param t:开始合并行数
     * @param cell:需要合并的列
     * @param cellValue:需要比较的值在哪一列
     */
    public static void tableRowSpan( HSSFSheet sheet,int t,int cell,Workbook workbook,int cellValue){
        String deptNameCell = sheet.getRow(3).getCell(cellValue).getStringCellValue();
        int r = 1;
        for(int i=t+1;i<sheet.getPhysicalNumberOfRows();i++){
            HSSFRow row = sheet.getRow(i);
            String deptNameCellNow =row.getCell(cellValue).getStringCellValue();
            if(deptNameCell.equals(deptNameCellNow)){
                r++;
            }else {
                CellRangeAddress address1 = new CellRangeAddress(t, (short) (t + r - 1), cell, (short) cell);
                sheet.addMergedRegion(address1);
                setRegionBorder(1,address1,sheet,workbook);
                deptNameCell = deptNameCellNow;
                t=t+r;
                r=1;
            }
            if(i==(sheet.getPhysicalNumberOfRows()-1)){
                CellRangeAddress address1 = new CellRangeAddress(t, (short) (t + r - 1), cell, (short) cell);
                sheet.addMergedRegion(address1);
                setRegionBorder(1,address1,sheet,workbook);
            }
        }
    }


    public static void setRegionBorder(int border,CellRangeAddress address,HSSFSheet sheet,Workbook wb){
        RegionUtil.setBorderBottom(border,address,sheet,wb);
        RegionUtil.setBorderLeft(border,address,sheet,wb);
        RegionUtil.setBorderRight(border,address,sheet,wb);
        RegionUtil.setBorderTop(border,address,sheet,wb);
    }

}
