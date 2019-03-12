package com.taiji.frame.model.entity.foreignaffairs.come;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
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
 * 来访陪同人员信息
 *
 * @author yx
 */
@Entity
@Table(name = "FA_CVM_PEOPLE_INFO", schema = "SCH_DUTY")
public class ComePeopleInfo extends IdEntity implements Jsonable, Serializable{

    private static final Logger LOG = LoggerFactory.getLogger(ComePeopleInfo.class);

    /**
     * 系统用户信息
     */
    @Setter
    public DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        if (dicUser != null) {
            try {
                dicUser.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicUser dicUser 错误", e);
                return null;
            }
        }
        return dicUser;
    }

    /**
     * 姓名
     */
    @Setter
    @Getter
    public String name;

    /**
     * 性别
     */
    @Setter
    @Getter
    public String sex;

    /**
     * 电话
     */
    @Setter
    @Getter
    public String tel;

    /**
     * 生日
     */
    @Setter
    public Date birthday;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBirthday() {
        return birthday;
    }

    /**
     * 主要职位
     */
    @Setter
    @Getter
    public String mainDuty;

    /**
     * 其他职位
     */
    @Setter
    @Getter
    public String otherDuty;

    /**
     * 人事关系所属单位
     */
    @Setter
    @Getter
    public String personnelOrg;

    /**
     * 行政级别
     */
    @Setter
    @Getter
    public String adminLevel;

    /**
     * 政治面貌
     */
    @Setter
    @Getter
    public String politicsStatus;

    /**
     * 是否政协人员
     */
    @Setter
    @Getter
    public String cppccFlag;

    /**
     * 备注
     */
    @Setter
    @Getter
    public String notes;

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
        jsonObject.put("userId", getDicUser() == null ? "" : getDicUser().getId());
        jsonObject.put("name", name);
        jsonObject.put("sex", sex);
        if ("0".equals(sex)) {
            jsonObject.put("sexStr", "男");
        } else if ("1".equals(sex)) {
            jsonObject.put("sexStr", "女");
        }
        jsonObject.put("tel", tel);
        jsonObject.put("birthdayStr", DateUtil.dateToString(birthday, DateUtil.FORMAT_DAY));
        jsonObject.put("mainDuty", mainDuty);
        jsonObject.put("otherDuty", otherDuty);
        jsonObject.put("personnelOrg", personnelOrg);
        jsonObject.put("adminLevel", adminLevel);
        jsonObject.put("politicsStatus", politicsStatus);
        jsonObject.put("cppccFlag", cppccFlag);
        if ("0".equals(cppccFlag)) {
            jsonObject.put("cppccFlagStr", "是");
        } else if ("1".equals(cppccFlag)) {
            jsonObject.put("cppccFlagStr", "否");
        }
        jsonObject.put("notes", notes);
        jsonObject.put("updateTimeStr", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag", delFlag);

        return jsonObject;
    }
}
