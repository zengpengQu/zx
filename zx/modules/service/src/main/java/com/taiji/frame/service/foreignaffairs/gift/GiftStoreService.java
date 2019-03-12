package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftInfo;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 礼品库存管理
 * Created by xialiang on 2018/7/30.
 * Updated by xialiag on 2018/8/21
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class GiftStoreService extends BaseDAO<GiftInfo> {

    /**
     * 分页查询礼品库存列表
     */
    public void load(Carrier<GiftInfo> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from GiftInfo t where 1 = 1");
        if (map.containsKey("giftName")) {
            hql.append(" and t.giftName like :giftName");
        }
        if (map.containsKey("giftOutOrInId")) {
            hql.append(" and t.giftOutOrIn.id like :giftOutOrInId");
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

    public List<GiftInfo> findByGiftCode(String giftCode){
        Map<String, Object> map = new HashMap<>(1);

        StringBuffer hql = new StringBuffer();
        hql.append("from GiftInfo t where 1 = 1");
        if (StringUtils.isNotEmpty(giftCode)) {
            hql.append(" and t.giftCode = :giftCode");
            map.put("giftCode", giftCode);
        }
        hql.append(" and t.delFlag = '0' order by t.createTime desc ");

        List<GiftInfo> giftInfoList = find(hql.toString(), map);

        return giftInfoList;
    }

    /**
     * 通过giftCode查询礼品库存信息
     * @param giftCode
     * @return
     */
    public GiftInfo findUniByGiftCode(String giftCode){
        Map<String, Object> map = new HashMap<>(1);
        map.put("giftCode", giftCode);
        StringBuffer hql = new StringBuffer("from GiftInfo g where 1 = 1");
        hql.append(" and g.giftCode = :giftCode");
        hql.append(" and g.delFlag = '0'");

        GiftInfo  giftInfo = findUnique(hql.toString(), map);
        return giftInfo;
    }
}
