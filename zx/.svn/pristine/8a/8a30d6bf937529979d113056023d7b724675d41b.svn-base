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
import java.util.Date;

/**
 * @author pengyx
 * 礼品架信息表
 */
@Entity
@Table(name = "FA_MOG_FRAMEGM", schema = "SCH_DUTY")
public class GiftShelves extends IdEntity implements Jsonable, Serializable {
    private static final Logger logger = LoggerFactory.getLogger(GiftShelves.class);

    /**
     * 礼品架编码
     * */
    @Getter
    @Setter
    public String frameCode;

    /**
     * 礼品架名称
     * */
    @Getter
    @Setter
    public String frameName;

    /**
     * 礼品架类型
     * */
//    @Getter
//    @Setter
//    public String frameType;
    @Setter
    public DicGiftType dicGiftType;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicGiftType.class)
    @JoinColumn(name = "FRAME_TYPE",referencedColumnName ="ID" )
    public DicGiftType getDicGiftType() {
        if(null != dicGiftType){
            dicGiftType.getTypeName();
        }
        return dicGiftType;
    }

    //    /**
//     * 礼品架状态
//     * */
//    @Getter
//    @Setter
//    public String frameState;

    /**
     * 使用状态
     */
    @Setter
    public DicParam dicParam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "FRAME_STATE", referencedColumnName = "ID")
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
     * 礼品架位置
     * */
    @Getter
    @Setter
    public String framePosition;

    /**
     * 礼品架规格
     * */
    @Getter
    @Setter
    public String frameFormat;

    /**
     * 礼品架承重量
     * */
    @Getter
    @Setter
    public String frameBearing;

    /**
     * 礼品架说明
     * */
    @Getter
    @Setter
    public String frameInstruction;

    /**
     * 礼品架经办人
     * */
    @Getter
    @Setter
    public String frameAgent;

    /**
     * 礼品架购置时间
     * */
    @Getter
    @Setter
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date purchaseTime;

    /**
     * 礼品录入时间
     * */
    @Getter
    @Setter
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
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
        jsonObject.put("frameCode", frameCode);
        jsonObject.put("frameName", frameName);
//        jsonObject.put("frameType", frameType);
        jsonObject.put("purchaseTime", DateUtil.dateToString(purchaseTime,DateUtil.FORMAT_DAY));
        jsonObject.put("frameFormat", frameFormat);
        jsonObject.put("frameBearing", frameBearing);
        jsonObject.put("frameAgent", frameAgent);
        jsonObject.put("frameState", null == getDicParam() ? "" : getDicParam().getName());
        jsonObject.put("frameType", null == getDicGiftType() ? "" : getDicGiftType().getTypeName());
        jsonObject.put("frameInstruction", frameInstruction);
        return jsonObject;
    }
}
