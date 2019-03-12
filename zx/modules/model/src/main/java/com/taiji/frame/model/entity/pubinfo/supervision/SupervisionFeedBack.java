package com.taiji.frame.model.entity.pubinfo.supervision;

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
 * @author qzp
 * @date 2018/08/23
 * 督查事项反馈表
 */
@Entity
@Table(name = "PU_SUPERVISION_FEEDBACK",schema = "SCH_DUTY")
public class SupervisionFeedBack extends IdEntity implements Jsonable,Serializable {

    /**
     * 督查事项ID
     */
    @Setter
    private SupervisionMatter supervisionMatter;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = SupervisionMatter.class)
    @JoinColumn(name = "MATTER_ID", referencedColumnName = "ID")
    public SupervisionMatter getSupervisionMatter() {
        if(supervisionMatter != null){
            try {
                supervisionMatter.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return supervisionMatter;
    }

    /**
     * 承办单位
     */
    @Setter
    private DicDept unit;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "UNIT_ID", referencedColumnName = "ID")
    public DicDept getUnit() {
        if(unit != null){
            try {
                unit.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return unit;
    }

    /**
     * 审批人
     */
    @Setter
    @Getter
    private String name;

    /**
     * 是否办结
     */
    @Setter
    @Getter
    private String isTransfer;

    @Transient
    private String getTransfer() {
        if (null == isTransfer) {
            return "";
        } else if (isTransfer.equals("0")) {
            return "否";
        } else if (isTransfer.equals("1")) {
            return "是";
        } else {
            return "";
        }
    }

    /**
     * 反馈状态(0:未反馈，1：已反馈，2：已查收)
     */
    @Getter
    @Setter
    public String status;

    /**
     * 反馈日期
     */
    private Date feedBackDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setFeedBackDate(Date feedBackDate) {
        this.feedBackDate = feedBackDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getFeedBackDate() {
        return feedBackDate;
    }

    /**
     * 办理情况概要
     */
    @Setter
    @Getter
    private String summary;

    /**
     * 更新时间
     */
    private Date updateTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * 删除标志(0未删除、1已删除)
     */
    @Setter
    @Getter
    private String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("matterId",getSupervisionMatter() == null ? "" : getSupervisionMatter().getId());
        jsonObject.put("serialNumber",getSupervisionMatter() == null ? "" : getSupervisionMatter().getSerialNumber());


        jsonObject.put("unitId",getUnit() == null ? "" : getUnit().getId());
        jsonObject.put("deptName",getUnit() == null ? "" : getUnit().getDeptName());
        jsonObject.put("createName",name);
        jsonObject.put("isTransfer",getTransfer());
        jsonObject.put("feedBackDate",DateUtil.dateToString(feedBackDate, DateUtil.FORMAT_DAY));
        jsonObject.put("feedBackDateStr",DateUtil.dateToString(feedBackDate, DateUtil.FORMAT_DAY_CN));
        jsonObject.put("summary",summary);
        jsonObject.put("status", status == null ? "" : status);
        String statusName = "";
        if ("0".equals(status)) {
            statusName = "未反馈";
        } else if ("1".equals(status)) {
            statusName = "已反馈";
        } else if ("2".equals(status)){
            statusName = "已查收";
        }
        jsonObject.put("updateTime",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag",delFlag);
        return jsonObject;
    }
}
