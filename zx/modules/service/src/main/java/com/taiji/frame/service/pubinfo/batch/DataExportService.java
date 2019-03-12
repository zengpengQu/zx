package com.taiji.frame.service.pubinfo.batch;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.batch.RegisterBatch;
import com.taiji.frame.model.vo.pubinfo.batch.DataExportVo;
import com.taiji.frame.model.vo.pubinfo.batch.RegisterBatchVo;
import com.taiji.frame.util.BaseDAO;
import org.hibernate.SessionFactory;
import org.springframework.jdbc.object.SqlQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 呈批件数据汇总
 * @author wsh
 * @date 2018/9/20
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DataExportService extends BaseDAO<DataExportVo> {

    /**
     * Sql查询语句的分页查询,列表的展示使用
     */
    public void load(Carrier<DataExportVo> carrier, Map<String, Object> map) {
        StringBuffer sql = new StringBuffer();
        /**
         * 查询的内行文
         */
        sql.append("(select TITLE as title,MEDI_UNIT as orgName,to_char(SEND_TIME, 'yyyy-MM-dd HH:mm') as sendTime,REPORTER as signature,COUNTER_SIGN_FLAG as counterSignFlag,COUNTER_SIGN_UNIT as counterSignUnit,DEP_LEADER as leaName");
        sql.append(" from SCH_DUTY.PU_INSIDE_SUBJECT w where 1 = 1");
        if (map.containsKey("startDate")) {
            sql.append(" and to_char(w.SEND_TIME,'yyyy-MM-dd') >= :startDate");
        }
        if (map.containsKey("endDate")) {
            sql.append(" and to_char(w.SEND_TIME,'yyyy-MM-dd') <= :endDate");
        }
        if (map.containsKey("title")) {
            sql.append(" and w.TITLE like '%" + map.get("title") + "%'");
        }
        if (map.containsKey("counterSignFlag")) {
                sql.append(" and w.COUNTER_SIGN_FLAG = :counterSignFlag");
        }
        if (map.containsKey("leader")) {
            sql.append(" and w.DEP_LEADER like '%" + map.get("leader") + "%'");
        }
        if (map.containsKey("medDept")) {
            sql.append(" and w.MEDI_UNIT like '%" + map.get("medDept") + "%'");
        }
        sql.append(" and w.DEL_FLAG = '0'");
        sql.append(" and w.STATUS >= '2'");

        sql.append(" union all");

        /**
         * 查询的外行文
         */
        sql.append(" select TITLE as title,MEDI_UNIT as orgName,to_char(SEND_TIME, 'yyyy-MM-dd HH:mm') as sendTime,CONTRACTOR as signature,COUNTER_SIGN_FLAG as counterSignFlag,COUNTER_SIGN_UNIT as counterSignUnit,DEP_LEADER as leaName");
        sql.append(" from SCH_DUTY.PU_OUTSIDE_SUBJECT db where 1 = 1");
        if (map.containsKey("startDate")) {
            sql.append(" and to_char(db.SEND_TIME,'yyyy-MM-dd') >= :startDate");
        }
        if(map.containsKey("endDate")){
            sql.append(" and to_char(db.SEND_TIME,'yyyy-MM-dd') <= :endDate");
        }
        if(map.containsKey("title")){
            sql.append(" and db.TITLE like '%"+map.get("title")+"%'");
        }
        if (map.containsKey("counterSignFlag")) {
            sql.append(" and db.COUNTER_SIGN_FLAG = :counterSignFlag");
        }
        if(map.containsKey("medDept")){
            sql.append(" and db.MEDI_UNIT like '%"+map.get("medDept")+"%'");
        }
        if (map.containsKey("leader")) {
            sql.append(" and db.DEP_LEADER like '%" + map.get("leader") + "%'");
        }
        sql.append(" and db.DEL_FLAG = '0'");
        sql.append(" and db.STATUS >= '2')");

        findBySql(DataExportVo.class,carrier,sql.toString(),map);

    }

    /**
     * Sql查询语句的分页查询,各部门上报的呈批件导出使用，默认导出一周
     */
    public List<DataExportVo> findByWeek(Map<String, Object> map) {
        StringBuffer sql = new StringBuffer();
        /**
         * 查询的内行文
         */
        sql.append("select a.title,a.orgName,a.sendTime,a.signature,a.leaName,a.number from");
        sql.append(" (select TITLE as title,MEDI_UNIT as orgName,to_char(SEND_TIME, 'MM月dd日') as sendTime,REPORTER as signature,DEP_LEADER as leaName,SER_NUMBER as number");
        sql.append(" from SCH_DUTY.PU_INSIDE_SUBJECT w where 1 = 1");
        if (map.containsKey("startDate")) {
            sql.append(" and to_char(w.SEND_TIME,'yyyy-MM-dd') >= :startDate");
        }
        if (map.containsKey("endDate")) {
            sql.append(" and to_char(w.SEND_TIME,'yyyy-MM-dd') <= :endDate");
        }
        if (map.containsKey("title")) {
            sql.append(" and w.TITLE like '%" + map.get("title") + "%'");
        }
        if (map.containsKey("counterSignFlag")) {
            sql.append(" and w.COUNTER_SIGN_FLAG = :counterSignFlag");
        }
        if (map.containsKey("leader")) {
            sql.append(" and w.DEP_LEADER like '%" + map.get("leader") + "%'");
        }
        if (map.containsKey("medDept")) {
            sql.append(" and w.MEDI_UNIT like '%" + map.get("medDept") + "%'");
        }
        sql.append(" and w.DEL_FLAG = '0'");
        sql.append(" and w.STATUS >= '2'");

        sql.append(" union all");

        /**
         * 查询的外行文
         */
        sql.append(" select TITLE as title,MEDI_UNIT as orgName,to_char(SEND_TIME, 'MM月dd日') as sendTime,CONTRACTOR as signature,DEP_LEADER as leaName,SER_NUMBER as number");
        sql.append(" from SCH_DUTY.PU_OUTSIDE_SUBJECT db where 1 = 1");
        if (map.containsKey("startDate")) {
            sql.append(" and to_char(db.SEND_TIME,'yyyy-MM-dd') >= :startDate");
        }
        if(map.containsKey("endDate")){
            sql.append(" and to_char(db.SEND_TIME,'yyyy-MM-dd') <= :endDate");
        }
        if(map.containsKey("title")){
            sql.append(" and db.TITLE like '%"+map.get("title")+"%'");
        }
        if (map.containsKey("counterSignFlag")) {
            sql.append(" and db.COUNTER_SIGN_FLAG = :counterSignFlag");
        }
        if(map.containsKey("medDept")){
            sql.append(" and db.MEDI_UNIT like '%"+map.get("medDept")+"%'");
        }
        if (map.containsKey("leader")) {
            sql.append(" and db.DEP_LEADER like '%" + map.get("leader") + "%'");
        }
        sql.append(" and db.DEL_FLAG = '0'");
        sql.append(" and db.STATUS >= '2')");
        sql.append(" as a");
        sql.append(" order by number asc");

        List<DataExportVo> list = findBySql(DataExportVo.class,sql.toString(),map);
        return  list;

    }

    /**
     * 领导批示导出使用
     * @param map
     * @return
     */
    public List<RegisterBatchVo> findConments(Map<String,Object> map){
        StringBuffer sql = new StringBuffer();
        /**
         * 查询的内行文
         */
        sql.append(" select a.batchId,a.batchOutId,a.updateTimeStr,a.conmentsLeader,a.reportLeader,a.dutyName,a.seq from");
        sql.append("(select SUBJECT_ID as batchId, ''batchOutId, to_char(UPDATE_TIME, 'MM月dd日') as updateTimeStr,CONMENTS_LEADER as conmentsLeader,REPORT_LEADER as reportLeader,DUTY_NAME as dutyName,SEQ as seq");
        sql.append(" from SCH_DUTY.PU_SUBJECT_REG r where r.SUBJECT_ID in");
        sql.append(" (select ID as nei from SCH_DUTY.PU_INSIDE_SUBJECT w where 1=1");
        if (map.containsKey("startDate")) {
            sql.append(" and to_char(w.SEND_TIME,'yyyy-MM-dd') >= :startDate");
        }
        if (map.containsKey("endDate")) {
            sql.append(" and to_char(w.SEND_TIME,'yyyy-MM-dd') <= :endDate");
        }
        if (map.containsKey("title")) {
            sql.append(" and w.TITLE like '%" + map.get("title") + "%'");
        }
        if (map.containsKey("counterSignFlag")) {
            sql.append(" and w.COUNTER_SIGN_FLAG = :counterSignFlag");
        }
        if (map.containsKey("leader")) {
            sql.append(" and w.DEP_LEADER like '%" + map.get("leader") + "%'");
        }
        if (map.containsKey("medDept")) {
            sql.append(" and w.MEDI_UNIT like '%" + map.get("medDept") + "%'");
        }
        sql.append(" and w.DEL_FLAG = '0'");
        sql.append(" and w.STATUS = '4')");

        sql.append(" union all");

        //外行文
        sql.append(" select ''batchId, SUBJECTOUT_ID as batchOutId,to_char(UPDATE_TIME, 'MM月dd日') as updateTimeStr,CONMENTS_LEADER as conmentsLeader,REPORT_LEADER as reportLeader,DUTY_NAME as dutyName,SEQ as seq");
        sql.append(" from SCH_DUTY.PU_SUBJECT_REG d where d.SUBJECTOUT_ID in");
        sql.append(" (select ID as out from SCH_DUTY.PU_OUTSIDE_SUBJECT n where 1=1");
        if (map.containsKey("startDate")) {
            sql.append(" and to_char(n.SEND_TIME,'yyyy-MM-dd') >= :startDate");
        }
        if (map.containsKey("endDate")) {
            sql.append(" and to_char(n.SEND_TIME,'yyyy-MM-dd') <= :endDate");
        }
        if (map.containsKey("title")) {
            sql.append(" and n.TITLE like '%" + map.get("title") + "%'");
        }
        if (map.containsKey("counterSignFlag")) {
            sql.append(" and n.COUNTER_SIGN_FLAG = :counterSignFlag");
        }
        if(map.containsKey("medDept")){
            sql.append(" and n.MEDI_UNIT like '%"+map.get("medDept")+"%'");
        }
        if (map.containsKey("leader")) {
            sql.append(" and n.DEP_LEADER like '%" + map.get("leader") + "%'");
        }
        sql.append(" and n.DEL_FLAG = '0'");
        sql.append(" and n.STATUS = '4'))");
        sql.append(" as a");
        sql.append(" order by seq asc");

        List<RegisterBatchVo> list =findBySql(RegisterBatchVo.class,sql.toString(),map);
        return list;
    }

    /**
     * 历史流转记录跟踪使用
     * @param map
     * @return
     */
    public List<RegisterBatch> RegisterSearch(Map<String,Object> map){
        StringBuffer sql = new StringBuffer();

        sql.append("select TO_CHAR(UPDATE_TIME,'YYYY-MM-DD HH24:MI:SS') as updateTime,CONMENTS_LEADER as conmentsLeader,REPORT_LEADER as reportLeader,DUTY_NAME as dutyName");
        sql.append(" from SCH_DUTY.PU_SUBJECT_REG r where 1=1");
        if (map.containsKey("id")) {
            sql.append(" and r.SUBJECT_ID = :id");
            sql.append(" or r.SUBJECTOUT_ID = :id");
        }
        sql.append(" order by updateTime asc");
        List<RegisterBatch> list =findBySql(RegisterBatch.class,sql.toString(),map);
        return list;
    }

}
