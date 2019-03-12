package com.taiji.frame.model.systempara;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
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
import java.util.Date;
import java.util.List;

/**
 *
 * @author wd
 * @date 2016/2/15
 * 系统用户信息
 */
@Entity
@Table(name = "TB_DIC_USER",schema = "SCH_DUTY")
public class DicUser extends IdEntity implements Jsonable{

    private static final Logger LOG = LoggerFactory.getLogger(DicUser.class);

    /**
     * 部门(外键　deptID)
     * */
    @Getter
    @Setter
    private DicDept dicDept;

    /**
     * 卫士通资源信息编码
     * */
    @Getter
    @Setter
    private String rmsNo;

    /**
     * 邮箱
     * */
    @Getter
    @Setter
    private String email;

    /**
     * 传真
     * */
    @Getter
    @Setter
    private String fax;

    /**
     * 手机号
     * */
    @Getter
    @Setter
    private String mobile;

    /**
     * 姓名
     * */
    @Getter
    @Setter
    private String empName;

    /**
     * 办公电话
     * */
    @Getter
    @Setter
    private String phone;

    /**
     * 性别 0男性，1女性
     * */
    @Getter
    @Setter
    private String sex;

    /**
     * 系统登录名
     * */
    @Getter
    @Setter
    private String userId;

    /**
     * 登录密码
     * */
    @Getter
    @Setter
    private String password;

    /**
     * 个人信息创建时间
     * */
    @Getter
    @Setter
    private Date createDate;

    /**
     * 激活标志 1有效，0无效
     * */
    @Getter
    @Setter
    private Integer isactive;

    /**
     * 操作人
     * */
    @Getter
    @Setter
    private String updEmp;

    /**
     * 操作时间
     * */
    @Getter
    @Setter
    private Date updDate;

    /**
     * 此用户拥有角色列表
     * */
    @Setter
    private List<SecRole> roleList;

    /**
     * 行政级别
     */
    @Setter
    public DicParam dicParam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicParam.class)
    @JoinColumn(name = "RANK_ID", referencedColumnName = "ID")
    public DicParam getDicParam() {
        if(dicParam != null) {
            try {
                dicParam.getName();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicParam dicParam  错误",e);
                return null;
            }
        }
        return dicParam;
    }

    /**
     * 民族
     */
    @Getter
    @Setter
    private String nation;

    /**
     * 出生日期
     */
    private Date birthday;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getBirthday() {
        return birthday;
    }

    /**
     * 出生地
     */
    @Getter
    @Setter
    private String birthplace;

    /**
     * 主要职务
     */
    @Getter
    @Setter
    private String mainDuty;

    /**
     * 身份证号码
     */
    @Getter
    @Setter
    private String cardNumber;

    /**
     * 用户ID
     * */
    @Getter
    @Setter
    private String userCode;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DEPT_ID", nullable = true)
    public DicDept getDicDept() {

        if(dicDept != null)
        {
            try {
                dicDept.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicDept dicDept 错误",e);
                return null;
            }
        }
        return dicDept;
    }

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "TB_SEC_PRI_ASS",schema = "SCH_DUTY",joinColumns = @JoinColumn(name = "USER_ID"), inverseJoinColumns = @JoinColumn(name = "ROLE_ID"))
    @Where(clause = "isactive=1")
    public List<SecRole> getRoleList() {
        return roleList;
    }

    @Transient
    public String getSexStr() {
        if (null == sex) {
            return "未知";
        } else if (sex.equals("0")) {
            return "男";
        } else if (sex.equals("1")) {
            return "女";
        } else {
            return "未知";
        }
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("deptId", null == dicDept ? "" : dicDept.getId());
        jsonObject.put("deptName", null == dicDept ? "" : dicDept.getDeptName());
        jsonObject.put("email", email);
        jsonObject.put("fax", fax);
        jsonObject.put("mobile", mobile);
        jsonObject.put("empName", empName);
        jsonObject.put("phone", phone);
        jsonObject.put("sex", sex);
        jsonObject.put("sexStr", getSexStr());
        jsonObject.put("userId", userId);
        jsonObject.put("isactive", isactive);
        jsonObject.put("rankId", null == getDicParam() ? "" : getDicParam().getId());
        jsonObject.put("rankName", null == getDicParam() ? "" : getDicParam().getName());
        jsonObject.put("nation", nation);
        jsonObject.put("birthday", DateUtil.dateToString(birthday, DateUtil.FORMAT_DAY));
        jsonObject.put("birthdayStr", DateUtil.dateToString(birthday, DateUtil.FORMAT_YYYYMMDD));
        jsonObject.put("birthplace", birthplace);
        jsonObject.put("mainDuty", mainDuty);
        jsonObject.put("cardNumber", cardNumber);
        jsonObject.put("userCode",userCode);

        String roleStr = "";
        if (null != roleList && roleList.size() > 0) {
            for (SecRole secRole : roleList) {
                roleStr += secRole.getRoleName() + "，";
            }
        }
        jsonObject.put("roleStr",roleStr.substring(0,roleStr.length()-1));
        return jsonObject;
    }

}
