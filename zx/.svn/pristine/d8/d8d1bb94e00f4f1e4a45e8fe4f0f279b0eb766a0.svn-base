package com.taiji.frame.model.entity.foreignaffairs.abroad;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicUser;
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

@Entity
@Table(name = "FA_OAM_ABROADINFO" , schema = "SCH_DUTY")
public class AbroadInfo extends IdEntity implements Jsonable, Serializable {

    //通过继承IdEntity获得ID

    /**
     *
     * 出访活动类别 0：全国ZX活动 1：外单位活动
     *
     */
    @Setter
    @Getter
    public String abroadType;

    /**
     *
     * 团组活动级别ID
     *
     */
    @Setter
    public DicParam groupLevel;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "GROUP_LEVEL_ID" , referencedColumnName = "ID")
    public DicParam getGroupLevel() {
        if(groupLevel != null)
        {
            try {
                groupLevel.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return groupLevel;
    }

    /**
     *
     * 是否计划内 0：计划内 1：计划外
     *
     */
    @Setter
    @Getter
    public String planFlag;

    /**
     *
     * 团组活动编号
     *
     */
    @Setter
    @Getter
    public String groupNumber;

    /**
     *
     * 团组活动名称
     *
     */
    @Setter
    @Getter
    public String groupName;

    /**
     *
     * 开始日期
     *
     */
    @Setter
    public Date startDate;
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd" , timezone = "GMT+8")
    public Date getStartDate() {
        return startDate;
    }

    /**
     *
     * 结束日期
     *
     */
    @Setter
    public Date endDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd" , timezone = "GMT+8")
    public Date getEndDate() {
        return endDate;
    }

    /**
     *
     * 主办单位
     *
     */
    @Setter
    public DicDept org;
    @ManyToOne(fetch = FetchType.LAZY , targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID" , referencedColumnName = "ID")
    public DicDept getOrg() {
        if(org != null)
        {
            try {
                org.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return org;
    }

    /**
     *
     * 主办单位名称
     *
     */
    @Setter
    @Getter
    public String deptName;

    /**
     *
     * 出国任务批件号
     *
     */
    @Setter
    @Getter
    public String batchNumber;

    /**
     *
     * 团长姓名
     *
     */
    @Setter
    public DicUser groupLeader;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "GROUP_LEADER", referencedColumnName = "ID")
    public DicUser getGroupLeader() {
        return groupLeader;
    }

    /**
     *
     * 团长姓名（字符）
     *
     */
    @Setter
    @Getter
    public String leaderName;

    /**
     *
     * 团组总人数
     *
     */
    @Setter
    @Getter
    public Long totalNum;

    /**
     *
     * 备注
     *
     */
    @Setter
    @Getter
    public String remark;



    /**
     *
     * 出访任务
     *
     */
    @Setter
    public DicParam abroadTask;
    @ManyToOne(fetch = FetchType.LAZY , targetEntity = DicParam.class)
    @JoinColumn(name = "ABROAD_TASK_ID" , referencedColumnName = "ID")
    public DicParam getAbroadTask() {
        if(abroadTask != null)
        {
            try {
                abroadTask.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return abroadTask;
    }

    /**
     *
     * 国外调研题目（出访任务=国外调研）
     *
     */
    @Setter
    @Getter
    public String researchTopic;

    /**
     *
     * 任务描述
     *
     */
    @Setter
    @Getter
    public String taskDesc;

    /**
     *
     * 费用来源
     *
     */
    @Setter
    public DicParam costSource;
    @ManyToOne(fetch = FetchType.LAZY , targetEntity = DicParam.class)
    @JoinColumn(name = "COST_SOURCE_ID" , referencedColumnName = "ID")
    public DicParam getCostSource() {
        if(costSource != null)
        {
            try {
                costSource.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return costSource;
    }

    /**
     *
     * 在外停留天数
     *
     */
    @Setter
    @Getter
    public Long abroadDays;

    /**
     *
     * 费用说明
     *
     */
    @Setter
    @Getter
    public String costInstruct;
    /**
     * 出访国家
     */
    @Getter
    @Setter
    public String country;

    /**
     * 出访国家Id
     */
    @Getter
    @Setter
    public String countryIds;


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
        if (null == getGroupLeader()) {
            jsonObject.put("leaderName", leaderName);
        } else {
            jsonObject.put("leaderName", getGroupLeader().getEmpName());
        }

        jsonObject.put("abroadType" , abroadType);
        String abroadTypeName = "";
        if(abroadType!=null) {
            if ("0".equals(abroadType)) {
                abroadTypeName = "全国ZX活动";
            } else if ("1".equals(abroadType)) {
                abroadTypeName = "外单位活动";
            }
        }
        jsonObject.put("abroadTypeName" , abroadTypeName);
        jsonObject.put("groupLevelId" , getGroupLevel()==null ? "" : getGroupLevel().getId());
        jsonObject.put("groupLevelName" , getGroupLevel()==null ? "" : getGroupLevel().getName());
        jsonObject.put("planFLag" , planFlag);
        String planFlagName = "";
        if(planFlag!=null) {
            if ("0".equals(planFlag)) {
                planFlagName = "计划内";
            } else if ("1".equals(planFlag)) {
                planFlagName = "计划外";
            }
        }
        jsonObject.put("planFlagName" , planFlagName);
        jsonObject.put("groupNumber" , groupNumber);
        jsonObject.put("groupName" , groupName);
        jsonObject.put("startDateStr" , startDate==null ? "" : DateUtil.dateToString(startDate , DateUtil.FORMAT_DAY));
        jsonObject.put("endDateStr" , endDate==null ? "" : DateUtil.dateToString(endDate , DateUtil.FORMAT_DAY));
        jsonObject.put("orgId" , getOrg()==null ? "" : getOrg().getId());
        jsonObject.put("orgName" , getOrg()==null ? "" : getOrg().getDeptName());
        jsonObject.put("batchNumber" , batchNumber);
        jsonObject.put("groupLeaderId", getGroupLeader() == null ? "" : getGroupLeader().getId());
        jsonObject.put("groupLeaderName" , getGroupLeader() == null ? "" : getGroupLeader().getEmpName());
        jsonObject.put("totalNum" , totalNum);
        jsonObject.put("abroadTaskId" , getAbroadTask()==null ? "" : getAbroadTask().getId());
        jsonObject.put("abroadTaskName" , getAbroadTask()==null ? "" : getAbroadTask().getName());
        jsonObject.put("researchTopic" , researchTopic);
        jsonObject.put("taskDesc" , taskDesc);
        jsonObject.put("costSourceId" , getCostSource()==null ? "" : getCostSource().getId());
        jsonObject.put("costSourceName" , getCostSource()==null ? "" : getCostSource().getName());
        jsonObject.put("abroadDays" , abroadDays);
        jsonObject.put("costInstruct" , costInstruct);
        jsonObject.put("remark" , remark);
        jsonObject.put("country", country);
        jsonObject.put("createTimeStr" , createTime==null ? "" : DateUtil.dateToString(createTime , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("updateTimeStr" , updateTime==null ? "" : DateUtil.dateToString(updateTime , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("delFlag", delFlag);

        return jsonObject;
    }
}
