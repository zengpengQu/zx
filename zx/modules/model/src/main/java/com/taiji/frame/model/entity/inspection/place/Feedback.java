package com.taiji.frame.model.entity.inspection.place;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
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
 * 视察考察调研反馈
 */
@Entity
@Table(name = "IN_ACT_FEEDBACK", schema = "SCH_DUTY")
public class Feedback extends IdEntity implements Jsonable, Serializable {


    /**
     * 活动安排ID
     */
    @Setter
    public Place place;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = Place.class)
    @JoinColumn(name = "ACT_ID", referencedColumnName = "ID")
    public Place getPlace() {
        return place;
    }
    /**
     * 反馈部门Id
     */
    @Setter
    public DicDept dicDept;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {
        return dicDept;
    }
    /**
     * 反馈部门name
     */
    @Setter
    @Getter
    public String orgName;
    /**
     * 反馈人name
     */
    @Getter
    @Setter
    public String feedbackMan;

    /**
     * 反馈时间
     */
    @Setter
    public Date feedbackTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getFeedbackTime() {
        return feedbackTime;
    }

    /**
     * 率队领导
     */
    @Getter
    @Setter
    public String teamLeader;
    /**
     * 团队规模
     */
    @Getter
    @Setter
    public String groupScale;

    /**
     * 组织形式
     */
    @Getter
    @Setter
    public String orgType;

    /**
     * 实际开始时间
     */
    @Setter
    public Date actualBeginTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getActualBeginTime() {
        return actualBeginTime;
    }

    /**
     * 实际结束时间
     */
    @Setter
    public Date actualEndTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getActualEndTime() {
        return actualEndTime;
    }

    /**
     * 实际地点
     */
    @Getter
    @Setter
    public String actualPlace;
    /**
     * 调整原因
     */
    @Getter
    @Setter
    public String adjustmentReason;
    /**
     * 备注
     */
    @Getter
    @Setter
    public String notes;
    /**
     * 反馈状态
     * 0：未反馈，1：已反馈
     */
    @Getter
    @Setter
    public String feedbackFlag;
    /**
     * 经办人
     */
    @Getter
    @Setter
    public String agentName;
    /**
     * 经办人电话
     */
    @Getter
    @Setter
    public String agentMobile;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("feedbackTime",DateUtil.dateToString(feedbackTime,DateUtil.FORMAT_DAY));
        if(actualBeginTime!=null) {
            jsonObject.put("times", DateUtil.dateToString(actualBeginTime, DateUtil.FORMAT_DAY) + " 至 " + DateUtil.dateToString(actualEndTime, DateUtil.FORMAT_DAY));
        }
        return jsonObject;
    }
}
