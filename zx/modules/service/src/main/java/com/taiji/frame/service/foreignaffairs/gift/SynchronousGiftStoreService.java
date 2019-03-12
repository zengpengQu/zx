package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.model.entity.foreignaffairs.gift.DicGiftType;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftInfo;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftOutOrInRecords;
import com.taiji.frame.model.entity.foreignaffairs.gift.GiftShelves;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 出库、入库礼品清单信息与礼品库存同步服务类
 */
@Service
//@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class SynchronousGiftStoreService extends BaseDAO<GiftInfo> {
    private static final Logger LOG = LoggerFactory.getLogger(SynchronousGiftStoreService.class);

    @Autowired
    private GiftOutOrInRecordsService giftOutOrInRecordsService;

    @Autowired
    private GiftStoreService giftStoreService;

    /**
     * 礼品入库同步方法
     * @param giftOutOrInId 入库单基本信息id
     */
    @Transactional(rollbackFor = Exception.class)
    public void giftPurchaseToStore(String giftOutOrInId){
        List<GiftOutOrInRecords> giftOutOrInRecords = giftOutOrInRecordsService.searchGiftOutOrInRecords(giftOutOrInId);

        if(null != giftOutOrInRecords && giftOutOrInRecords.size() > 0){
            for (GiftOutOrInRecords giftOutOrInRecord: giftOutOrInRecords) {
                String giftName = giftOutOrInRecord.getGiftName();
                DicGiftType dicGiftType = giftOutOrInRecord.getDicGiftType();
                Integer giftCount = giftOutOrInRecord.getGiftCount();
                BigDecimal giftPrice = giftOutOrInRecord.getGiftPrice();
                GiftShelves giftShelves = giftOutOrInRecord.getGiftShelves();
                String giftCode = giftOutOrInRecord.getGiftCode();
                String transactor = giftOutOrInRecord.getGiftOutOrIn().getTransactor();
                Date outboundTime = giftOutOrInRecord.getGiftOutOrIn().getOutboundTime();

                if(StringUtils.isNotEmpty(giftCode)){
                    GiftInfo giftInfo = giftStoreService.findUniByGiftCode(giftCode);
                    //更新礼品库存信息
                    if(null != giftInfo){
                        giftInfo.setGiftName(giftName);
                        giftInfo.setDicGiftType(dicGiftType);
                        giftInfo.setGiftCount(giftInfo.getGiftCount() + giftCount);
                        giftInfo.setGiftPrice(giftPrice);
                        giftInfo.setGiftShelves(giftShelves);
                        giftInfo.setCreateName(transactor);
                        giftInfo.setCreateTime(outboundTime);
                    }else {
                        //新增礼品库存信息
                        try {
                            giftInfo = GiftInfo.class.newInstance();
                        } catch (InstantiationException e) {
                            e.printStackTrace();
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        } finally {
                        }
                        giftInfo.setGiftCode(giftCode);
                        giftInfo.setGiftName(giftName);
                        giftInfo.setDicGiftType(dicGiftType);
                        giftInfo.setGiftCount(giftCount);
                        giftInfo.setGiftPrice(giftPrice);
                        giftInfo.setGiftShelves(giftShelves);
                        giftInfo.setCreateName(transactor);
                        giftInfo.setCreateTime(outboundTime);
                        giftInfo.setDicParam(null);

                        giftInfo.setDelFlag("0");
                        giftInfo.setUpdateTime(new Date());
                    }
                    save(giftInfo);
                }
            }
        }
    }

    /**
     * 礼品出库同步方法
     * @param giftOutOrInId
     */
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> giftOutboundToStore(String giftOutOrInId){
        Map<String, Object> msgMap = new HashMap<>(2);
        StringBuilder buffer1 = new StringBuilder();
        StringBuilder buffer2 = new StringBuilder();
        StringBuilder buffer = new StringBuilder();
        String outboundMsg1;
        String outboundMsg2;
        //是否同步，false不同步；true同步。
        boolean synchronousFlag = false;

        List<GiftOutOrInRecords> giftOutOrInRecords = giftOutOrInRecordsService.searchGiftOutOrInRecords(giftOutOrInId);
        if(null != giftOutOrInRecords && giftOutOrInRecords.size() > 0){
            for (GiftOutOrInRecords giftOutOrInRecord: giftOutOrInRecords) {
                String giftCode = giftOutOrInRecord.getGiftCode();
                String giftName = giftOutOrInRecord.getGiftName();
                Integer giftCount = giftOutOrInRecord.getGiftCount();

                if(StringUtils.isNotEmpty(giftCode)) {
                    GiftInfo giftInfo = giftStoreService.findUniByGiftCode(giftCode);
                    //更新礼品库存信息
                    if (null != giftInfo) {
                        Integer diff = giftInfo.getGiftCount() - giftCount;

                        if (diff >= 0) {
                            synchronousFlag = true;
                            outboundMsg1 = "可以出库的礼品编码--"+ giftCode + "；礼品名称为--" + giftName + "\n";
                            buffer1.append(outboundMsg1);
                        } else {
                            synchronousFlag = false;
                            outboundMsg2 = "礼品" + giftName + "库存不足，当前库存为: " + giftInfo.getGiftCount() + "\n";
                            buffer2.append(outboundMsg2);
                        }
                    }
                }
            }
            buffer.append(synchronousFlag);
            if(buffer.toString().contains("false")){
                msgMap.put("synchronousFlag", false);
                msgMap.put("buffer", buffer2.toString());
            }else{
                msgMap.put("synchronousFlag", true);
                msgMap.put("buffer", buffer1.toString());
            }
        } else {
            msgMap.put("synchronousFlag", false);
            msgMap.put("buffer", "empty");
        }

        return msgMap;
    }

    /**
     * 出库礼品保存
     * @param giftOutOrInRecords
     */
    @Transactional(rollbackFor = Exception.class)
    public void outboundGiftSave(List<GiftOutOrInRecords> giftOutOrInRecords){
        if(null != giftOutOrInRecords && giftOutOrInRecords.size() > 0){
            for (GiftOutOrInRecords giftOutOrInRecord: giftOutOrInRecords) {
                String giftName = giftOutOrInRecord.getGiftName();
                DicGiftType dicGiftType = giftOutOrInRecord.getDicGiftType();
                Integer giftCount = giftOutOrInRecord.getGiftCount();
                BigDecimal giftPrice = giftOutOrInRecord.getGiftPrice();
                GiftShelves giftShelves = giftOutOrInRecord.getGiftShelves();
                String giftCode = giftOutOrInRecord.getGiftCode();
                String transactor = giftOutOrInRecord.getGiftOutOrIn().getTransactor();
                Date outboundTime = giftOutOrInRecord.getGiftOutOrIn().getOutboundTime();

                if(StringUtils.isNotEmpty(giftCode)){
                    GiftInfo giftInfo = giftStoreService.findUniByGiftCode(giftCode);
                    if(null != giftInfo){//更新礼品库存信息
                        Integer diffierenceValue = giftInfo.getGiftCount() - giftCount;
                        if(diffierenceValue >=0) {
                            giftInfo.setGiftName(giftName);
                            giftInfo.setDicGiftType(dicGiftType);
                            giftInfo.setGiftCount(diffierenceValue);
                            giftInfo.setGiftPrice(giftPrice);
                            giftInfo.setGiftShelves(giftShelves);
                            giftInfo.setCreateName(transactor);
                            giftInfo.setCreateTime(outboundTime);
                            save(giftInfo);
                        }
                    }
                }
            }
        }
    }


}
