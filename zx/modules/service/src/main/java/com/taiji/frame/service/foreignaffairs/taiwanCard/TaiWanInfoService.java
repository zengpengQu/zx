package com.taiji.frame.service.foreignaffairs.taiwanCard;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanInfo;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.vo.taiwanCard.TaiWanInfoVo;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author qzp
 * @date 2018/08/10
 * 赴台信息服务
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class TaiWanInfoService extends BaseDAO<TaiWanInfo> {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanInfoService.class);


    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<TaiWanInfo> carrier, Map<String,Object> map) {
        StringBuilder hql = new StringBuilder(" from TaiWanInfo tp where 1 = 1");
        if (map.containsKey("groupName")){
            hql.append(" and tp.groupName like :groupName");
        }
        if (map.containsKey("goTimeStr")){
            hql.append(" and to_char(tp.goTime,'yyyy-MM-dd') = :goTimeStr");
        }
        hql.append(" and tp.delFlag = '0'");
        find(carrier,hql.toString(),map);
    }


    public void setData(TaiWanInfo taiWanInfo, TaiWanInfoVo taiWanInfoVo) throws ParseException {

        DicDept dept = new DicDept();
        String groupDepartment = taiWanInfoVo.getGroupDepartment();
        dept.setId(groupDepartment);
        taiWanInfo.setDept(dept);

        String goTimeStr = taiWanInfoVo.getGoTimeStr();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        taiWanInfo.setGoTime(sdf.parse(goTimeStr));

        String endTimeStr = taiWanInfoVo.getEndTimeStr();
        SimpleDateFormat endTime = new SimpleDateFormat("yyyy-MM-dd");
        taiWanInfo.setEndTime(endTime.parse(endTimeStr));

        String groupName = taiWanInfoVo.getGroupName();
        taiWanInfo.setGroupName(groupName);

        taiWanInfo.setTaiDept(taiWanInfoVo.getTaiDept());
        taiWanInfo.setTaiCharge(taiWanInfoVo.getTaiCharge());

        String notes = taiWanInfoVo.getNotes();
        taiWanInfo.setNotes(notes);
        taiWanInfo.setUpdateTime(new Date());
        taiWanInfo.setDelFlag("0");
    }

    @Transactional(rollbackFor = Exception.class)
    public List<TaiWanInfo> findDataExcel(String groupName, String goTimeStr) {
        Map<String, Object> params = new HashMap<String, Object>();
        StringBuffer hql = new StringBuffer(" from TaiWanInfo t where 1 = 1");
        if (StringUtils.isNotEmpty(groupName)){
            hql.append(" and t.groupName like :groupName");
            params.put("groupName","%" + groupName.trim() + "%");
        }
        if (StringUtils.isNotEmpty(goTimeStr)){
            hql.append(" and to_char(t.goTime,'yyyy-MM-dd') = :goTimeStr");
            params.put("goTimeStr",goTimeStr);
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");
        List<TaiWanInfo> list = find(hql.toString(), params);
        return list;
    }

    /**
     * 创建EXCEL
     * @param os
     * @param fileName
     * @param curDate
     * @param curUser
     * @param list
     */
    @Transactional(rollbackFor = Exception.class)
    public void createExcel(OutputStream os, String fileName,
                            String curDate, String curUser,
                            List<TaiWanInfo> list)throws IOException,IndexOutOfBoundsException {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        process(curDate, curUser, workbook, sheet, list);
        workbook.write(os);
    }

    /**
     * 将数据写入Excel中
     * @param curDate
     * @param curUser
     * @param workbook
     * @param sheet
     * @param list
     */
    public void process(String curDate, String curUser, HSSFWorkbook workbook, HSSFSheet sheet, List<TaiWanInfo> list) {
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
        sheet.addMergedRegion(new CellRangeAddress(count, (short) count, 0, (short) 3));
        //创建一个单元格
        Cell cell1 = titleRow.createCell(count);
        cell1.setCellStyle(sty);
        cell1.setCellValue("因公赴台详细信息");
        sheet.autoSizeColumn(count);
        count ++;


        //表头样式
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

        //数据样式

        //第五行（表头）
        Row row4 = sheet.createRow(count);

        Cell cell5_3 = row4.createCell(0);
        cell5_3.setCellStyle(style1);
        cell5_3.setCellValue(" 团组  名称  ");

        Cell cell5_4 = row4.createCell(1);
        cell5_4.setCellStyle(style1);
        cell5_4.setCellValue(" 组团  部门  ");

        Cell cell5_2 = row4.createCell(2);
        cell5_2.setCellStyle(style1);
        cell5_2.setCellValue(" 赴台 时间  ");


        Cell cell5_5 = row4.createCell(3);
        cell5_5.setCellStyle(style1);
        cell5_5.setCellValue("  备   注    ");
        sheet.autoSizeColumn(0);
        sheet.autoSizeColumn(1);
        sheet.autoSizeColumn(2);
        sheet.autoSizeColumn(3);
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
        style3_2.setWrapText(true);

        for (int i = 0; i < list.size(); i ++) {

            TaiWanInfo taiWanInfo = list.get(i);
            Row row = sheet.createRow(count + i);
            String goTime = null == taiWanInfo.getGoTime() ? "" : DateUtil.dateToString(taiWanInfo.getGoTime(), DateUtil.FORMAT_DAY);
            String groupName = null == taiWanInfo.getGroupName() ? "" : taiWanInfo.getGroupName();
            String groupDeptName = null == taiWanInfo.getDept().getDeptName() ? "" : taiWanInfo.getDept().getDeptName();
            String notes = null == taiWanInfo.getNotes() ? "" : taiWanInfo.getNotes();


            Cell cell_2 = row.createCell(0);
            cell_2.setCellValue(goTime);
            cell_2.setCellStyle(style3_2);

            Cell cell_3 = row.createCell(1);
            cell_3.setCellValue(groupName);
            cell_3.setCellStyle(style3_2);

            Cell cell_4 = row.createCell(2);
            cell_4.setCellValue(groupDeptName);
            cell_4.setCellStyle(style3_2);

            Cell cell_5 = row.createCell(3);
            cell_5.setCellValue(notes);
            cell_5.setCellStyle(style3_2);
        }
    }
}
