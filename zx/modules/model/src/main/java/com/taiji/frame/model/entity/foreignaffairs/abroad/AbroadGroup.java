package com.taiji.frame.model.entity.foreignaffairs.abroad;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.constants.Sex;
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

@Entity
@Table(name = "FA_OAM_GROUP" , schema = "SCH_DUTY")
public class AbroadGroup extends IdEntity implements Jsonable, Serializable {

    @Transient
    @Override
    public String toString() {
        return dicUser != null ? dicUser.getEmpName() : name;
    }

    /**
     *
     * 出访信息ID
     *
     */
    @Setter
    public AbroadInfo abroadInfo;
    @ManyToOne(fetch = FetchType.LAZY , targetEntity = AbroadInfo.class)
    @JoinColumn(name = "ABROADINFO_ID" , referencedColumnName = "ID")
    public AbroadInfo getAbroadInfo() {
        if(abroadInfo != null)
        {
            try {
                abroadInfo.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return abroadInfo;
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
     *
     * 姓名
     *
     */
    @Setter
    @Getter
    public String name;

    /**
     *
     * 性别 0：男 1：女
     *
     */
    @Setter
    @Getter
    public String sex;

    /**
     *
     * 出生日期
     *
     */
    @Setter
    public Date birthday;
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd" , timezone = "GMT+8")
    public Date getBirthday() {
        return birthday;
    }

    /**
     *
     * 出生地
     *
     */
    @Setter
    @Getter
    public String homeplace;

    /**
     *
     * 工作单位
     *
     */
    @Setter
    @Getter
    public String org;

    /**
     *
     * 主要职务
     *
     */
    @Setter
    @Getter
    public String duty;

    /**
     *
     * 联系方式
     *
     */
    @Setter
    @Getter
    public String tel;

    /**
     *
     * 角色ID
     *
     */
    @Setter
    public DicParam role;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "ROLE_ID" , referencedColumnName = "ID")
    public DicParam getRole() {
        if(role != null)
        {
            try {
                role.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return role;
    }

    /**
     *
     * 对外身份
     *
     */
    @Setter
    @Getter
    public String identity;

    /**
     * 行政级别
     */
    @Setter
    @Getter
    public String adminLevel;

    /**
     *
     * 排序号
     *
     */
    @Setter
    @Getter
    public Integer sorting;

    /**
     *
     * 人员类别 0：本单位 1：外单位
     *
     */
    @Setter
    @Getter
    public String personFlag;

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
        jsonObject.put("abroadInfoId" , getAbroadInfo()==null ? "" : getAbroadInfo().getId());
        jsonObject.put("userId" ,  getDicUser() == null ? "" : getDicUser().getId());
        jsonObject.put("name" , name);
        String sexName = "";
        if(sex!=null) {
            if (Sex.MALE.value().equals(sex)) {
                sexName = "男";
            } else if (Sex.female.value().equals(sex)) {
                sexName = "女";
            }
        }
        jsonObject.put("sexName" , sexName);
        jsonObject.put("birthdayStr" , getBirthday()==null ? "" : DateUtil.dateToString(getBirthday() , DateUtil.FORMAT_DAY));
        jsonObject.put("homeplace" , homeplace);
        jsonObject.put("org" , org);
        jsonObject.put("duty" , duty);
        jsonObject.put("tel" , tel);
        jsonObject.put("roleId" , getRole()==null ? "" : getRole().getId());
        jsonObject.put("roleName" , getRole()==null ? "" : getRole().getName());
        jsonObject.put("identity" , identity);
        jsonObject.put("sorting" , sorting);
        String personFlagName = "";
        if(personFlag!=null) {
            if ("0".equals(personFlag)) {
                personFlagName = "本单位";
            } else if ("1".equals(personFlag)) {
                personFlagName = "外单位";
            }
        }
        jsonObject.put("personFlagName" , personFlagName);
        jsonObject.put("createTimeStr" , getCreateTime()==null ? "" : DateUtil.dateToString(getCreateTime() , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("updateTimeStr" , getUpdateTime()==null ? "" : DateUtil.dateToString(getUpdateTime() , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("delFlag", delFlag);

        return jsonObject;
    }


}
