package com.taiji.frame.model.entity.foreignaffairs.gift;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
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
import java.util.Date;

/**
 * @author xialiang
 * @date:2018-08-07
 * @description:申请礼品清单信息表
 */
@Entity
@Table(name = "FA_MOG_APPLICATION_GIFTS", schema = "SCH_DUTY")
public class GiftsApplication extends IdEntity implements Jsonable, Serializable {
    private static final Logger logger = LoggerFactory.getLogger(GiftsApplication.class);


    /**
     * 礼品申请基本信息
     */
    @Setter
    public GiftApplication giftApplication;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER, targetEntity = GiftApplication.class)
    @JoinColumn(name = "APPLICATION_ID", referencedColumnName = "ID")
    public GiftApplication getGiftApplication() {
        if (giftApplication != null) {
            try {
                giftApplication.getId();
            } catch (Exception e) {
                logger.error("获取关联对象 GiftApplication giftApplication 错误", e);
                return null;
            }
        }
        return giftApplication;
    }

    @Getter
    @Setter
    public String giftInfoId;

    /**
     * 申请礼品名称
     * */
    @Getter
    @Setter
    public String giftName;

    /**
     * 申请礼品编码
     * */
    @Getter
    @Setter
    public String giftCode;


    /**
     * 礼品类型
     * */
    @Transient
    public String giftApplicationType;

    /**
     * 申请礼品类型
     * */
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
     * 申请礼品数量
     * */
    @Getter
    @Setter
    public Integer giftCount;

    /**
     * 申请礼品录入时间
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


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("giftCode", giftCode);
        jsonObject.put("giftName", giftName);
        jsonObject.put("giftApplicationType", giftApplicationType);
        jsonObject.put("giftType", null == getDicGiftType() ?"":getDicGiftType().getTypeName());
        jsonObject.put("giftCount", giftCount);
        jsonObject.put("giftInfoId", giftInfoId);
        jsonObject.put("createTime", DateUtil.dateToString(createTime,DateUtil.FORMAT_DAY));

        return jsonObject;
    }
}
