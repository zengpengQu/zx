package com.taiji.frame.service.pubinfo.batch;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatchOut;
import com.taiji.frame.model.entity.pubinfo.batch.RegisterBatch;
import com.taiji.frame.model.entity.pubinfo.batch.RegisterBatchOut;
import com.taiji.frame.util.BaseDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 外行文流转登记
 * @author wsh
 * @date 2018/9/28
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true,rollbackFor = Exception.class)
public class RegisterBatchOutService extends BaseDAO<RegisterBatch> {
    private static final Logger log = LoggerFactory.getLogger(RegisterBatchOutService.class);

    /**
     * 分页查询外行文流转登记列表
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
        if (map.containsKey("deptName")) {
            hql.append(" and w.deptName like '%"+map.get("deptName")+"%'");
        }
        if(map.containsKey("contractor")){
            hql.append(" and w.contractor like '%"+map.get("contractor")+"%'");
        }

        hql.append(" and w.delFlag = '0'");
        hql.append(" and w.status = '3'");

        find(carrier, hql.toString(), map);
    }

}
