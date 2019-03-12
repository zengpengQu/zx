package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftOutOrIn;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 礼品出入库记录基本信息
 * Created by xialiang on 2018/8/14.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class GiftOutOrInService extends BaseDAO<GiftOutOrIn> {

    /**
     * 分页查询礼品库存列表
     */
    public void load(Carrier<GiftOutOrIn> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from GiftOutOrIn t where 1 = 1");
        if (map.containsKey("giftOutOrInId")) {
            hql.append(" and t.giftOutOrIn.id like :giftOutOrInId");
        }

        hql.append(" and t.delFlag = '0' order by t.createTime desc ");

        find(carrier, hql.toString(), map);
    }

}
