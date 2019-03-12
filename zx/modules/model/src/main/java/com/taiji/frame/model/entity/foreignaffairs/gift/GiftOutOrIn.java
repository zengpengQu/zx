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
import java.util.List;

/**
 * @author xialiang
 * 礼品出库/入库信息表
 */
@Entity
@Table(name = "FA_MOG_OUTGIFT", schema = "SCH_DUTY")
public class GiftOutOrIn extends IdEntity implements Jsonable, Serializable {
    private static final Logger logger = LoggerFactory.getLogger(GiftOutOrIn.class);

    /**
     * 申请人
     * */
    @Getter
    @Setter
    public String applicationPerson;

    /**
     * 是否已出库.已入库\未出库\未入库
     * 未入库：20
     * 已入库：2001
     * 未出库：21
     * 已出库：2101
     * */
//    @Getter
//    @Setter
//    public String isOutbound;

    @Setter
    public DicParam dicParam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "IS_OUTBOUND", referencedColumnName = "ID")
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
     * 出/入库礼品明细
     * */
    @Setter
    private List<GiftInfo> inOrOutGiftsList;

    @Transient
    public List<GiftInfo> getInOrOutGiftsList() {
        return inOrOutGiftsList;
    }


    /**
     * 活动类型
     * */
    @Getter
    @Setter
    public String activityType;

    /**
     * 活动名称
     * */
    @Getter
    @Setter
    public String activityName;

    /**
     * 出库/入库编码
     * */
    @Getter
    @Setter
    public String outboundCode;

    /**
     * 出库/入库时间
     * */
    @Getter
    @Setter
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date outboundTime;

    /**
     * 申请时间
     * */
    @Getter
    @Setter
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date applicationTime;

    /**
     * 经办人
     * */
    @Getter
    @Setter
    public String transactor;


    /**
     * 出入库状态标识
     * 入库：0
     * 出库：1
     * */
    @Getter
    @Setter
    public String outOrInFlag;

    /**
     * 创建时间
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
        jsonObject.put("applicationPerson", applicationPerson);
        jsonObject.put("isOutbound", null == getDicParam() ? "" : getDicParam().getName());
        jsonObject.put("activityType", activityType);
        jsonObject.put("activityName", activityName);
        jsonObject.put("transactor", transactor);
        jsonObject.put("outboundCode", outboundCode);
        jsonObject.put("applicationTime", DateUtil.dateToString(applicationTime,DateUtil.FORMAT_DAY));
        jsonObject.put("outboundTime", DateUtil.dateToString(outboundTime,DateUtil.FORMAT_DAY));

        return jsonObject;
    }
}
