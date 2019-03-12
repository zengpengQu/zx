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
 * 来访接待计划
 * @author yx
 */
@Entity
@Table(name = "FA_CVM_RECEPTION", schema = "SCH_DUTY")
public class ComeReception extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(ComeReception.class);

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
     * 活动安排标题
     */
    @Setter
    @Getter
    public String receptionTitle;

    /**
     * 陪同人员数
     */
    @Setter
    @Getter
    public String accompanyNum;

    /**
     * 接待地点
     */
    @Setter
    @Getter
    public String receptionSite;

    /**
     * 接待开始日期
     */
    @Setter
    public Date startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getStartDate() {
        return startDate;
    }

    /**
     * 接待结束日期
     */
    @Setter
    public Date endDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getEndDate() {
        return endDate;
    }


    /**
     * 活动安排
     */
    @Setter
    @Getter
    public String activityPlan;

    /**
     * 谈话参考要点
     */
    @Setter
    @Getter
    public String talkReference;

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
        jsonObject.put("receptionTitle", receptionTitle);
        jsonObject.put("accompanyNum", accompanyNum);
        jsonObject.put("receptionSite", receptionSite);
        jsonObject.put("startDateStr", DateUtil.dateToString(startDate, DateUtil.FORMAT_DAY));
        jsonObject.put("endDateStr", DateUtil.dateToString(endDate, DateUtil.FORMAT_DAY));
        jsonObject.put("activityPlan", activityPlan);
        jsonObject.put("talkReference", talkReference);
        jsonObject.put("updateTimeStr", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag", delFlag);

        return jsonObject;
    }
}
