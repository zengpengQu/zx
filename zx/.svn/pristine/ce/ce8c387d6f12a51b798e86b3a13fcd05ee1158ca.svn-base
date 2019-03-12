package com.taiji.frame.model.entity.foreignaffairs.abroad;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.constants.ShippingSpace;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author BT4900
 */
@Entity
@Table(name = "FA_OAM_AIRPLANE" , schema = "SCH_DUTY")
public class AbroadAirplane extends IdEntity implements Jsonable, Serializable {

    /**
     *
     * 出访信息ID
     *
     */
    @Setter
    public AbroadInfo abroadInfo;
    @ManyToOne(fetch = FetchType.LAZY , targetEntity = AbroadInfo.class)
    @JoinColumn(name = "ABROADINFO_ID" , referencedColumnName = "ID")
    public AbroadInfo getAbroadInfo() {
        if(abroadInfo != null)
        {
            try {
                abroadInfo.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return abroadInfo;
    }

    /**
     *
     * 航班号
     *
     */
    @Setter
    @Getter
    public String flightNo;

    /**
     *
     * 启程地
     *
     */
    @Setter
    @Getter
    public String fromName;

    /**
     *
     * 目的地
     *
     */
    @Setter
    @Getter
    public String toName;

    /**
     *
     * 机型
     *
     */
    @Setter
    @Getter
    public String airModel;

    /**
     *
     * 舱位 0：头等舱 1：公务舱 2：经济舱
     *
     */
    @Setter
    @Getter
    public String shippingChoose;

    /**
     *
     * 飞行时间
     *
     */
    @Setter
    @Getter
    public String timeFlight;

    /**
     *
     * 备注信息
     *
     */
    @Setter
    @Getter
    public String noteInfo;

    /**
     *
     * 创建时间
     *
     */
    @Setter
    public Date createTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     *
     * 更新时间
     *
     */
    @Setter
    public Date updateTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    public String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id" , id);
        jsonObject.put("abroadInfoId" , getAbroadInfo()==null ? "" : getAbroadInfo().getId());
        jsonObject.put("flightNo" , flightNo);
        jsonObject.put("fromName" , fromName);
        jsonObject.put("toName" , toName);
        jsonObject.put("airModel" , airModel);
        jsonObject.put("timeFlight" , timeFlight);
        jsonObject.put("shippingChoose" , shippingChoose);
        String shippingChooseName = "";
        if(shippingChoose!=null) {
            if (ShippingSpace.FIRST_CLASS.value().equals(shippingChoose)) {
                shippingChooseName = "头等舱";
            } else if (ShippingSpace.BUSINESS_CLASS.value().equals(shippingChoose)) {
                shippingChooseName = "公务舱";
            } else if (ShippingSpace.ECONOMY_CLASS.value().equals(shippingChoose)) {
                shippingChooseName = "经济舱";
            } else if (ShippingSpace.CHARTER_FLIGHT.value().equals(shippingChoose)) {
                shippingChooseName = "包机";
            }
        }
        jsonObject.put("shippingChooseName" , shippingChooseName);
        jsonObject.put("noteInfo" , noteInfo);
        jsonObject.put("createTimeStr" , createTime==null ? "" : DateUtil.dateToString(createTime , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("updateTimeStr" , updateTime==null ? "" : DateUtil.dateToString(updateTime , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("delFlag", delFlag);
        return jsonObject;
    }


}
