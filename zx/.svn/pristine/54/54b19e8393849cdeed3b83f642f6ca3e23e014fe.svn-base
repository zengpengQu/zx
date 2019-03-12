package com.taiji.frame.service.pubinfo.batch;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatchOut;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @author admin
 * 呈批件起草
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class SubmitBatchOutService extends BaseDAO<DraftBatchOut> {

    /**
     * 分页查询外行文列表,默认只加载当天
     */
    public void load(Carrier<DraftBatchOut> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from DraftBatchOut w where 1 = 1");
        if (map.containsKey("startDateWai")) {
            hql.append(" and to_char(w.sendTime,'yyyy-MM-dd') >= :startDateWai");
        }
        if(map.containsKey("endDateWai")){
            hql.append(" and to_char(w.sendTime,'yyyy-MM-dd') <= :endDateWai");
        }
        if(map.containsKey("title")){
            hql.append(" and w.title like '%"+map.get("title")+"%'");
        }
        if (map.containsKey("orgId")) {
            hql.append(" and w.orgDept.id = :orgId");
        }
        if (map.containsKey("statuss")) {
            hql.append(" and w.status >= :statuss");
        }
        if(map.containsKey("reporterWai")){
            hql.append(" and w.reporter like '%"+map.get("reporterWai")+"%'");
        }
        if(map.containsKey("batchDraftEditIndexMainIdWai")){
            hql.append(" and w.id = :batchDraftEditIndexMainIdWai");
        }

        hql.append(" and w.delFlag = '0'");

        find(carrier, hql.toString(), map);
    }

    /**
     * 孙毅添加 首页外行文数据显示
     */
    public List<DraftBatchOut> loadIndexMain(DicUser dicUser,String batch) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from DraftBatchOut w where 1 = 1");
        if("79_9".equals(batch)){
            hql.append(" and w.status = '2' ");
        }else {
            hql.append(" and w.status = '0' or  w.status = '1' and w.dicDept.id = '"+dicUser.getDicDept().getId()+"'");
        }
        hql.append(" and w.status != '4'");
        hql.append(" and w.delFlag = '0'");

        return find(hql.toString());
    }

    /**
     * 用于返回一个数据库流水号字段的最值
     * @return
     */
    public Integer findNumberWai(){
        String sql = "select max(SER_NUMBER) as number from SCH_DUTY.PU_OUTSIDE_SUBJECT";
        return executeSql(sql,null);
    }

}
