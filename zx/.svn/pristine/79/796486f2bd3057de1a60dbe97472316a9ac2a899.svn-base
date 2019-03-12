package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftShelves;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 货架管理
 * Created by xialiang on 2018/7/25.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class GiftShelvesService extends BaseDAO<GiftShelves> {

    /**
     * 分页查寻货架列表
     */
    public void load(Carrier<GiftShelves> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from GiftShelves t where 1 = 1");
        if (map.containsKey("frameCode")) {
            hql.append(" and t.frameCode like :frameCode");
        }
        if (map.containsKey("frameType")) {
            hql.append(" and t.dicGiftType.id like :frameType");
        }

        hql.append(" and t.delFlag = '0' order by t.purchaseTime desc ");

        find(carrier, hql.toString(), map);
    }


    public List<GiftShelves> getGiftShelvesByCode(String frameCode) {
        StringBuffer hql;
        if (StringUtils.isNotEmpty(frameCode)){
            hql = new StringBuffer(" from GiftShelves d where 1=1 and d.delFlag = '0' and d.frameCode = :frameCode");
        }else{
            hql = new StringBuffer(" from GiftShelves d where  1=1 and d.delFlag = '0'");
        }
        Map<String, Object> params = new HashMap<>(16);
        params.put("frameCode", frameCode);
        List<GiftShelves> giftShelvesList = find(hql.toString(), params);

        return giftShelvesList;
    }
}
