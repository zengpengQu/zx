package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftInfo;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 礼品入库单管理
 * Created by xialiang on 2018/7/31.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class GiftPurchaseService extends BaseDAO<GiftInfo> {

    /**
     * 分页查询礼品库存列表
     */
    public void load(Carrier<GiftInfo> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from GiftInfo t where 1 = 1");
        if (map.containsKey("giftName")) {
            hql.append(" and t.giftName like :giftName");
        }
        if (map.containsKey("giftCode")) {
            hql.append(" and t.giftCode like :giftCode");
        }
        if (map.containsKey("giftType")) {
            hql.append(" and t.dicGiftType.id like :giftType");
        }

        hql.append(" and t.delFlag = '0' order by t.createTime desc ");

        find(carrier, hql.toString(), map);
    }

}
