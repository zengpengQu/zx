package com.taiji.frame.model.entity.inspection.place;

import com.fasterxml.jackson.annotation.JsonFormat;
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
 * @author sy
 * 活动安排表
 */
@Entity
@Table(name = "IN_DATE_TYPE", schema = "SCH_DUTY")
public class DateType extends IdEntity implements Jsonable, Serializable {

    /**
     * 日期类型
     */
    @Getter
    @Setter
    public String dateType;

    /**
     * 开始时间
     */
    @Setter
    public Date beginTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBeginTime() {
        return beginTime;
    }
    /**
     * 结束时间
     */
    @Setter
    public Date endTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getEndTime() {
        return endTime;
    }

    /**
     * 地点
     */
    @Setter
    public District place;
    @ManyToOne(fetch = FetchType.LAZY,targetEntity = District.class)
    @JoinColumn(name = "PLACE", referencedColumnName = "ID")
    public District getPlace() {
        return place;
    }

    /**
     * 特殊地点
     */
    @Getter
    @Setter
    public String specialPlace;
    /**
     * 活动安排ID
     */
    @Setter
    public Place placeId;
    @ManyToOne(fetch = FetchType.LAZY,targetEntity = Place.class)
    @JoinColumn(name = "PLACE_ID", referencedColumnName = "ID")
    public Place getPlaceId() {
        return placeId;
    }

    /**
     * 删除标志 0未删除
     */
    @Getter
    @Setter
    public String delFlag;

    /**
     * 是否存在冲突
     * 1，同意时间地点冲突
     */
    @Getter
    @Setter
    public String isClash;
    /**
     * 2，一省一月内安排多与3个
     */
    @Setter
    @Getter
    public String isClashDay;
    /**
     * 3，一省一年内安排多与六个
     */
    @Setter
    @Getter
    public String isClashYear;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("placeId", placeId.getId());
        jsonObject.put("actTypeName", placeId.getActTypeId());
        jsonObject.put("dicDeptName", placeId.getDicDept().getDeptName());
        jsonObject.put("title", placeId.getTitle());
        jsonObject.put("dateType", dateType);
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("beginTime",  DateUtil.dateToString(beginTime, DateUtil.FORMAT_DAY_CN));
        jsonObject.put("beginTimeStr",  DateUtil.dateToString(beginTime, DateUtil.FORMAT_DAY));
        jsonObject.put("endTime", DateUtil.dateToString(endTime, DateUtil.FORMAT_DAY));
        jsonObject.put("place", place.getDistrictName());
        jsonObject.put("placeDistrictId", place.getId());

        String beginTimeStr = DateUtil.dateToString(beginTime,DateUtil.FORMAT_DAY_CN);
        String endTimeStr = DateUtil.dateToString(endTime,DateUtil.FORMAT_DAY_CN);
        String endTimeStr1 = "";
        if(beginTimeStr.equals(endTimeStr)){
            endTimeStr1=beginTimeStr;
        }else {
            endTimeStr1=beginTimeStr+" 至 "+endTimeStr;
        }
        jsonObject.put("dataTime",endTimeStr1);
        jsonObject.put("notes", placeId.getNotes());
        jsonObject.put("status", placeId.getReportState());
        jsonObject.put("nowTime", placeId.getNowTime());
        jsonObject.put("feedbackId", placeId.feedback== null ? "" :placeId.getFeedback().getId());
        jsonObject.put("specialPlace", specialPlace);
        return jsonObject;
    }
}
