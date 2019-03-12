package com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs;

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
import java.util.List;

/**
 * 临时外事活动
 * Created by yuLei on 2018/7/17.
 */
@Entity
@Table(name = "FA_TFA_TEMP_AFFAIRS", schema = "SCH_DUTY")
public class TempAffairs extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(TempAffairs.class);

    public TempAffairs() {}

    /**
     * 团组编号
     */
    @Getter
    @Setter
    private String groupNumber;

    /**
     * 团组名称
     */
    @Getter
    @Setter
    private String groupName;

    /**
     * 团组级别
     */
    @Setter
    public DicParam dicParam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "GROUP_LEVEL_ID", referencedColumnName = "ID")
    public DicParam getDicParam() {
        if(dicParam != null) {
            try {
                dicParam.getName();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicParam dicParam 错误",e);
                return null;
            }
        }
        return dicParam;
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
                LOG.error("获取关联对象 DicDept dicDept 错误", e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 活动类型
     */
    @Getter
    @Setter
    private String activityType;

    /**
     * 活动时间
     */
    private Date activityTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setActivityTime(Date activityTime) {
        this.activityTime = activityTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getActivityTime() {
        return activityTime;
    }

    /**
     * 活动地点
     */
    @Getter
    @Setter
    private String activitySite;

    /**
     * 活动内容
     */
    @Getter
    @Setter
    private String activityContent;

    /**
     * 宴请地点
     */
    @Getter
    @Setter
    private String feteSite;

    /**
     * 出席领导
     */
    @Getter
    @Setter
    private String attendLeader;

    /**
     * 陪同人员
     */
    @Getter
    @Setter
    private String accompany;

    /**
     * 我方出席人员
     */
    @Getter
    @Setter
    private String chinese;

    /**
     * 外方出席人员
     */
    @Getter
    @Setter
    private String foreigner;

    /**
     * 联系人
     */
    @Getter
    @Setter
    private String contacts;

    /**
     * 联系人电话
     */
    @Getter
    @Setter
    private String contactsTel;

    /**
     * 新闻单位
     */
    @Getter
    @Setter
    private String newsOrg;

    /**
     * 备注
     */
    @Getter
    @Setter
    private String notes;

    /**
     * 创建时间
     */
    public Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 更新时间
     */
    public Date updateTime;

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
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    private String delFlag;



    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("groupNumber", groupNumber);
        jsonObject.put("groupName", groupName);
        jsonObject.put("groupLevelId", null == getDicParam() ? "" : getDicParam().getId());
        jsonObject.put("groupLevelName", null == getDicParam() ? "" : getDicParam().getName());
        jsonObject.put("deptId", null == getDicDept() ? "" : getDicDept().getId());
        jsonObject.put("deptName", null == getDicDept() ? "" : getDicDept().getDeptName());
        jsonObject.put("activityType", activityType);
        jsonObject.put("activityTime", DateUtil.dateToString(activityTime, DateUtil.FORMAT_DAY));
        jsonObject.put("activitySite", activitySite);
        jsonObject.put("activityContent", activityContent);
        jsonObject.put("feteSite", feteSite);
        jsonObject.put("attendLeader", attendLeader);
        jsonObject.put("accompany", accompany);
        jsonObject.put("chinese", chinese);
        jsonObject.put("foreigner", foreigner);
        jsonObject.put("contacts", contacts);
        jsonObject.put("contactsTel", contactsTel);
        jsonObject.put("newsOrg", newsOrg);
        jsonObject.put("notes", notes);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("delFlag", delFlag);
        return jsonObject;
    }

}
