package com.taiji.frame.model.entity.foreignaffairs.taiwanCard;

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
import org.hibernate.annotations.Where;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author qzp
 * @date 2018/08/10
 * 赴台信息列表实体
 */
@Entity
@Table(name = "DM_PPM_TAIWAN_INFO",schema = "SCH_DUTY")
public class TaiWanInfo extends IdEntity implements Jsonable,Serializable {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanInfo.class);

    /**
     * 用户信息
     */
    @Setter
    private DicUser dicUser;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        return dicUser;
    }

    /**
     * 部门信息
     */
    private DicDept dicDept;

    public void setDicDept(DicDept dicDept) {
        this.dicDept = dicDept;
    }

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "DEPT_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {
        if(dicDept != null) {
            try {
                dicDept.getDeptName();
            } catch (Exception e) {
                LOGGER.error("获取关联对象 DicDept dicDept错误", e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 赴台开始时间
     */
    private Date goTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setGoTime(Date goTime) {
        this.goTime = goTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getGoTime() {
        return goTime;
    }

    /**
     * 赴台结束时间
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
    @Setter
    @Getter
    private String groupName;

    /**
     * 团组ID
     */
    private DicDept dept;

    public void setDept(DicDept dept) {
        this.dept = dept;
    }

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "GROUP_ID", referencedColumnName = "ID")
    public DicDept getDept() {
        if(dept != null) {
            try {
                dept.getDeptName();
            } catch (Exception e) {
                LOGGER.error("获取关联对象 DicDept dept错误", e);
                return null;
            }
        }
        return dept;
    }

    /**
     * 创建时间
     */
    private Date createTime;

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
     * 备注
     */
    @Getter
    @Setter
    private String notes;


    /**
     * 台方接待单位
     */
    @Getter
    @Setter
    private String taiDept;
    /**
     * 费用来源
     */
    @Getter
    @Setter
    private String taiCharge;

    /**
     * 删除标志
     */
    @Setter
    @Getter
    private String delFlag;


    /**
     * 团组人员信息
     */
    @Setter
    private List<TaiWanInfoUser> taiWanInfoUserList;
    @OneToMany(cascade = CascadeType.MERGE, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "taiWanInfo", targetEntity = TaiWanInfoUser.class)
    @Where(clause = "DEL_FLAG = 0")
    @OrderBy("TAIWAN_DEPT_ID ASC ")
    public List<TaiWanInfoUser> getTaiWanInfoUserList() {
        return taiWanInfoUserList;
    }


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("peopleId", null == getDicUser() ? "" : getDicUser().getId());
        List<String> name = new ArrayList<>();
        List<TaiWanInfoUser> list = getTaiWanInfoUserList();
        for (TaiWanInfoUser user:list) {
            name.add(user.getDicUser().getEmpName());
        }
        jsonObject.put("empName",name.toString());
        jsonObject.put("goTime",DateUtil.dateToString(goTime, DateUtil.FORMAT_DAY));
        jsonObject.put("endTime",DateUtil.dateToString(endTime, DateUtil.FORMAT_DAY));
        jsonObject.put("groupName",groupName);
        jsonObject.put("deptId",null == getDicDept() ? "" : getDicDept().getId());
        jsonObject.put("department",null == getDicDept() ? "" : getDicDept().getDeptName());
        jsonObject.put("createTime",DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("groupId",null == getDept() ? "" : getDept().getId());
        jsonObject.put("groupDept",null == getDept() ? "" : getDept().getDeptName());
        jsonObject.put("notes",notes);
        jsonObject.put("delFlag",delFlag);
        jsonObject.put("taiDept",taiDept);
        jsonObject.put("taiCharge",taiCharge);
        return jsonObject;
    }
}
