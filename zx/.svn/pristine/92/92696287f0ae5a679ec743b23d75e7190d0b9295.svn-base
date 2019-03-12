package com.taiji.frame.model.entity.foreignaffairs.come;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicParam;
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

/**
 * 来访陪同人员
 *
 * @author yx
 */
@Entity
@Table(name = "FA_CVM_ACCOMPANY", schema = "SCH_DUTY")
public class ComeAccompany extends IdEntity implements Jsonable, Serializable {


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
                return null;
            }
        }
        return comeInfo;
    }

    /**
     * 角色
     */
    @Setter
    public DicParam dicParam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "ROLE_ID", referencedColumnName = "ID")
    public DicParam getDicParam() {
        if (dicParam != null) {
            try {
                dicParam.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicParam;
    }

    /**
     * 用户ID
     */
    @Setter
    public DicUser dicUser;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
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
     * 是否政协人员（0：是， 1：否）
     */
    @Setter
    @Getter
    public String cppccFlag;

    /**
     * 对外身份
     */
    @Setter
    @Getter
    public String foreignIdentity;

    /**
     * 姓名
     */
    @Setter
    @Getter
    public String name;

    /**
     * 性别（0:男， 1：女）
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
     * 顺序
     */
    @Setter
    @Getter
    public Integer seq;

    /**
     * 备注
     */
    @Setter
    @Getter
    public String notes;

    /**
     * 创建时间
     */
    @Setter
    public Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

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
        jsonObject.put("comeInfoId", getComeInfo() == null ? "" : getComeInfo().getId());
        jsonObject.put("roleId", getDicParam() == null ? "" : getDicParam().getId());
        jsonObject.put("roleName", getDicParam() == null ? "" : getDicParam().getName());
        jsonObject.put("userId", getDicUser() == null ? "" : getDicUser().getId());
        jsonObject.put("cppccFlag", cppccFlag);
        if ("0".equals(cppccFlag)) {
            jsonObject.put("cppccFlagStr", "是");
        } else if ("1".equals(cppccFlag)) {
            jsonObject.put("cppccFlagStr", "否");
        }
        jsonObject.put("foreignIdentity", foreignIdentity);
        jsonObject.put("name", name);
        jsonObject.put("sex", sex);
        if ("0".equals(sex)) {
            jsonObject.put("sexStr", "男");
        } else if ("1".equals(sex)) {
            jsonObject.put("sexStr", "女");
        } else {
            jsonObject.put("sexStr", "未知");
        }
        jsonObject.put("tel", tel);
        jsonObject.put("birthdayStr", DateUtil.dateToString(birthday, DateUtil.FORMAT_DAY));
        jsonObject.put("mainDuty", mainDuty);
        jsonObject.put("otherDuty", otherDuty);
        jsonObject.put("personnelOrg", personnelOrg);
        jsonObject.put("adminLevel", adminLevel);
        jsonObject.put("politicsStatus", politicsStatus);
        jsonObject.put("seq", seq);
        jsonObject.put("notes", notes);
        jsonObject.put("delFlag", delFlag);

        return jsonObject;
    }
}
