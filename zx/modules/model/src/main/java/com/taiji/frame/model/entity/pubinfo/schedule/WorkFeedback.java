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
 * @author pengyx
 * 一周工作情况反馈表
 */
@Entity
@Table(name = "PU_SCH_FEEDBACK", schema = "SCH_DUTY")
public class WorkFeedback extends IdEntity implements Jsonable, Serializable {

    /**
     * 一周工作情况ID
     */
    @Setter
    public WeekWork weekWork;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = WeekWork.class)
    @JoinColumn(name = "WORK_ID", referencedColumnName = "ID")
    public WeekWork getWeekWork() {

        if (weekWork != null) {
            try {
                weekWork.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return weekWork;
    }

    /**
     * 反馈部门
     */
    @Setter
    public DicDept dicDept;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ID")
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
     */
    @Getter
    @Setter
    public String createName;

    /**
     * 反馈人电话
     */
    @Getter
    @Setter
    public String phone;

    /**
     * 签发领导
     */
    @Getter
    @Setter
    public String signLeader;

    /**
     * 报送日期
     * */
    @Getter
    @Setter
    public Date feedbackDate;

    /**
     * 出席情况反馈
     */
    @Getter
    @Setter
    public String isAttend;

    /**
     * 参加人员
     */
    @Setter
    public DicUser participants;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "PARTICIPANTS", referencedColumnName = "ID")
    public DicUser getParticipants() {

        if (participants != null) {
            try {
                participants.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return participants;
    }

    /**
     * 请假理由
     */
    @Getter
    @Setter
    public String reason;

    /**
     * 本周工作开展情况
     */
    @Getter
    @Setter
    public String workContent;

    /**
     * 下周工作安排
     */
    @Getter
    @Setter
    public String workSchedule;

    /**
     * 近期重点工作
     */
    @Getter
    @Setter
    public String majorWork;

    /**
     * 反馈状态(0:未反馈，1：已反馈，2：已查收)
     */
    @Getter
    @Setter
    public String status;

    /**
     * 最后更新时间
     */
    @Getter
    @Setter
    public Date updateTime;

    /**
     * 删除标志
     */
    @Getter
    @Setter
    public String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", getId());
        jsonObject.put("workId", getWeekWork() == null ? "" : this.getWeekWork().getId());
        jsonObject.put("deptId", getDicDept() == null ? "" : this.getDicDept().getId());
        jsonObject.put("deptName", getDicDept() == null ? "" : this.getDicDept().getDeptName());
        jsonObject.put("createName", createName);
        jsonObject.put("phone", phone == null ? "" : phone);
        jsonObject.put("signLeader", signLeader);
        jsonObject.put("isAttend", isAttend);
        jsonObject.put("participants", getParticipants() == null ? "" : this.getParticipants().getEmpName());
        jsonObject.put("reason", reason == null ? "" : reason);
        jsonObject.put("workContent", workContent == null ? "" : workContent);
        jsonObject.put("workSchedule", workSchedule == null ? "" : workSchedule);
        jsonObject.put("majorWork", majorWork == null ? "" : majorWork);
        jsonObject.put("status", status == null ? "" : status);

        String statusName = "";
        if ("0".equals(status)) {
            statusName = "未反馈";
        } else if ("1".equals(status)) {
            statusName = "已反馈";
        } else if ("2".equals(status)){
            statusName = "已查收";
        }
        jsonObject.put("statusName",statusName);
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT));
        jsonObject.put("feedbackDate",DateUtil.dateToString(feedbackDate,DateUtil.FORMAT_DAY));

        return jsonObject;
    }
}
