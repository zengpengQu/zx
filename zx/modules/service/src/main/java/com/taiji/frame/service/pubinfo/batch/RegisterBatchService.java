package com.taiji.frame.service.pubinfo.batch;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.batch.RegisterBatch;
import com.taiji.frame.util.BaseDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *内行文流转登记
 * @author wsh
 * @date 2018/9/22
 *
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true,rollbackFor = Exception.class)
public class RegisterBatchService extends BaseDAO<RegisterBatch>{
    private static final Logger log = LoggerFactory.getLogger(RegisterBatchService.class);

    /**
     * 分页查询内行文流转登记刘表列表
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
        if (map.containsKey("orgName")) {
            hql.append(" and w.orgName like '%"+map.get("orgName")+"%'");
        }
        if(map.containsKey("reporter")){
            hql.append(" and w.reporter like '%"+map.get("reporter")+"%'");
        }
        hql.append(" and w.delFlag = '0'");
        hql.append(" and w.status = '3'");

        find(carrier, hql.toString(), map);
    }



}