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
import java.util.List;

/**
 * @author xialiang
 * 礼品申请单表
 */
@Entity
@Table(name = "FA_MOG_APPLICATION_GIFT", schema = "SCH_DUTY")
public class GiftApplication extends IdEntity implements Jsonable, Serializable {
    private static final Logger logger = LoggerFactory.getLogger(GiftInfo.class);

    /**
     * 出访基本信息ID
     */
    @Setter
    @Getter
    public String abroadinfoId;

    /**
     * 来访基本信息
     */
    @Setter
    @Getter
    public String comeInfoId;

    /**
     * 出库单id
     */
    @Setter
    @Getter
    public String outboundId;

    /**
     * 出库状态
     */
    @Getter
    @Setter
    public String isOutbound;

    /**
     * 礼品申请单编码
     * */
    @Getter
    @Setter
    public String applicationCode;

    /**
     * 活动名称
     * */
    @Getter
    @Setter
    public String activityName;

    /**
     * 活动类型
     * */
    @Getter
    @Setter
    public String activityType;

    /**
     * 申请人
     * */
    @Getter
    @Setter
    public String applicationPerson;


    /**
     * 申请时间
     * */
    @Getter
    @Setter
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date applicationTime;

    /**
     * 申请事由
     * */
    @Getter
    @Setter
    public String applicationCause;


    /**
     * 申请状态
     * 已接收: 22
     * 未接收: 2201
     */
//    @Getter
//    @Setter
//    public String applicationState;

    @Setter
    public DicParam dicParam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "APPLICATION_STATE", referencedColumnName = "ID")
    public DicParam getDicParam() {
        if(dicParam != null) {
            try {
                dicParam.getName();
            } catch (Exception e) {
                logger.error("获取关联对象申请状态 DicParam dicParam 错误",e);
                return null;
            }
        }
        return dicParam;
    }


    /**
     * 联系方式
     * */
    @Getter
    @Setter
    public String contactWay;

    /**
     * 所属部门
     * */
    @Getter
    @Setter
    public String unitName;


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

    @Setter
    private List<GiftsApplication> giftsApplicationList;

//    @OneToMany(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "giftApplication", targetEntity = GiftsApplication.class)
    @Transient
    public List<GiftsApplication> getGiftsApplicationList() {
        return giftsApplicationList;
    }

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("abroadinfoId", abroadinfoId);
        jsonObject.put("comeInfoId", comeInfoId);
        jsonObject.put("applicationCode", applicationCode);
        jsonObject.put("activityName", activityName);
        jsonObject.put("activityType", activityType);
        jsonObject.put("applicationPerson", applicationPerson);
        jsonObject.put("applicationTime",  DateUtil.dateToString(applicationTime,DateUtil.FORMAT_DAY));
        jsonObject.put("applicationCause", applicationCause);
        jsonObject.put("applicationState", null == getDicParam() ? "" : getDicParam().getName());
        jsonObject.put("outboundId", outboundId);
        jsonObject.put("isOutbound", isOutbound);

        return jsonObject;
    }
}
