package com.taiji.frame.model.entity.foreignaffairs.come;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
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

@Entity
@Table(name = "FA_CVM_BASIC_INFO", schema = "SCH_DUTY")
public class ComeInfo extends IdEntity implements Jsonable, Serializable{

    private static final Logger LOG = LoggerFactory.getLogger(ComeInfo.class);

    /**
     * 团组编号
     */
    @Getter
    @Setter
    public String groupNumber;

    /**
     * 团组名称
     */
    @Getter
    @Setter
    public String groupName;

    /**
     * 来访团国家
     */
    @Getter
    @Setter
    public String countryId;

    /**
     * 团组级别
     */
    @Setter
    public DicParam groupLevel;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "GROUP_LEVEL_ID", referencedColumnName = "ID")
    public DicParam getGroupLevel() {
        if(groupLevel != null) {
            try {
                groupLevel.getName();
            } catch (Exception e) {
                LOG.error("获取关联对象DicParam groupLevel错误",e);
                return null;
            }
        }
        return groupLevel;
    }

    /**
     * 团长中文名
     */
    @Getter
    @Setter
    public String cnName;

    /**
     * 团长外文名
     */
    @Getter
    @Setter
    public String foreignName;


    /**
     * 来访团人数
     */
    @Getter
    @Setter
    public String peopleNum;

    /**
     * 邀请名义
     */
    @Setter
    public DicParam invitation;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "INVITATION_ID", referencedColumnName = "ID")
    public DicParam getInvitation() {
        if(invitation != null) {
            try {
                invitation.getName();
            } catch (Exception e) {
                LOG.error("获取关联对象DicParam invitation错误", e);
                return null;
            }
        }
        return invitation;
    }

    /**
     * 主办单位
     */
    @Setter
    public DicDept dicDept;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "SPONSOR_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {
        if(dicDept != null) {
            try {
                dicDept.getDeptName();
            } catch (Exception e) {
                LOG.error("获取关联对象DicDept dicDept错误", e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 来访开始日期
     */
    @Setter
    public Date startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getStartDate() {
        return startDate;
    }

    /**
     * 来访结束日期
     */
    @Setter
    public Date endDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getEndDate() {
        return endDate;
    }

    /**
     * 任务描述
     */
    @Setter
    @Getter
    public String taskDscr;

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
        jsonObject.put("groupLevelId",  getGroupLevel() == null ? "" : this.getGroupLevel().getId());
        jsonObject.put("groupLevel", getGroupLevel() == null ? "" : this.getGroupLevel().getName());
        jsonObject.put("groupNumber", groupNumber);
        jsonObject.put("groupName", groupName);
        jsonObject.put("countryId", countryId);
        jsonObject.put("countryName", countryId);
        jsonObject.put("cnName", cnName);
        jsonObject.put("foreignName", foreignName);
        jsonObject.put("peopleNum", peopleNum);
        jsonObject.put("invitationId", getInvitation() == null ? "" : this.getInvitation().getId());
        jsonObject.put("invitationName", getInvitation() == null ? "" : this.getInvitation().getName());
        jsonObject.put("sponsorId", getDicDept() == null ? "" : this.getDicDept().getId());
        jsonObject.put("sponsorName", getDicDept() == null ? "" : this.getDicDept().getDeptName());
        jsonObject.put("startDateStr", DateUtil.dateToString(startDate, DateUtil.FORMAT_DAY));
        jsonObject.put("startDate", DateUtil.dateToString(startDate, DateUtil.FORMAT_DAY));
        jsonObject.put("endDateStr", DateUtil.dateToString(endDate, DateUtil.FORMAT_DAY));
        jsonObject.put("endDate", DateUtil.dateToString(endDate, DateUtil.FORMAT_DAY));
        jsonObject.put("taskDscr", taskDscr);
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag", delFlag);

        return jsonObject;
    }
}
