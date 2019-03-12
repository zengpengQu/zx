package com.taiji.frame.service.foreignaffairs.taiwanCard;

import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.BorrowRecord;
import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanCard;
import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanCardFile;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.taiwanCard.TaiWanCardVo;
import com.taiji.frame.model.vo.passportuser.PassportUserVo;
import com.taiji.frame.service.foreignaffairs.passportRecord.BorrowRecordService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/08/10
 * 赴台通行证服务
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class TaiWanCardService extends BaseDAO<TaiWanCard> {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanCardService.class);

    @Autowired
    private TaiWanCardFileService taiWanCardFileService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private BorrowRecordService borrowRecordService;

    @Autowired
    private SysLogService sysLogService;

    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<TaiWanCard> cardCarrier, Map<String,Object> map) {
        StringBuilder hql = new StringBuilder(" from TaiWanCard tp where 1 = 1");
        if (map.containsKey("empName")){
            hql.append(" and tp.dicUser.empName like :empName");
        }
        if (map.containsKey("permitCode")){
            hql.append(" and tp.permitCode like :permitCode");
        }if (map.containsKey("signDateStr")){
            hql.append(" and to_char(tp.signDate,'yyyy-MM-dd') >= :signDateStr");
        }

        if (map.containsKey("validDateStr")){
            hql.append(" and to_char(tp.validDate,'yyyy-MM-dd') <= :validDateStr");
        }
        hql.append(" and tp.delFlag = '0'");
        find(cardCarrier,hql.toString(),map);
    }

    /**
     * 判断是否可以办理
     * @param userId
     */
    public Boolean isCanTransact(String userId) {
        StringBuffer hql = new StringBuffer();
        Map<String, Object> params = new HashMap<>(1);
        hql.append(" from TaiWanCard t where t.delFlag = 0");
        if (StringUtils.isNotEmpty(userId)) {
            hql.append(" and t.dicUser.id = :userId");
            params.put("userId", userId);
        }
        List<TaiWanCard> taiWanCardList = find(hql.toString(), params);

        return (null == taiWanCardList || 0 == taiWanCardList.size());
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> saveData(TaiWanCardVo taiWanCardVo, String basePath, DicUser curUser, SysLogVo sysLogVo,Date date) {
        Map map = new HashMap(3);
        String dstDir = UploadConstant.taiwanCard;
        try {
            String taiwanCardId = taiWanCardVo.getTaiwanCardId();


            sysLogVo.setTypeName("赴台通行证");

            if (StringUtils.isNotEmpty(taiwanCardId)){
                //编辑
                TaiWanCard taiWanCard = this.get(taiwanCardId);
                setData(taiWanCard,taiWanCardVo);
                this.save(taiWanCard);
                //附件上传
                String fileId = taiWanCardVo.getFileId();
                if (StringUtils.isNotEmpty(fileId)){
                    Boolean isExist = taiWanCardFileService.findByFileIdAndCardId(fileId,taiwanCardId);
                    if (!isExist){
                        DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                        dicUploadFileService.transfer(uploadFile,dstDir);
                        TaiWanCardFile file = taiWanCardFileService.findByCardId(taiwanCardId);
                        if (null != file){
                            // 删除旧附件
                            dicUploadFileService.logicDeleteFile(file.getFileId());

                            //编辑
                            file.setFileId(fileId);
                            taiWanCardFileService.save(file);
                        }else {
                            //新增
                            TaiWanCardFile taiWanCardFile = new TaiWanCardFile();
                            taiWanCardFile.setTaiWanCard(taiWanCard);
                            taiWanCardFile.setFileId(fileId);
                            taiWanCardFileService.save(taiWanCardFile);
                        }
                    }
                }
                sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(taiWanCard.getDicUser().getEmpName());
                sysLogVo.setEntityId(taiWanCard.getId());
                map.put("result", true);
            }else {
                //新增
                TaiWanCard taiWanCard = new TaiWanCard();
                taiWanCard.setCreateTime(new Date());
                setData(taiWanCard,taiWanCardVo);
                this.save(taiWanCard);

                //流转记录
                BorrowRecord borrowRecord = new BorrowRecord();
                borrowRecord.setStatus("0");
                borrowRecord.setCreateTime(DateUtil.dateToDateByFormat(date, DateUtil.FORMAT));
                borrowRecord.setDicUser(curUser);
                borrowRecord.setPermitId(taiWanCard.getId());
                borrowRecord.setPermitType("1");
                borrowRecordService.save(borrowRecord);
                //附件上传
                String fileId = taiWanCardVo.getFileId();
                if (StringUtils.isNotEmpty(fileId)){
                    TaiWanCardFile taiWanCardFile = new TaiWanCardFile();
                    DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                    dicUploadFileService.transfer(uploadFile,dstDir);
                    taiWanCardFile.setTaiWanCard(taiWanCard);
                    taiWanCardFile.setFileId(fileId);
                    taiWanCardFile.setSeq(0);
                    taiWanCardFileService.save(taiWanCardFile);
                }
                sysLogVo.setRecordType(0);
                sysLogVo.setEntityName(taiWanCard.getDicUser().getEmpName());
                sysLogVo.setEntityId(taiWanCard.getId());
                map.put("result", true);
            }
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            LOGGER.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    private void setData(TaiWanCard taiWanCard,TaiWanCardVo taiWanCardVo) throws ParseException {
        DicUser dicUser = new DicUser();
        String peopleId = taiWanCardVo.getPeopleId();
        dicUser.setId(peopleId);
        taiWanCard.setDicUser(dicUser);
        DicDept dicDept = new DicDept();
        String department = taiWanCardVo.getDepartment();
        dicDept.setId(department);
        taiWanCard.setDicDept(dicDept);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String signDateStr = taiWanCardVo.getSignDateStr();
        String validDateStr = taiWanCardVo.getValidDateStr();
        taiWanCard.setSignDate(sdf.parse(signDateStr));
        taiWanCard.setValidDate(sdf.parse(validDateStr));

        String newOld = taiWanCardVo.getNewOld();
        taiWanCard.setNewOld(newOld);
        String idNumber = taiWanCardVo.getIdNumber();
        taiWanCard.setIdNumber(idNumber);
        String permitCode = taiWanCardVo.getPermitCode();
        taiWanCard.setPermitCode(permitCode);
        String signSite = taiWanCardVo.getSignSite();
        taiWanCard.setSignSite(signSite);
        String signOrg = taiWanCardVo.getSignOrg();
        taiWanCard.setSignOrg(signOrg);
        String isExpired = taiWanCardVo.getIsExpired();
        taiWanCard.setIsExpired(isExpired);
        String keepOrg = taiWanCardVo.getKeepOrg();
        taiWanCard.setKeepOrg(keepOrg);
        taiWanCard.setIsBorrow("0");
        taiWanCard.setUpdateTime(new Date());
        String notes = taiWanCardVo.getNotes();
        taiWanCard.setNotes(notes);
        taiWanCard.setDelFlag("0");
    }

    @Transactional(rollbackFor = Exception.class)
    public List<TaiWanCard> findDataForExcel(String empName, String permitCode, String signDateStr, String validDateStr) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from TaiWanCard t where 1 = 1");
        if (StringUtils.isNotEmpty(empName)){
            hql.append(" and t.dicUser.empName like :empName");
            params.put("empName","%" + empName.trim() + "%");
        }
        if (StringUtils.isNotEmpty(permitCode)){
            hql.append(" and t.permitCode like :permitCode");
            params.put("permitCode","%" + permitCode.trim() + "%");
        }
        if (StringUtils.isNotEmpty(signDateStr) && StringUtils.isNotEmpty(validDateStr)){
            hql.append(" and t.signDate between to_date(:signDateStr, 'YYYY-MM-DD') and to_date(:validDateStr, 'YYYY-MM-DD')");
            hql.append(" and t.validDate between to_date(:signDateStr, 'YYYY-MM-DD') and to_date(:validDateStr, 'YYYY-MM-DD')");
            params.put("signDate", signDateStr);
            params.put("validDate", validDateStr);
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");
        List<TaiWanCard> list = find(hql.toString(), params);
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
    public void createExcel(OutputStream os, String fileName, String curDate,
                            String curUser, List<TaiWanCard> list)
            throws IOException,IndexOutOfBoundsException{
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
    public void process(String curDate, String curUser, HSSFWorkbook workbook, HSSFSheet sheet, List<TaiWanCard> list) {
        int count = 0;
        //第一行 标题样式
        CellStyle sty = workbook.createCellStyle();
        //设置标题字体格式
        Font fon = workbook.createFont();
        fon.setFontHeightInPoints((short) 18);
        fon.setFontName("宋体");
        // 加粗,居中
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
        cell1.setCellValue("赴台通行证详细信息");
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
        font1.setFontHeightInPoints((short) 14);
        font1.setFontName("黑体");
        font1.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        style1.setFont(font1);

        //数据样式

        //第五行（表头）
        Row row4 = sheet.createRow(count);
        Cell cell5_0 = row4.createCell(0);
        cell5_0.setCellStyle(style1);
        cell5_0.setCellValue("  姓名   ");

        Cell cell5_1 = row4.createCell(1);
        cell5_1.setCellStyle(style1);
        cell5_1.setCellValue("  证件号码   ");

        Cell cell5_2 = row4.createCell(2);
        cell5_2.setCellStyle(style1);
        cell5_2.setCellValue("  签发地点   ");

        Cell cell5_3 = row4.createCell(3);
        cell5_3.setCellStyle(style1);
        cell5_3.setCellValue("  签发日期   ");

        Cell cell5_4 = row4.createCell(4);
        cell5_4.setCellStyle(style1);
        cell5_4.setCellValue("  有效期至   ");

        Cell cell5_5 = row4.createCell(5);
        cell5_5.setCellStyle(style1);
        cell5_5.setCellValue("   身份证号     ");

        Cell cell5_6 = row4.createCell(6);
        cell5_6.setCellStyle(style1);
        cell5_6.setCellValue("  工作部门   ");
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

        for (int i = 0; i < list.size(); i ++) {
            TaiWanCard taiWanCard = list.get(i);
            Row row = sheet.createRow(count + i);
            String userName = null == taiWanCard.getDicUser() ? "" : taiWanCard.getDicUser().getEmpName();
            String permitCode = null == taiWanCard.getPermitCode() ? "" : taiWanCard.getPermitCode();
            String signSite = null == taiWanCard.getSignSite() ? "" : taiWanCard.getSignSite();
            String signDate = null == taiWanCard.getSignDate() ? "" : DateUtil.dateToString(taiWanCard.getSignDate(), DateUtil.FORMAT_DAY);
            String validDate = null == taiWanCard.getValidDate() ? "" : DateUtil.dateToString(taiWanCard.getValidDate(), DateUtil.FORMAT_DAY);
            String passportCode = null == taiWanCard.getIdNumber() ? "" : taiWanCard.getIdNumber();
            String deptName = null == taiWanCard.getDicDept().getDeptName() ? "" : taiWanCard.getDicDept().getDeptName();

            Cell cell_0 = row.createCell(0);
            cell_0.setCellValue(userName);
            cell_0.setCellStyle(style);

            Cell cell_1 = row.createCell(1);
            cell_1.setCellValue(permitCode);
            cell_1.setCellStyle(style);

            Cell cell_2 = row.createCell(2);
            cell_2.setCellValue(signSite);
            cell_2.setCellStyle(style);

            Cell cell_3 = row.createCell(3);
            cell_3.setCellValue(signDate);
            cell_3.setCellStyle(style);

            Cell cell_4 = row.createCell(4);
            cell_4.setCellValue(validDate);
            cell_4.setCellStyle(style);

            Cell cell_5 = row.createCell(5);
            cell_5.setCellValue(passportCode);
            cell_5.setCellStyle(style);

            Cell cell_6 = row.createCell(6);
            cell_6.setCellValue(deptName);
            cell_6.setCellStyle(style);
        }
    }

    public void loadUser(Carrier<PassportUserVo> carrier, Map<String, Object> map) {
        StringBuffer sql = new StringBuffer("SELECT u.ID AS id, (SELECT DEPT_NAME FROM SCH_DUTY.TB_DIC_DEPT where ID = u.DEPT_ID) AS deptName, u.EMP_NAME AS empName,");
        sql.append(" u.SEX AS sex, u.NATION as nation, u.BIRTHDAY AS birthday, u.BIRTHPLACE AS birthplace,");
        sql.append(" u.PHONE AS phone, u.MAIN_DUTY AS mainDuty, (SELECT NAME FROM SCH_DUTY.TB_DIC_PARAM where ID = u.RANK_ID) AS rankName, c.id as transactStatus,");
        sql.append(" u.CREATE_DATE AS createDate");

        sql.append(" from SCH_DUTY.TB_DIC_USER u left join (SELECT ID, PEOPLEINFO_ID from SCH_DUTY.DM_PPM_TAIWAN card where card.DEL_FLAG='0') c");
        sql.append(" on u.ID = C.PEOPLEINFO_ID");
        sql.append(" where 1=1");

//        sql.append(" and t.id not in (select dicUser.id from TaiWanCard card where 1=1 and card.delFlag='0' )");
        if (map.containsKey("empName")) {
            sql.append(" and u.EMP_NAME like :empName");
        }
        if (map.containsKey("searchUserId")) {
            sql.append(" and u.USER_ID like :searchUserId");
        }
        if (map.containsKey("stringList")) {
            sql.append(" and u.DEPT_ID.id in (:stringList)");
        }
        if (map.containsKey("rankId")) {
            sql.append(" and u.RANK_ID = :rankId");
        }

        findBySql(PassportUserVo.class, carrier, sql.toString(), map);
    }
}
