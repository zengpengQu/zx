package com.taiji.frame.model.entity.foreignaffairs.privateAbroad;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
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
 * 因私出国(境)
 * Created by yuLei on 2018/7/30.
 */
@Entity
@Table(name = "DM_PPM_PRIVATE_ABROAD", schema = "SCH_DUTY")
public class PrivateAbroad extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(PrivateAbroad.class);

    /**
     * 人员信息ID
     */
    @Setter
    public DicUser dicUser;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "PEOPLE_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        if(dicUser != null)
        {
            try {
                dicUser.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象  DicUser dicUser 错误",e);
                return null;
            }
        }
        return dicUser;
    }

    /**
     * 工作部门
     */
    public DicDept dicDept;

    public void setDicDept(DicDept dicDept) {
        this.dicDept = dicDept;
    }

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "DEPARTMENT", referencedColumnName = "ID")
    public DicDept getDicDept() {
        if(dicDept != null) {
            try {
                dicDept.getDeptName();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicDept dicDept错误", e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 出国开始时间
     */
    private Date startTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getStartTime() {
        return startTime;
    }

    /**
     * 出国结束时间
     */
    private Date endTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getEndTime() {
        return endTime;
    }

    /**
     * 团组名称
     */
    @Getter
    @Setter
    private String groupName;

    /**
     * 组团单位
     */
    public DicDept dicDeptForGroup;

    public void setDicDeptForGroup(DicDept dicDeptForGroup) {
        this.dicDeptForGroup = dicDeptForGroup;
    }

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "GROUP_DEPARTMENT", referencedColumnName = "ID")
    public DicDept getDicDeptForGroup() {
        if(dicDeptForGroup != null) {
            try {
                dicDeptForGroup.getDeptName();
            } catch (Exception e) {
                LOG.error("获取关联对象DicDept dicDeptForGroup 错误", e);
                return null;
            }
        }
        return dicDeptForGroup;
    }

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
        jsonObject.put("peopleId", null == getDicUser() ? "" : getDicUser().getId());
        jsonObject.put("empName", null == getDicUser() ? "" : getDicUser().getEmpName());
        jsonObject.put("deptId", null == getDicDept() ? "" : getDicDept().getId());
        jsonObject.put("department", null == getDicDept() ? "" : getDicDept().getDeptName());
        jsonObject.put("startTime", DateUtil.dateToString(startTime, DateUtil.FORMAT_DAY));
        jsonObject.put("endTime", DateUtil.dateToString(endTime, DateUtil.FORMAT_DAY));
        jsonObject.put("startEndTime", DateUtil.dateToString(startTime, DateUtil.FORMAT_DAY) + "—" + DateUtil.dateToString(endTime, DateUtil.FORMAT_DAY));
        jsonObject.put("groupName", groupName);
        jsonObject.put("deptIdForGroup", null == getDicDeptForGroup() ? "" : getDicDeptForGroup().getId());
        jsonObject.put("groupDepartment", null == getDicDeptForGroup() ? "" : getDicDeptForGroup().getDeptName());
        jsonObject.put("notes", notes);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("delFlag", delFlag);
        return jsonObject;
    }

}
