package com.taiji.frame.model.entity.foreignaffairs.gift;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author pengyx
 * 礼品出入库单记录信息表
 */
@Entity
@Table(name = "FA_MOG_GIFT_OUTORIN_RECORDS", schema = "SCH_DUTY")
public class GiftOutOrInRecords extends IdEntity implements Jsonable, Serializable {
    private static final Logger logger = LoggerFactory.getLogger(GiftOutOrInRecords.class);

    /**
     * 礼品名称
     * */
    @Getter
    @Setter
    public String giftName;

    /**
     * 礼品单价
     * */
    @Getter
    @Setter
    public BigDecimal giftPrice;

    /**
     * 礼品编码
     * */
    @Getter
    @Setter
    public String giftCode;

    /**
     * 礼品类型
     * */
//    @Getter
//    @Setter
//    public String giftType;

    @Setter
    public DicGiftType dicGiftType;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicGiftType.class)
    @JoinColumn(name = "GIFT_TYPE", referencedColumnName = "ID")
    public DicGiftType getDicGiftType() {
        if(dicGiftType != null) {
            try {
                dicGiftType.getTypeName();
            } catch (Exception e) {
                logger.error("获取关联对象 DicParam dicParam 错误",e);
                return null;
            }
        }
        return dicGiftType;
    }
    /**
     * 所属礼品架
     * */
//    @Getter
//    @Setter
//    public String giftFrame;

    @Setter
    public  GiftShelves giftShelves;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = GiftShelves.class)
    @JoinColumn(name = "GIFT_FRAME", referencedColumnName = "ID")
    public GiftShelves getGiftShelves() {
        if(giftShelves != null) {
            try {
                giftShelves.getFrameName();
            } catch (Exception e) {
                logger.error("获取关联对象 GiftShelves giftShelves 错误",e);
                return null;
            }
        }
        return giftShelves;
    }


    /**
     * 礼品数量
     * */
    @Getter
    @Setter
    public Integer giftCount;

    /**
     * 礼品说明
     * */
    @Getter
    @Setter
    public String giftInstruction;

    /**
     * 礼品状态
     * */
//    @Getter
//    @Setter
//    public String giftState;

    @Setter
    public DicParam dicParam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "GIFT_STATE", referencedColumnName = "ID")
    public DicParam getDicParam() {
        if(dicParam != null) {
            try {
                dicParam.getName();
            } catch (Exception e) {
                logger.error("获取关联对象 DicParam dicParam 错误",e);
                return null;
            }
        }
        return dicParam;
    }

    /**
     * 礼品录入人
     * */
    @Getter
    @Setter
    public String createName;

    /**
     * 礼品录入时间
     * */
    @Getter
    @Setter
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date createTime;

    /**
     * 最后更新时间
     * */
    @Getter
    @Setter
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date updateTime;

    /**
     * 删除标志
     * */
    @Getter
    @Setter
    public String delFlag;

    /**
     * 礼品出入库基本信息表
     */
    @Setter
    public GiftOutOrIn giftOutOrIn;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER, targetEntity = GiftOutOrIn.class)
    @JoinColumn(name = "OUTGIFT_ID" , referencedColumnName = "ID")
    public GiftOutOrIn getGiftOutOrIn() {
        if(giftOutOrIn != null){
            try {
                giftOutOrIn.getId();
            } catch (Exception e) {
                logger.error("获取关联对象 GiftOutOrIn giftOutOrIn 错误", e);
                e.printStackTrace();
                return  null;
            }
        }
        return giftOutOrIn;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("giftName", giftName);
        jsonObject.put("giftCode", giftCode);
        jsonObject.put("giftCount", giftCount.toString());
        jsonObject.put("giftPrice", giftPrice);
        jsonObject.put("giftType", null == getDicGiftType() ?"":getDicGiftType().getTypeName());
        jsonObject.put("createName", createName);
        jsonObject.put("createTime", DateUtil.dateToString(createTime,DateUtil.FORMAT_DAY));
        jsonObject.put("giftState", null == getDicParam() ? "" : getDicParam().getName());
        jsonObject.put("giftInstruction", giftInstruction);
        jsonObject.put("giftFrame", null == getGiftShelves() ? "" : getGiftShelves().getFrameCode());

        return jsonObject;
    }
}
