package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftOutOrIn;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 礼品出库单管理
 * Created by xialiang on 2018/7/31.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class GiftOutboundService extends BaseDAO<GiftOutOrIn> {

    /**
     * 分页查询礼品出库列表
     */
    public void load(Carrier<GiftOutOrIn> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from GiftOutOrIn t where 1 = 1");
        if (map.containsKey("activityName")) {
            hql.append(" and t.activityName like :activityName");
        }
        if (map.containsKey("applicationPerson")) {
            hql.append(" and t.applicationPerson like :applicationPerson");
        }
        if(map.containsKey("startTime")){
            hql.append(" and to_char(t.applicationTime,'yyyy-MM-dd') >=:startTime");
        }
        if(map.containsKey("endTime")){
            hql.append(" and to_char(t.applicationTime,'yyyy-MM-dd') <=:endTime");
        }
        if(map.containsKey("outOrInFlag")){
            hql.append(" and t.outOrInFlag like :outOrInFlag");
        }

        hql.append(" and t.delFlag = '0'  order by t.dicParam.seq asc,t.applicationTime desc ");

        find(carrier, hql.toString(), map);
    }

}
