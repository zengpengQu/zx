package com.taiji.frame.model.entity.pubinfo.schedule;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author admin
 * 领导活动安排会议通知反馈表
 */

@Entity
@Table(name = "PU_ACTIVITY_RECEIPT", schema = "SCH_DUTY")
public class PlanReceipt extends IdEntity implements Jsonable, Serializable {

    /**
     * 会议通知
     */
    @Setter
    public ActivityPlan activityPlan;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = ActivityPlan.class)
    @JoinColumn(name = "PLAN_ID", referencedColumnName = "ID")
    public ActivityPlan getActivityPlan() {

        if (activityPlan != null) {
            try {
                activityPlan.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return activityPlan;
    }

    /**
     * 反馈部门
     */
    @Setter
    public DicDept dicDept;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "DEPT_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {

        if (dicDept != null) {
            try {
                dicDept.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 反馈人
     * */
    @Setter
    public DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "CREATE_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {

        if (dicUser != null) {

            try {
                dicUser.getId();
            } catch (Exception e) {
                return null;
            }

        }
        return dicUser;
    }

    /**
     * 是否参会
     */
    @Getter
    @Setter
    public String isAttend;

    /**
     * 参会领导
     */
    @Getter
    @Setter
    public String leaderName;

    /**
     * 请假理由
     */
    @Getter
    @Setter
    public String reason;

    /**
     * 下周工作安排
     */
    @Getter
    @Setter
    public String workPlan;

    /**
     * 开始日期
     */
    @Getter
    @Setter
    public Date startDate;

    /**
     * 结束日期
     */
    @Getter
    @Setter
    public Date endDate;

    /**
     * 反馈时间
     */
    @Getter
    @Setter
    public Date feedbackTime;

    /**
     * 状态(0未反馈，1已反馈，2已查收)
     */
    @Getter
    @Setter
    public String status;

    /**
     * 是否删除
     */
    @Getter
    @Setter
    public String delFlag;

    /**
     * 最后更新时间
     * */
    @Getter
    @Setter
    public Date updateTime;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("deptId", dicDept == null ? "" : dicDept.getId());
        jsonObject.put("deptName", dicDept == null ? "" : dicDept.getDeptName());
        jsonObject.put("content",activityPlan == null ? "" : activityPlan.getContent());
        jsonObject.put("sendTime",activityPlan == null ? "" : DateUtil.dateToString(activityPlan.getSendTime(),DateUtil.FORMAT_DAY_CN));
        jsonObject.put("meetingFlag",activityPlan == null ? "" : activityPlan.getMeetingFlag());
        jsonObject.put("isAttend", isAttend);
        jsonObject.put("leaderName", leaderName == null ? "" : leaderName);
        jsonObject.put("reason", reason == null ? "" : reason);
        jsonObject.put("workPlan", workPlan);
        jsonObject.put("startDateStr", startDate == null ? "" : DateUtil.dateToString(startDate, DateUtil.FORMAT_DAY_CN_MD));
        jsonObject.put("endDateStr", endDate == null ? "" : DateUtil.dateToString(endDate, DateUtil.FORMAT_DAY_CN_MD));
        jsonObject.put("feedbackTimeStr", feedbackTime == null ? "" : DateUtil.dateToString(feedbackTime, DateUtil.FORMAT_DAY));
        jsonObject.put("status", status);
        jsonObject.put("delFlag",delFlag);
        jsonObject.put("planId",activityPlan.getId() == null ? "" : activityPlan.getId());
        jsonObject.put("creatorName",dicUser == null ? "" : dicUser.getEmpName());
        jsonObject.put("phone",dicUser == null ? "" : dicUser.getPhone());
        jsonObject.put("updateTimeStr",updateTime == null ? "" : DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAY));

        return jsonObject;
    }
}
