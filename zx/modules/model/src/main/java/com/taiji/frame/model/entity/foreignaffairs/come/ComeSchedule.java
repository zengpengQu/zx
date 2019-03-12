package com.taiji.frame.model.entity.foreignaffairs.come;

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
 * 来访日程管理
 *
 * @author yx
 */
@Entity
@Table(name = "FA_CVM_SCHEDULES", schema = "SCH_DUTY")
public class ComeSchedule extends IdEntity implements Jsonable, Serializable{

    private static final Logger LOG = LoggerFactory.getLogger(ComeSchedule.class);

    /**
     * 来访基本信息
     */
    @Setter
    public ComeInfo comeInfo;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = ComeInfo.class)
    @JoinColumn(name = "BASICINFO_ID", referencedColumnName = "ID")
    public ComeInfo getComeInfo() {
        if (comeInfo != null) {
            try {
                comeInfo.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 ComeInfo comeInfo 错误", e);
                return null;
            }
        }
        return comeInfo;
    }

    /**
     * 活动日期
     */
    public Date activityDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setActivityDate(Date activityDate) {
        this.activityDate = activityDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getActivityDate() {
        return activityDate;
    }

    /**
     * 活动时间
     */
    public Date activityTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setActivityTime(Date activityTime) {
        this.activityTime = activityTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getActivityTime() {
        return activityTime;
    }

    /**
     * 活动详情
     */
    @Setter
    @Getter
    public String activity;


    /**
     * 更新时间
     */
    public Date updateTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
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

        jsonObject.put("id", id);
        jsonObject.put("comeInfoId", getComeInfo() == null ? "" : this.getComeInfo().getId());
        jsonObject.put("activityDateStr", DateUtil.dateToString(activityDate, DateUtil.FORMAT_DAY));
        jsonObject.put("activityTimeStr", DateUtil.dateToString(activityTime, DateUtil.FORMAT_TIME_SHORT));
        jsonObject.put("activity", activity);
        jsonObject.put("delFlag", delFlag);

        return jsonObject;
    }
}
