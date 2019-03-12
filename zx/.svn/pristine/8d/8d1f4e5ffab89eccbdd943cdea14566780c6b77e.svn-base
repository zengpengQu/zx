package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftOutOrInRecords;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 礼品库存管理
 * Created by xialiang on 2018/7/30.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class GiftOutOrInRecordsService extends BaseDAO<GiftOutOrInRecords> {

    /**
     * 分页查询礼品库存列表
     */
    public void load(Carrier<GiftOutOrInRecords> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from GiftOutOrInRecords t where 1 = 1");
        if (map.containsKey("giftOutOrInId")) {
            hql.append(" and t.giftOutOrIn.id = :giftOutOrInId");
        }

        hql.append(" and t.delFlag = '0' order by t.createTime desc ");

        find(carrier, hql.toString(), map);
    }


    /**
     * 按照入库单信息主键查询已入库的礼品清单信息
     * @param giftOutOrInId
     */
  public List<GiftOutOrInRecords> searchGiftOutOrInRecords(String giftOutOrInId){
      Map<String, Object> map = new HashMap<>(1);
      map.put("giftOutOrInId", giftOutOrInId);

      StringBuffer hql = new StringBuffer();
      hql.append("from GiftOutOrInRecords t where 1 = 1");
      hql.append(" and t.giftOutOrIn.id= :giftOutOrInId");
      hql.append(" and t.delFlag = '0' order by t.createTime desc ");
      List<GiftOutOrInRecords> giftOutOrInRecords = find(hql.toString(), map);

      return giftOutOrInRecords;
  }

}
