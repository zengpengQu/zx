package com.taiji.frame.service.foreignaffairs.statistics;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadGroup;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.util.BaseDAO;
import net.sf.json.JSONObject;
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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author yx
 * @date 2018/8/23
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class StatisticsService extends BaseDAO<AbroadInfo> {

    /**
     * 查询副部级及以上因公出国人员
     *
     * @param adminLevel
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadGroup> findAboveViceMinister(String adminLevel, String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>(1);
        StringBuilder hql = new StringBuilder();
        hql.append(" from AbroadGroup t where 1=1 ");
        if (StringUtils.isNotEmpty(adminLevel)) {
            hql.append(" and t.dicUser.dicParam.id <= :adminLevel");
            params.put("adminLevel", adminLevel);
        }

        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(t.abroadInfo.startDate, 'yyyy') = to_date(:startDate, 'YYYY')");
            params.put("startDate", startDate);
        }

        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and t.abroadInfo.endDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }

        hql.append(" and t.delFlag = '0' order by t.updateTime desc, t.dicUser.dicParam.id asc ");
        List<AbroadGroup> abroadGroupList = find(hql.toString(), params);
        return abroadGroupList;
    }

    /**
     * 中央和国家机关各部门因公出国（境）情况汇总表
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public JSONObject findBusinessAbroad(String startDate, String endDate) {

        Date thisYear = DateUtil.stringToDate(startDate, DateUtil.FORMAT_YYYY);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
        String years = dateFormat.format(thisYear);
        int yearValue = Integer.parseInt(years);
        String lastYear = (yearValue - 1) + "-1-1";

        JSONObject jsonObject = new JSONObject();

        // 正部级及以上去年出国 批次和人数
        List<Long> aboveMinisterBatchCount1 = businessAbroadGroupCount("0111", lastYear, startDate);
        List<Long> aboveMinisterPeopleCount1 = businessAbroadPeopleCount("0111", lastYear, startDate);

        // 正部级及以上今年出国 批次和人数
        List<Long> aboveMinisterBatchCount2 = businessAbroadGroupCount("0111", startDate, endDate);
        List<Long> aboveMinisterPeopleCount2 = businessAbroadPeopleCount("0111", startDate, endDate);

        jsonObject.put("aboveMinisterBatchCount1", aboveMinisterBatchCount1.get(0));
        jsonObject.put("aboveMinisterBatchCount2", aboveMinisterBatchCount2.get(0));
        jsonObject.put("aboveMinisterPeopleCount1", aboveMinisterPeopleCount1.get(0));
        jsonObject.put("aboveMinisterPeopleCount2", aboveMinisterPeopleCount2.get(0));


        // 副部级及以上去年出国 批次和人数
        List<Long> viceMinisterBatchCount1 = businessAbroadGroupCount("0112", lastYear, startDate);
        List<Long> viceMinisterPeopleCount1 = businessAbroadPeopleCount("0112", lastYear, startDate);

        // 副部级及以上今年出国 批次和人数
        List<Long> viceMinisterBatchCount2 = businessAbroadGroupCount("0112", startDate, endDate);
        List<Long> viceMinisterPeopleCount2 = businessAbroadPeopleCount("0112", startDate, endDate);

        // 副部级及以上出国数减去正部级及以上计数，得到副部级出国数
        jsonObject.put("viceMinisterBatchCount1", viceMinisterBatchCount1.get(0) - aboveMinisterBatchCount1.get(0));
        jsonObject.put("viceMinisterBatchCount2", viceMinisterBatchCount2.get(0) - aboveMinisterBatchCount2.get(0));
        jsonObject.put("viceMinisterPeopleCount1", viceMinisterPeopleCount1.get(0) - aboveMinisterPeopleCount1.get(0));
        jsonObject.put("viceMinisterPeopleCount2", viceMinisterPeopleCount2.get(0) - aboveMinisterPeopleCount2.get(0));


        // 厅局级及以下去年出国 批次和人数
        List<Long> belowDepartmentsBatchCount1 = businessAbroadGroupCount("0199", lastYear, startDate);
        List<Long> belowDepartmentsPeopleCount1 = businessAbroadPeopleCount("0199", lastYear, startDate);

        // 厅局级及以下今年出国 批次和人数
        List<Long> belowDepartmentsBatchCount2 = businessAbroadGroupCount("0199", startDate, endDate);
        List<Long> belowDepartmentsPeopleCount2 = businessAbroadPeopleCount("0199", startDate, endDate);

        jsonObject.put("belowDepartmentsBatchCount1", belowDepartmentsBatchCount1.get(0) - viceMinisterBatchCount1.get(0));
        jsonObject.put("belowDepartmentsBatchCount2", belowDepartmentsBatchCount2.get(0) - viceMinisterBatchCount2.get(0));
        jsonObject.put("belowDepartmentsPeopleCount1", belowDepartmentsPeopleCount1.get(0) - viceMinisterPeopleCount1.get(0));
        jsonObject.put("belowDepartmentsPeopleCount2", belowDepartmentsPeopleCount2.get(0) - viceMinisterPeopleCount2.get(0));

        return jsonObject;
    }


    /**
     * 因公出国批次统计
     *
     * @param adminLevel
     * @param startDate
     * @param endDate
     * @return
     */
    private List<Long> businessAbroadGroupCount(String adminLevel, String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>(3);

        StringBuilder hql = new StringBuilder();

        hql.append(" select count(distinct ai) from AbroadGroup ag inner join ag.abroadInfo ai where ");

        if (StringUtils.isNotEmpty(adminLevel)) {
            hql.append(" ag.dicUser.dicParam.id <= :adminLevel");
            params.put("adminLevel", adminLevel);
        }
        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }
        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and to_date(ai.endDate, 'yyyy-MM-dd') < to_date(:endDate, 'yyyy-MM-dd')");
            params.put("endDate", endDate);
        }

        hql.append(" and ai.id = ag.abroadInfo.id");
        hql.append(" and ai.batchNumber is not null");
        hql.append(" and ai.delFlag = '0' and ag.delFlag = '0'");

        return find(hql.toString(), params);

    }


    /**
     * 因公出国人数统计
     *
     * @param adminLevel
     * @param startDate
     * @param endDate
     * @return
     */
    private List<Long> businessAbroadPeopleCount(String adminLevel, String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>(3);

        StringBuilder hql = new StringBuilder();

        hql.append(" select count(distinct ag) from AbroadGroup ag, AbroadInfo ai where 1=1 ");
        if (StringUtils.isNotEmpty(adminLevel)) {
            hql.append(" and ag.dicUser.dicParam.id <= :adminLevel");
            params.put("adminLevel", adminLevel);
        }
        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }
        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and to_date(ai.endDate, 'yyyy-MM-dd') < to_date(:endDate, 'yyyy-MM-dd')");
            params.put("endDate", endDate);
        }

        hql.append(" and ag.abroadInfo.id = ai.id");
        hql.append(" and ai.delFlag = '0' and ag.delFlag = '0'");

        return find(hql.toString(), params);
    }


    /**
     * 201X年出访情况详表
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadGroup> findAbroadDetails(String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>(2);

        StringBuilder hql = new StringBuilder();
        hql.append("select ag from AbroadGroup ag, AbroadInfo ai where 1=1");

        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }

        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and ai.endDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }

        hql.append(" and ag.abroadInfo.id = ai.id");
        hql.append(" and ag.delFlag = '0' and ai.delFlag = '0'");

        // 按团组创建时间和团组 ID 排序，使得同一团组的人员连续排列
        hql.append(" order by ai.createTime, ai.id ");

        List<AbroadGroup> abroadGroupList = find(hql.toString(), params);

        return abroadGroupList;
    }


    /**
     * 副主席率团出访情况表（政协组团）
     *
     * @param adminLevel
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadGroup> findZxViceChairman(String adminLevel, String startDate, String endDate) {

        // 政协组团，行政级别为副主席
        return findByTypeAndLevel("0", adminLevel, startDate, endDate);
    }


    /**
     * 全国政协办公厅领导出访情况
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadGroup> findZxLeaders(String startDate, String endDate) {

        Map<String, Object> params = new HashMap<>(2);

        StringBuilder hql = new StringBuilder();
        hql.append("select ag from AbroadGroup ag inner join ag.abroadInfo ai where 1=1");
        hql.append(" and (ag.dicUser.dicDept.id = '0125'");
        hql.append(" or ag.dicUser.dicDept.id = '0126')");

        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }

        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and ai.endDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }

        hql.append(" and ag.abroadInfo.id = ai.id");
        hql.append(" and ag.delFlag = '0' and ai.delFlag = '0'");
        hql.append(" order by ai.createTime, ai.id ");

        List<AbroadGroup> abroadGroupList = find(hql.toString(), params);

        return abroadGroupList;

    }


    /**
     * 全国政协专门委员会负责人出访情况
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadGroup> findCommitteeLeaders(String startDate, String endDate) {

        Map<String, Object> params = new HashMap<>(2);

        StringBuilder hql = new StringBuilder();
        hql.append("select ag from AbroadGroup ag join ag.dicUser u where");
        hql.append(" '012905' <= u.dicDept.id and u.dicDept.id <= '01290D'");
        // 职务包含主任，但不包含 主任科员、副主任科员 的人
        hql.append(" and u.mainDuty like :director and u.mainDuty not like :principalStaff");
        params.put("director", "%" + "主任" + "%");
        params.put("principalStaff", "%" + "主任科员");

        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ag.abroadInfo.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }

        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and ag.abroadInfo.startDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }

        hql.append(" and ag.delFlag = '0'");
        hql.append(" order by u.dicDept.id");

        List<AbroadGroup> abroadGroupList = find(hql.toString(), params);

        return abroadGroupList;

    }

    /**
     * 根据团组ID 查找团组成员
     *
     * @param abroadInfoId
     * @return
     */
    public List<AbroadGroup> findMembersByInfoId(String abroadInfoId) {
        Map<String, Object> params = new HashMap<>(2);

        StringBuilder hql = new StringBuilder();
        hql.append("select ag from AbroadGroup ag where 1=1");
        if (StringUtils.isNotEmpty(abroadInfoId)) {
            hql.append(" and ag.abroadInfo.id = :abroadInfoId");
            params.put("abroadInfoId", abroadInfoId);
        }

        hql.append(" and ag.delFlag = '0'");
        hql.append(" order by ag.createTime, ag.id ");

        List<AbroadGroup> abroadGroupList = find(hql.toString(), params);

        return abroadGroupList;
    }


    /**
     * 经社理事会出访团组统计
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadInfo> findEconomySocietyCouncil(String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>(2);

        StringBuilder hql = new StringBuilder();
        hql.append("from AbroadInfo ai where 1=1");
        // 团组信息 “主办单位”为“全国政协中国经济社会理事会”
        hql.append(" and ai.org.id = '01290W' ");

        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }

        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and ai.endDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }

        hql.append(" and ai.delFlag = '0'");
        hql.append(" order by ai.createTime, ai.id ");

        List<AbroadInfo> abroadInfoList = find(hql.toString(), params);

        return abroadInfoList;
    }


    /**
     * 全国政协专门委员会出访情况
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadInfo> findNineCommittee(String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>(2);

        StringBuilder hql = new StringBuilder();
        // 团组信息 “主办单位”为 九个专门委员会的团组
        hql.append("from AbroadInfo ai where 1=1");
        hql.append(" and ai.org.deptLevel = 2");
        hql.append(" and '012905' <= ai.org.id and ai.org.id <= '01290D'");

        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }

        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and ai.endDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }

        hql.append(" and ai.delFlag = '0'");
        hql.append(" order by ai.createTime, ai.id ");

        List<AbroadInfo> abroadInfoList = find(hql.toString(), params);

        return abroadInfoList;
    }


    /**
     * 副主席率团出访情况表（外单位组团）
     *
     * @param adminLevel
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadInfo> findOuterViceChairman(String adminLevel, String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>(2);

        StringBuilder hql = new StringBuilder();

        hql.append("from AbroadInfo ai where 1=1");
        if (StringUtils.isNotEmpty(adminLevel)) {
            hql.append(" and ai.groupLeader.dicParam.id = :adminLevel");
            params.put("adminLevel", adminLevel);
        }

        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }

        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and ai.endDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }
        hql.append(" and ai.abroadType = 1");
        hql.append(" and ai.delFlag = '0'");
        hql.append(" order by ai.createTime, ai.id ");

        // 外单位组团，行政级别为副主席
        return find(hql.toString(), params);
    }


    /**
     * “中宗和”出访情况一览表
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadInfo> findReligionPeace(String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>(2);

        StringBuilder hql = new StringBuilder();

        hql.append("from AbroadInfo ai where 1=1");
        hql.append(" and ai.org.deptLevel = 2");
        hql.append(" and '01290Y' = ai.org.id");

        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }

        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and ai.endDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }

        hql.append(" and ai.delFlag = '0'");
        hql.append(" order by ai.createTime, ai.id ");

        List<AbroadInfo> abroadInfoList = find(hql.toString(), params);

        return abroadInfoList;
    }


    /**
     * 政协人员参加外单位组团
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public List<AbroadGroup> findOuterZx(String startDate, String endDate) {

        // 外单位组团，去除行政级别为主席、副主席

        List<AbroadGroup> all = findByTypeAndLevel("1", "", startDate, endDate);
        List<AbroadGroup> chairman = findByTypeAndLevel("1", "0101", startDate, endDate);
        List<AbroadGroup> viceChairman = findByTypeAndLevel("1", "0102", startDate, endDate);

        all.removeAll(chairman);
        all.removeAll(viceChairman);

        return all;
    }


    public List<AbroadInfo> findInfoByLevel(String lowLevel, String highLevel, String startDate, String endDate) {
        Map<String, Object> params = new HashMap<>(4);
        StringBuilder hql = new StringBuilder();
        hql.append("select distinct ai from AbroadGroup ag inner join ag.abroadInfo ai where 1=1");

        // 查询行政级别在 adminLevel 以上的，如 0112 - 省部级副职
        if (StringUtils.isNotEmpty(lowLevel)) {
            hql.append(" and ag.dicUser.dicParam.id <= :lowLevel");
            params.put("lowLevel", lowLevel);
        }
        // 查询行政级别在 adminLevel 以下的，如 0111 - 省部级正职
        if (StringUtils.isNotEmpty(highLevel)) {
            hql.append(" and ag.dicUser.dicParam.id >= :highLevel");
            params.put("highLevel", highLevel);
        }
        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }
        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and ai.endDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }

        hql.append(" and ag.abroadInfo.id = ai.id");
        hql.append(" and ag.delFlag = '0' and ai.delFlag = '0'");
        hql.append(" order by ai.createTime, ai.id ");

        List<AbroadInfo> abroadInfoList = find(hql.toString(), params);

        return abroadInfoList;
    }


    /**
     * 根据出访类型和行政级别查找人员出访
     *
     * @param abroadType
     * @param adminLevel
     * @param startDate
     * @param endDate
     * @return
     */
    private List<AbroadGroup> findByTypeAndLevel(String abroadType, String adminLevel, String startDate, String endDate) {

        Map<String, Object> params = new HashMap<>(4);

        StringBuilder hql = new StringBuilder();
        hql.append("select ag from AbroadGroup ag inner join ag.abroadInfo ai where 1=1");

        if (StringUtils.isNotEmpty(abroadType)) {
            hql.append(" and ai.abroadType = :abroadType");
            params.put("abroadType", abroadType);
        }

        if (StringUtils.isNotEmpty(adminLevel)) {
            hql.append(" and ag.dicUser.dicParam.id = :adminLevel");
            params.put("adminLevel", adminLevel);
        }
        if (StringUtils.isNotEmpty(startDate)) {
            hql.append(" and to_date(ai.startDate, 'yyyy') = to_date(:startDate, 'yyyy')");
            params.put("startDate", startDate);
        }
        if (StringUtils.isNotEmpty(endDate)) {
            hql.append(" and ai.endDate <= to_date(:endDate, 'YYYY-MM-DD')");
            params.put("endDate", endDate);
        }

        hql.append(" and ag.abroadInfo.id = ai.id");
        hql.append(" and ag.delFlag = '0' and ai.delFlag = '0'");
        hql.append(" order by ai.createTime, ai.id ");

        List<AbroadGroup> abroadGroupList = find(hql.toString(), params);

        return abroadGroupList;

    }


    /**
     * 创建 Excel
     *
     * @param list 统计结果
     */
    @Transactional(rollbackFor = Exception.class)
    public void createExcel(OutputStream os, String fileName, String title, List<String> headerList,
                            List<JSONObject> list) throws IOException, IndexOutOfBoundsException {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        process(workbook, sheet, title, headerList, list);
        workbook.write(os);
    }

    /**
     * 写入 Excel
     */
    public void process(HSSFWorkbook workbook, HSSFSheet sheet, String title,
                        List<String> headerList, List<JSONObject> list) {

        int column = 0;
        int row = 0;
        if (null != headerList && headerList.size() > 0) {
            column = headerList.size();
            sheet.setDefaultColumnWidth(15);
        }

        // 设置标题字体、样式

        Font fon = workbook.createFont();
        fon.setFontHeightInPoints((short) 14);
        fon.setFontName("宋体");
        // 加粗,居中
        fon.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);

        // 第一行 标题样式
        CellStyle titleStyle = workbook.createCellStyle();
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

        // 将字体格式加入到style中
        titleStyle.setFont(fon);
        Row titleRow = sheet.createRow(row);
        titleRow.setHeightInPoints(45F);
        sheet.addMergedRegion(new CellRangeAddress(row, row, 0, column - 1));

        // 标题单元格
        Cell titleCell = titleRow.createCell(row);
        titleCell.setCellStyle(titleStyle);
        titleCell.setCellValue(title);
        row++;


        // 以下为表头样式设置
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(HSSFColor.WHITE.index);
        headerStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        headerStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        headerStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

        headerStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        headerStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        headerStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        headerStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        //设置标题字体格式
        Font headerFont = workbook.createFont();
        //设置字体样式
        headerFont.setFontHeightInPoints((short) 11);
        headerFont.setFontName("宋体");
        headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        headerStyle.setFont(headerFont);


        Row headerRow = sheet.createRow(row);
        headerRow.setHeightInPoints((short) 30);
        // 表头
        for (int i = 0; i < headerList.size(); i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellStyle(headerStyle);
            cell.setCellValue(headerList.get(i));
        }
        row++;


        // 单元格字体、样式
        // 样式对象 数据样式
        CellStyle cellStyle = workbook.createCellStyle();
        // 设置标题字体格式
        Font font = workbook.createFont();
        // 设置字体大小
        font.setFontHeightInPoints((short) 11);
        // 设置字体为宋体
        font.setFontName("宋体");
        // 加粗,居中
        font.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        cellStyle.setFont(font);
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        // 表格边框
        cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
        // 自动换行
        cellStyle.setWrapText(true);

        for (int i = 0; i < list.size(); i++) {
            Row contentRow = sheet.createRow(row);

            if (row == 1) {
                sheet.autoSizeColumn((short) i);
            }

            int contentColumn = 0;

            // 序号列
            String rowNum = String.valueOf(i + 1);
            Cell serialCell = contentRow.createCell(contentColumn);
            serialCell.setCellStyle(cellStyle);
            serialCell.setCellValue(rowNum);

            JSONObject jsonObject = list.get(i);
            Iterator iterator = jsonObject.keys();

            while (iterator.hasNext()) {
                contentColumn++;
                Cell cell = contentRow.createCell(contentColumn);
                cell.setCellStyle(cellStyle);
                String value = String.valueOf(jsonObject.get(iterator.next()));
                cell.setCellValue(value);
            }
            row++;
        }


    }


    /**
     * 创建中央和国家机关各部门因公出国（境）情况汇总表 Excel
     *
     * @param os
     * @param fileName
     * @param title
     * @param jsonObjectList
     */
    public void createBAExcel(OutputStream os, String fileName, String year, String title, List<JSONObject> jsonObjectList)
            throws IOException {
        // 表格数据
        JSONObject jsonObject = jsonObjectList.get(0);

        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);
        int column = 7;
        int row = 0;

        // 设置标题字体、样式
        Font fon = workbook.createFont();
        fon.setFontHeightInPoints((short) 18);
        fon.setFontName("宋体");
        // 加粗,居中
        fon.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);

        // 第一行 标题样式
        CellStyle titleStyle = workbook.createCellStyle();
        titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        titleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

        // 将字体格式加入到style中
        titleStyle.setFont(fon);
        Row titleRow = sheet.createRow(row);
        titleRow.setHeightInPoints(45F);
        sheet.addMergedRegion(new CellRangeAddress(row, row, 0, column - 1));

        // 标题单元格
        Cell titleCell = titleRow.createCell(row);
        titleCell.setCellStyle(titleStyle);
        titleCell.setCellValue(title);
        row++;


        // 表头第一行
        Font headerFont = workbook.createFont();
        headerFont.setFontHeightInPoints((short) 14);
        headerFont.setFontName("黑体");
        // 加粗,居中
        headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);

        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        headerStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        headerStyle.setFont(headerFont);
        // 边框
        headerStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        headerStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        headerStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        headerStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);


        Row headerRow = sheet.createRow(row);
        headerRow.setHeightInPoints((short) 42);
        // 项目
        sheet.setColumnWidth(0, 20 * 256);
        sheet.addMergedRegion(new CellRangeAddress(1, 2, 0, 0));
        Cell cell1_0 = headerRow.createCell(0);
        cell1_0.setCellStyle(headerStyle);
        cell1_0.setCellValue("项目");

        // 总批次
        sheet.addMergedRegion(new CellRangeAddress(row, row, 1, 2));
        Cell cell1_1 = headerRow.createCell(1);
        cell1_1.setCellStyle(headerStyle);
        cell1_1.setCellValue("总批次");

        // 空格
        Cell cell1_2 = headerRow.createCell(2);
        cell1_2.setCellStyle(headerStyle);

        // 总人次
        sheet.addMergedRegion(new CellRangeAddress(row, row, 3, 4));
        Cell cell1_3 = headerRow.createCell(3);
        cell1_3.setCellStyle(headerStyle);
        cell1_3.setCellValue("总人次");

        // 空格
        Cell cell1_4 = headerRow.createCell(4);
        cell1_4.setCellStyle(headerStyle);

        // 执行总批次占年度计划比率
        sheet.addMergedRegion(new CellRangeAddress(row, row, 5, 6));
        Cell cell1_5 = headerRow.createCell(5);
        headerStyle.setWrapText(true);
        cell1_5.setCellStyle(headerStyle);
        cell1_5.setCellValue("执行总批次占年度计划比率");

        // 空格
        Cell cell1_6 = headerRow.createCell(6);
        cell1_6.setCellStyle(headerStyle);

        row++;

        // 表头第二行
        Row row2 = sheet.createRow(row);
        row2.setHeightInPoints((short) 35);

        // 年份
        for (int i = 1; i < column; i++) {
            String lastYear = String.valueOf(Integer.parseInt(year) - 1);
            Cell cell2_1 = row2.createCell(i);
            sheet.setColumnWidth(i, 12*256);
            cell2_1.setCellStyle(headerStyle);
            cell2_1.setCellValue(lastYear + "年");

            Cell cell2_2 = row2.createCell(++i);
            sheet.setColumnWidth(i, 12*256);
            cell2_2.setCellStyle(headerStyle);
            cell2_2.setCellValue(year + "年");
        }
        row++;



        // 设置表格内容标题字体
        Font contentFont = workbook.createFont();
        contentFont.setFontHeightInPoints((short) 14);
        contentFont.setFontName("仿宋");
        contentFont.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);

        // 表格内容样式
        CellStyle contentStyle = workbook.createCellStyle();
        contentStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        contentStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        contentStyle.setWrapText(true);
        // 将字体格式加入到style中
        contentStyle.setFont(contentFont);

        contentStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        contentStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        contentStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
        contentStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);

        // 正部级及以上
        Row row3 = sheet.createRow(row);
        row3.setHeightInPoints(175F);

        Cell cell3_0 = row3.createCell(0);
        cell3_0.setCellStyle(contentStyle);
        cell3_0.setCellValue("正部级及以上领导干部出国（境）");

        Cell cell3_1 = row3.createCell(1);
        cell3_1.setCellStyle(contentStyle);
        cell3_1.setCellValue(String.valueOf(jsonObject.get("aboveMinisterBatchCount1")));

        Cell cell3_2 = row3.createCell(2);
        cell3_2.setCellStyle(contentStyle);
        cell3_2.setCellValue(String.valueOf(jsonObject.get("aboveMinisterBatchCount2")));

        Cell cell3_3 = row3.createCell(3);
        cell3_3.setCellStyle(contentStyle);
        cell3_3.setCellValue(String.valueOf( jsonObject.get("aboveMinisterPeopleCount1")));

        Cell cell3_4 = row3.createCell(4);
        cell3_4.setCellStyle(contentStyle);
        cell3_4.setCellValue(String.valueOf(jsonObject.get("aboveMinisterPeopleCount1")));

        // 空格
        Cell cell3_5 = row3.createCell(5);
        cell3_5.setCellStyle(contentStyle);

        // 空格
        Cell cell3_6 = row3.createCell(6);
        cell3_6.setCellStyle(contentStyle);

        row++;

        // 副部级
        Row row4 = sheet.createRow(row);
        row4.setHeightInPoints(175F);

        Cell cell4_0 = row4.createCell(0);
        cell4_0.setCellStyle(contentStyle);
        cell4_0.setCellValue("副部级领导干部出国（境）");

        Cell cell4_1 = row4.createCell(1);
        cell4_1.setCellStyle(contentStyle);
        cell4_1.setCellValue(String.valueOf(jsonObject.get("viceMinisterBatchCount1")));

        Cell cell4_2 = row4.createCell(2);
        cell4_2.setCellStyle(contentStyle);
        cell4_2.setCellValue(String.valueOf(jsonObject.get("viceMinisterBatchCount2")));

        Cell cell4_3 = row4.createCell(3);
        cell4_3.setCellStyle(contentStyle);
        cell4_3.setCellValue(String.valueOf( jsonObject.get("viceMinisterPeopleCount1")));

        Cell cell4_4 = row4.createCell(4);
        cell4_4.setCellStyle(contentStyle);
        cell4_4.setCellValue(String.valueOf(jsonObject.get("viceMinisterPeopleCount2")));

        // 空格
        Cell cell4_5 = row4.createCell(5);
        cell4_5.setCellStyle(contentStyle);

        // 空格
        Cell cell4_6 = row4.createCell(6);
        cell4_6.setCellStyle(contentStyle);

        row++;

        // 局级及以下
        Row row5 = sheet.createRow(row);
        row5.setHeightInPoints(175F);

        Cell cell5_0 = row5.createCell(0);
        cell5_0.setCellStyle(contentStyle);
        cell5_0.setCellValue("机关厅局级及以下人员出国（境）");

        Cell cell5_1 = row5.createCell(1);
        cell5_1.setCellStyle(contentStyle);
        cell5_1.setCellValue(String.valueOf(jsonObject.get("viceMinisterBatchCount1")));

        Cell cell5_2 = row5.createCell(2);
        cell5_2.setCellStyle(contentStyle);
        cell5_2.setCellValue(String.valueOf(jsonObject.get("viceMinisterBatchCount2")));

        Cell cell5_3 = row5.createCell(3);
        cell5_3.setCellStyle(contentStyle);
        cell5_3.setCellValue(String.valueOf( jsonObject.get("viceMinisterPeopleCount1")));

        Cell cell5_4 = row5.createCell(4);
        cell5_4.setCellStyle(contentStyle);
        cell5_4.setCellValue(String.valueOf(jsonObject.get("viceMinisterPeopleCount2")));

        // 空格
        Cell cell5_5 = row5.createCell(5);
        cell5_5.setCellStyle(contentStyle);

        // 空格
        Cell cell5_6 = row5.createCell(6);
        cell5_6.setCellStyle(contentStyle);

        workbook.write(os);
    }
}
