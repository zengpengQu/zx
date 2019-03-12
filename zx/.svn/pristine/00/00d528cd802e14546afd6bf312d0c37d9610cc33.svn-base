package com.taiji.frame.service.pubinfo.batch;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author admin
 * 呈批件报送
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class SubmitBatchService extends BaseDAO<DraftBatch> {




    /**
     * 分页查询内行文列表,默认只加载当天
     */
    public void load(Carrier<DraftBatch> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from DraftBatch w where 1 = 1");
        if (map.containsKey("startDate")) {
            hql.append(" and to_char(w.sendTime,'yyyy-MM-dd') >= :startDate");
        }
        if(map.containsKey("endDate")){
            hql.append(" and to_char(w.sendTime,'yyyy-MM-dd') <= :endDate");
        }
        if(map.containsKey("title")){
            hql.append(" and w.title like '%"+map.get("title")+"%'");
        }
        if (map.containsKey("deptId")) {
            hql.append(" and w.dicDept.id = :deptId");
        }
        if (map.containsKey("statuss")) {
            hql.append(" and w.status >= :statuss");
        }
        //暂时已作废
        if(map.containsKey("reporter")){
            hql.append(" and w.reporter like '%"+map.get("reporter")+"%'");
        }
        //孙毅添加 根据ID查询单条数据
        if(map.containsKey("indexMainBachIdNei")){
            hql.append(" and w.id = :indexMainBachIdNei");
        }
        hql.append(" and w.delFlag = '0'");

        find(carrier, hql.toString(), map);
    }



    /**
     * 孙毅添加
     * 分页查询内行文列表,
     */
    public List<DraftBatch> loadIndexMainService(DicUser dicUser, String batch) {
        StringBuffer hql = new StringBuffer();

        hql.append(" from DraftBatch w where 1 = 1");
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
     * 查询使用
     * @param startDate
     * @param endDate
     * @param title
     * @param counterSignUnit
     * @param reporter
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public List<DraftBatch> findList(String startDate, String endDate, String title, String counterSignUnit,String reporter) {
        Map<String, Object> map = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from DraftBatch db where 1 = 1");
        if (StringUtils.isNotEmpty(title)){
            hql.append(" and db.title like :title");
            map.put("title","%" + title.trim() + "%");
        }
        if (StringUtils.isNotEmpty(counterSignUnit)){
            hql.append(" and db.counterSignUnit like :counterSignUnit");
            map.put("counterSignUnit","%" + counterSignUnit + "%");
        }
        if (StringUtils.isNotEmpty(reporter)){
            hql.append(" and db.reporter like :reporter");
            map.put("reporter","%" + reporter + "%");
        }
        if (StringUtils.isNotEmpty(startDate) && StringUtils.isNotEmpty(endDate)) {
            hql.append(" and db.sendTime between to_date(:startDate, 'YYYY-MM-DD') and to_date(:endDate, 'YYYY-MM-DD')");
            map.put("startDate", startDate);
        }
        hql.append(" and db.delFlag = '0' order by db.updateTime desc ");
        List<DraftBatch> list = find(hql.toString(),map);
        return list;
    }

    /**
     * 用于返回一个数据库流水号字段的最值
     * @return
     */
    public Integer findNumber(){
        String sql = "select max(SER_NUMBER) as number from SCH_DUTY.PU_INSIDE_SUBJECT";
        return executeSql(sql,null);
    }
}
