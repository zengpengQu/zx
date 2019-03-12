package com.taiji.frame.service.foreignaffairs.hkmacao;

import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.hkmacao.HkMaCao;
import com.taiji.frame.model.entity.foreignaffairs.hkmacao.HkMaCaoFile;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.BorrowRecord;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.hkmacao.HkMaCaoVo;
import com.taiji.frame.model.vo.passportuser.PassportUserVo;
import com.taiji.frame.service.foreignaffairs.passportRecord.BorrowRecordService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author qzp
 * @date 2018/08/01
 * 港澳通行证管理服务
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class HkMaCaoService extends BaseDAO<HkMaCao> {
    private static final Logger log = LoggerFactory.getLogger(HkMaCaoService.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private BorrowRecordService borrowRecordService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private HkMaCaoFileService hkMaCaoFileService;
    @Autowired
    private SysLogService sysLogService;


    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<HkMaCao> carrier, HashMap<String,Object> map,Date currDate) {
        reloadData(currDate);
        StringBuilder hql = new StringBuilder();
        hql.append(" from HkMaCao hm where 1 = 1");
        if (map.containsKey("curUserId")) {
            hql.append(" and hm.dicUser.id = :curUserId");
        }
        if (map.containsKey("empName")){
            hql.append(" and hm.dicUser.empName like :empName");
        }
        if(map.containsKey("permitCode")){
            hql.append(" and hm.permitCode like :permitCode");
        }
        if (map.containsKey("signDate")){
            hql.append(" and to_char(hm.signDate,'yyyy-MM-dd') >= :signDate");
        }
        if (map.containsKey("validDate")){
            hql.append(" and to_char(hm.validDate,'yyyy-MM-dd') <= :validDate");
        }
        hql.append(" and hm.delFlag = '0'");
        find(carrier,hql.toString(),map);
    }

    /**
     * 判断是否可以办理
     * @param userId
     */
    public Boolean isCanTransact(String userId) {
        StringBuffer hql = new StringBuffer();
        Map<String, Object> params = new HashMap<>(1);
        hql.append(" from HkMaCao t where t.destroy = 0 and t.delFlag = 0");
        if (StringUtils.isNotEmpty(userId)) {
            hql.append(" and t.dicUser.id = :userId");
            params.put("userId", userId);
        }
        List<HkMaCao> hkMaCaoList = find(hql.toString(), params);

        return (null == hkMaCaoList || 0 == hkMaCaoList.size());
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> saveData(HkMaCaoVo hkMaCaoVo, String basePath, SysLogVo sysLogVo) throws ParseException {
        HashMap map = new HashMap(1);
        HkMaCao hkMaCao = null;
        String dstDir = UploadConstant.hkMacao;


        String hkMaCaoId = hkMaCaoVo.getId();
        try {
            if(StringUtils.isNotEmpty(hkMaCaoId)){
                //编辑
                hkMaCao = this.get(hkMaCaoId);
                //给对象设置属性值
                this.setHkMaCaoData(hkMaCao,hkMaCaoVo);
                this.save(hkMaCao);
                //附件上传
                String fileId = hkMaCaoVo.getFileId();
                if (StringUtils.isNotEmpty(fileId)){
                    Boolean isExist = this.findByHkmacaoAndFiledId(hkMaCaoId,fileId);
                    if(!isExist){
                        //不存在
                        DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                        dicUploadFileService.transfer(uploadFile,dstDir);
                        HkMaCaoFile file = hkMaCaoFileService.getHkMacao(hkMaCaoId);
                        if (file != null){
                            // 删除旧附件
                            dicUploadFileService.logicDeleteFile(file.getDicUploadFile().getId());

                            //之前上传过附件,更新
                            file.setDicUploadFile(uploadFile);
                            hkMaCaoFileService.save(file);
                        }else {
                            //原本就不存在附件,新增
                            HkMaCaoFile hkMaCaoFile = new HkMaCaoFile();
                            hkMaCaoFile.setDicUploadFile(uploadFile);
                            hkMaCaoFile.setHkMaCao(hkMaCao);
                            hkMaCaoFile.setSeq(0);
                            hkMaCaoFileService.save(hkMaCaoFile);
                        }
                    }
                }
                map.put("result", true);
            }else {
                //新增
                hkMaCao = new HkMaCao();
                //设置创建时间
                hkMaCao.setCreateTime(new Date());
                //给对象设置属性值
                this.setHkMaCaoData(hkMaCao,hkMaCaoVo);
                this.save(hkMaCao);
                //附件上传
                String fileId = hkMaCaoVo.getFileId();
                if (StringUtils.isNotEmpty(fileId)){
                    DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                    // 转移公告栏文件到正式文件
                    try {
                        dicUploadFileService.transfer(uploadFile,dstDir);
                        this.saveHkMaCaoFile(hkMaCao,uploadFile);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                map.put("result",true);
            }
            sysLogVo.setTypeName("港澳通行证管理");
            if(org.apache.commons.lang.StringUtils.isEmpty(hkMaCaoId)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(hkMaCao.getDicUser().getEmpName());
            sysLogVo.setEntityId(hkMaCao.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            log.error("保存港澳通行证信息失败" + e.getMessage(),e);
            map.put("result",false);
            return map;
        }
        return map;
    }

    private void setHkMaCaoData(HkMaCao hkMaCao,HkMaCaoVo hkMaCaoVo) throws ParseException {
        String peopleId = hkMaCaoVo.getPeopleId();
        DicUser dicUser = new DicUser();
        dicUser.setId(peopleId);
        hkMaCao.setDicUser(dicUser);

        String department = hkMaCaoVo.getDepartment();
        DicDept dicDept = new DicDept();
        dicDept.setId(department);
        hkMaCao.setDicDept(dicDept);

        String signDateStr = hkMaCaoVo.getSignDateStr();
        String validDateStr = hkMaCaoVo.getValidDateStr();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        hkMaCao.setSignDate(sdf.parse(signDateStr));
        hkMaCao.setValidDate(sdf.parse(validDateStr));
        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        hkMaCao.setUpdateTime(updateTime);

        hkMaCao.setSignOrg(hkMaCaoVo.getSignOrg());
        hkMaCao.setPermitCode(hkMaCaoVo.getPermitCode());

        hkMaCao.setUseStatus("0");
        hkMaCao.setStoreStatus("0");
        hkMaCao.setDelFlag("0");
        hkMaCao.setDestroy("0");
    }

    //文件是否存在
    private Boolean findByHkmacaoAndFiledId(String id, String fileId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from HkMaCaoFile t where 1 = 1");
        if (StringUtils.isNotEmpty(id)) {
            hql.append(" and t.hkMaCao.id = :id");
            params.put("id", id);
        }
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and t.dicUploadFile.id = :fileId");
            params.put("fileId", fileId);
        }
        List<HkMaCaoFile> list = find(hql.toString(), params);
        if (null != list && list.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> borrowHkMacao(
            String ids, String borrower,
            DicUser curUser, String borrowTimeStr,
            Date updteTime,Date createTime,SysLogVo sysLogVo) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(ids)){
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0;i < jsonArray.size();i++){
                    //状态设置为借出
                    String id = (String)jsonArray.get(i);
                    HkMaCao hkMaCao = this.get(id);
                    hkMaCao.setStoreStatus("1");
                    hkMaCao.setUpdateTime(updteTime);
                    //借出记录
                    BorrowRecord borrowRecord = new BorrowRecord();
                    borrowRecord.setBorrower(borrower);
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    borrowRecord.setBorrowTime(sdf.parse(borrowTimeStr));
                    borrowRecord.setDicUser(curUser);
                    borrowRecord.setStatus("1");
                    borrowRecord.setCreateTime(createTime);
                    borrowRecord.setPermitId(id);
                    borrowRecord.setPermitType("2");
                    //操作
                    this.save(hkMaCao);
                    borrowRecordService.save(borrowRecord);
                }
            }
            sysLogVo.setTypeName("港澳通行证借出");
                sysLogVo.setRecordType(22);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result",true);
        }catch (Exception e){
            log.error(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> returnBack(
            String ids, String returnPeople,
            String returnTimeStr,Date updateTime,
            Date createTime,DicUser curUser,SysLogVo sysLogVo) {
        HashMap<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(ids)){
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i++) {
                    String id = (String)jsonArray.get(i);
                    //状态设置为在库
                    HkMaCao hkMaCao = this.get(id);
                    hkMaCao.setStoreStatus("0");
                    hkMaCao.setUpdateTime(updateTime);
                    //归还记录
                    BorrowRecord borrowRecord = new BorrowRecord();
                    borrowRecord.setReturnPeople(returnPeople);
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    borrowRecord.setReturnTime(sdf.parse(returnTimeStr));
                    borrowRecord.setDicUser(curUser);
                    borrowRecord.setCreateTime(createTime);
                    borrowRecord.setStatus("2");
                    borrowRecord.setPermitId(id);
                    borrowRecord.setPermitType("2");
                    //操作
                    this.save(hkMaCao);
                    borrowRecordService.save(borrowRecord);
                }
            }
            sysLogVo.setTypeName("港澳通行证归还");
            sysLogVo.setRecordType(23);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
            map.put("result",true);
        } catch (Exception e) {
            log.error(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> destroyHkMacao(
            String ids, String destroyReason,
            Date updateTime,Date destroyDate,SysLogVo sysLogVo) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (StringUtils.isNotEmpty(ids)){
                JSONArray jsonArray = JSONArray.fromObject(ids);
                for (int i = 0; i < jsonArray.size(); i++) {
                    String id = (String)jsonArray.get(i);
                    HkMaCao hkMaCao = this.get(id);
                    hkMaCao.setDestroy("1");
                    hkMaCao.setUpdateTime(updateTime);
                    //销毁
                    this.save(hkMaCao);
                    //销毁记录
                    BorrowRecord borrowRecord = new BorrowRecord();
                    borrowRecord.setCreateTime(updateTime);
                    borrowRecord.setPermitId(id);
                    borrowRecord.setPermitType("2");
                    borrowRecord.setStatus("4");
                    borrowRecord.setDestroyReason(destroyReason);
                    borrowRecordService.save(borrowRecord);
                }
                map.put("result",true);
                sysLogVo.setTypeName("港澳通行证销毁");
                sysLogVo.setRecordType(20);
                sysLogVo.setEntityName("");
                sysLogVo.setEntityId("");
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
                map.put("result",true);
            }
        } catch (Exception e) {
            log.error(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    @Transactional(rollbackFor = Exception.class)
    public List<HkMaCao> findList(String empName, String permitCode, String signDate, String validDate) {
        Map<String, Object> map = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from HkMaCao hk where 1 = 1");
        if (StringUtils.isNotEmpty(empName)){
            hql.append(" and hk.dicUser.empName like :empName");
            map.put("empName","%" + empName.trim() + "%");
        }
        if (StringUtils.isNotEmpty(permitCode)){
            hql.append(" and hk.permitCode like :permitCode");
            map.put("permitCode","%" + permitCode + "%");
        }
        if (StringUtils.isNotEmpty(signDate) && StringUtils.isNotEmpty(validDate)) {
            hql.append(" and hk.signDate between to_date(:signDate, 'YYYY-MM-DD') and to_date(:validDate, 'YYYY-MM-DD')");
            hql.append(" and hk.validDate between to_date(:signDate, 'YYYY-MM-DD') and to_date(:validDate, 'YYYY-MM-DD')");
            map.put("signDate", signDate);
            map.put("validDate", validDate);
        }
        hql.append(" and hk.delFlag = '0' order by hk.updateTime desc ");
        List<HkMaCao> list = find(hql.toString(),map);
        return list;
    }

    private void reloadData(Date currDate) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from HkMaCao where delFlag = '0'");
        hql.append(" order by createTime desc");
        List<HkMaCao> list = find(hql.toString(), null);
        for (HkMaCao hkMaCao : list){
            Date validDate = hkMaCao.getValidDate();
            String useStatus = hkMaCao.getUseStatus();
            int daysBetween = daysBetween(currDate, validDate);

            if (daysBetween <= 90 && daysBetween > 0){
                //临近逾期
                if(useStatus != "1"){
                    hkMaCao.setUseStatus("1");
                    this.save(hkMaCao);
                }
            }else if(daysBetween <= 0){
                //已逾期
                if(useStatus != "2"){
                    hkMaCao.setUseStatus("2");
                    this.save(hkMaCao);
                }
            }
        }
    }

    /**
     * 计算2个日期相差的天数
     * @param smdate  较小的时间
     * @param bdate  较大的时间
     * @return  相差的天数
     */
    private static int daysBetween(Date smdate,Date bdate){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        long between_days = 0;
        try {
            smdate = sdf.parse(sdf.format(smdate));
            bdate = sdf.parse(sdf.format(bdate));
            Calendar cal = Calendar.getInstance();
            cal.setTime(smdate);
            long time1 = cal.getTimeInMillis();
            cal.setTime(bdate);
            long time2 = cal.getTimeInMillis();
            between_days = (time2 - time1) / (1000 * 3600 * 24);
        } catch (ParseException e) {
            log.error(e.getLocalizedMessage(),e);
        }
        return Integer.parseInt(String.valueOf(between_days));
    }

    /**
     * 港澳通行证附件信息---新增或编辑
     * @param hkMaCao
     * @param uploadFile
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveHkMaCaoFile(HkMaCao hkMaCao, DicUploadFile uploadFile) {
        Assert.notNull(hkMaCao, "hkMaCao must not be null");
        Assert.notNull(uploadFile, "uploadFile must not be null");

        HkMaCaoFile hkMaCaoFile = new HkMaCaoFile();
        hkMaCaoFile.setHkMaCao(hkMaCao);
        hkMaCaoFile.setDicUploadFile(uploadFile);
        hkMaCaoFile.setSeq(0);
        try {
            hkMaCaoFileService.save(hkMaCaoFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void loadUser(Carrier<PassportUserVo> carrier, Map<String, Object> map) {
        StringBuffer sql = new StringBuffer("SELECT u.ID AS id, (SELECT DEPT_NAME FROM SCH_DUTY.TB_DIC_DEPT where ID = u.DEPT_ID) AS deptName, u.EMP_NAME AS empName,");
        sql.append(" u.SEX AS sex, u.NATION as nation, u.BIRTHDAY AS birthday, u.BIRTHPLACE AS birthplace,");
        sql.append(" u.PHONE AS phone, u.MAIN_DUTY AS mainDuty, (SELECT NAME FROM SCH_DUTY.TB_DIC_PARAM where ID = u.RANK_ID) AS rankName, c.id as transactStatus,");
        sql.append(" u.CREATE_DATE AS createDate");

        sql.append(" from SCH_DUTY.TB_DIC_USER u left join (SELECT ID, PEOPLEINFO_ID from SCH_DUTY.DM_PPM_HKMACAO card where card.DEL_FLAG='0') c");
        sql.append(" on u.ID = c.PEOPLEINFO_ID");
        sql.append(" where 1=1");

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
