package com.taiji.frame.model.entity.pubinfo.contacts;

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
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
/**
 * @author sy
 * 通讯录-1用户表
 */
@Entity
@Table(name = "PU_CMM_LIST", schema = "SCH_DUTY")
public class CmmList extends IdEntity implements Jsonable, Serializable {

    /**
     * 所属单位编码
     */
    @Setter
    public DicDept dicDept;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {
        return dicDept;
    }

    /**
     * 操作人
     */
    @Setter
    public DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        return dicUser;
    }


    /**
     * 职务类型编码
     */
    @Getter
    @Setter
    public String proTypeId;


    /**
     * 所属单位名称
     */
    @Getter
    @Setter
    public String orgName;

    /**
     * 姓名
     */
    @Getter
    @Setter
    public String name;

    /**
     * 部门
     */
    @Getter
    @Setter
    public String department;

    /**
     * 办公电话
     */
    @Getter
    @Setter
    public String jobTel;

    /**
     * 移动电话
     */
    @Getter
    @Setter
    public String mobile;

    /**
     * 邮箱
     */
    @Getter
    @Setter
    public String email;

    /**
     * 秘书姓名
     */
    @Getter
    @Setter
    public String secName;

    /**
     * 秘书电话
     */
    @Getter
    @Setter
    public String secMobile;

    /**
     * 司机姓名
     */
    @Getter
    @Setter
    public String driName;

    /**
     * 司机电话
     */
    @Getter
    @Setter
    public String driMobile;

    /**
     * 标志
     */
    @Getter
    @Setter
    public String flag;

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
     * 传真
     */
    @Getter
    @Setter
    public String fax;

    /**
     * 性别
     */
    @Getter
    @Setter
    public String sex;

    /**
     * 出身年月
     */
    @Setter
    public Date birthDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getBirthDate() {
        return birthDate;
    }

    /**
     * 办公室
     */
    @Getter
    @Setter
    public String location;

    /**
     * 排序
     */
    @Getter
    @Setter
    public int addressSort;

    /**
     * 删除标志
     */
    @Getter
    @Setter
    public String delFlag;

    @Setter
    public CmmListt cmmListDepts;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = CmmListt.class)
    @JoinColumn(name = "CMM_LISTT_ID", referencedColumnName = "ID")
    public CmmListt getCmmListDepts() {
        return cmmListDepts;
    }


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("orgId", dicDept== null ? "" : dicDept.getId());
        jsonObject.put("userId",  dicUser== null ? "" : dicUser.getId());
        jsonObject.put("proTypeId", proTypeId);
        jsonObject.put("orgName", orgName);
        jsonObject.put("name", name);
        jsonObject.put("department", dicDept== null ? "" : dicDept.getDeptName());
        jsonObject.put("jobTel", jobTel);
        jsonObject.put("mobile", mobile);
        jsonObject.put("email", email);
        jsonObject.put("secName", secName);
        jsonObject.put("secMobile", secMobile);
        jsonObject.put("driName", driName);
        jsonObject.put("driMobile", driMobile);
        jsonObject.put("flag", flag);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("fax", fax);
        jsonObject.put("sex", sex);
        jsonObject.put("birthDateStr", DateUtil.dateToString(birthDate, DateUtil.FORMAT_DAY));
        jsonObject.put("location", location);
        jsonObject.put("addressSort", addressSort);
        jsonObject.put("delFlag", delFlag);
        //jsonObject.put("addressTeamId", addressTeam.getId());
        return jsonObject;
    }
}
