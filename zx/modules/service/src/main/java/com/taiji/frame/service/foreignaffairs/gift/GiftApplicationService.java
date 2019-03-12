package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftApplication;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 *
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class GiftApplicationService extends BaseDAO<GiftApplication> {
    /**
     * 分页查询礼品库存列表
     */
    public void load(Carrier<GiftApplication> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from GiftApplication t where 1 = 1");
        if (map.containsKey("applicationPerson")) {
            hql.append(" and t.applicationPerson like :applicationPerson");
        }
        if (map.containsKey("activityName")) {
            hql.append(" and t.activityName like :activityName");
        }
        if(map.containsKey("startTime")){
            hql.append(" and to_char(t.applicationTime,'yyyy-MM-dd') >=:startTime");
        }
        if(map.containsKey("endTime")){
            hql.append(" and to_char(t.applicationTime,'yyyy-MM-dd') <=:endTime");
        }

        // 来访礼品申请
        if (map.containsKey("comeInfoId")) {
            hql.append(" and t.comeInfoId = :comeInfoId");
        }

        hql.append(" and t.delFlag = '0' order by t.dicParam.id desc,t.applicationTime desc ");

        find(carrier, hql.toString(), map);
    }

    public GiftApplication findByOutboundId(String outboundId) {
        Map<String, Object> map = new HashMap<>(1);
        map.put("outboundId", outboundId);
        StringBuffer hql = new StringBuffer("from GiftApplication g where 1 = 1");
        hql.append(" and g.outboundId = :outboundId");
        hql.append(" and g.delFlag = '0'");

        GiftApplication  giftApplication = findUnique(hql.toString(), map);
        return giftApplication;
    }
}
