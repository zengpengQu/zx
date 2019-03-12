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
 * 因私护照管理
 * Created by yuLei on 2018/7/31.
 */
@Entity
@Table(name = "DM_PPM_PASSPORT", schema = "SCH_DUTY")
public class PrivatePassport extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(PrivatePassport.class);

    public PrivatePassport() {}

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
                LOG.error("获取关联对象 DicUser  dicUser 错误",e);
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
                LOG.error("获取关联对象DicDept dicDept 错误", e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 证件编号
     */
    @Getter
    @Setter
    private String passportCode;

    /**
     * 签发日期
     */
    private Date signDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setSignDate(Date signDate) {
        this.signDate = signDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getSignDate() {
        return signDate;
    }

    /**
     * 护照有效期至
     */
    private Date validDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setValidDate(Date validDate) {
        this.validDate = validDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getValidDate() {
        return validDate;
    }

    /**
     * 签发机关
     */
    @Getter
    @Setter
    private String signOrg;

    /**
     * 使用状态(0正常、1临近逾期、2已逾期）
     */
    @Getter
    @Setter
    private String useStatus;

    /**
     * 保存状态（0在库、1借出）
     */
    @Getter
    @Setter
    private String storeStatus;

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

    /**
     * 附件关联表
     */
    @Setter
    private PrivatePassportFile privatePassportFile;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "privatePassport", targetEntity = PrivatePassportFile.class)
    public PrivatePassportFile getPrivatePassportFile() {
        return privatePassportFile;
    }


    /**
     * 是否逾期or过期
     * @return
     */
    @Transient
    public String outOfDate() {
        //当前日期
        Date tempCurDate = new Date();
        //当前日期+10天
        String curDate = DateUtil.getDateStr(tempCurDate);
        //当前日期+10天
        String curDate10 = DateUtil.getDateStr(DateUtil.addDay(tempCurDate, 10));
        //当前日期+20天
        String curDate20 = DateUtil.getDateStr(DateUtil.addDay(tempCurDate, 20));
        //当前日期+6个月
        String curDate180 = DateUtil.getDateStr(DateUtil.addMonth(tempCurDate, 6));
        //截止日期
        String validDate = DateUtil.getDateStr(this.validDate);
        //行政级别
        String rankId = "";
        if (null != getDicUser().getDicParam()) {
            rankId = getDicUser().getDicParam().getId();
        }

        if (curDate.compareTo(validDate) >= 0) {//已经过期
            return "outed";
        } else {
            //局级以上人员(!!!是否退休暂时没法判断！！！)
            if (rankId.equals("8") || rankId.equals("9") || rankId.equals("10")) {
                //临近过期(指证件临近过期前六个月列表醒目提醒)
                if (curDate180.compareTo(validDate) >= 0) {
                    //临近逾期(指局级以上离退休员工20个工作日内列表逾期醒目提醒)
                    if (curDate20.compareTo(validDate) >= 0) {
                        return "out20";
                    } else {//没有逾期但临近过期
                        return "out180";
                    }
                } else {//没过期
                    return "noOut";
                }
            } else {//在职员工
                if (curDate180.compareTo(validDate) >= 0) {//临近过期(指证件临近过期前六个月列表醒目提醒)
                    if (curDate10.compareTo(validDate) >= 0) {//临近逾期(指在职员工10个工作日内列表逾期醒目标识)
                        return "out10";
                    } else {//没有逾期但临近过期
                        return "out180";
                    }
                } else {//没过期
                    return "noOut";
                }
            }
        }
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("peopleId", null == getDicUser() ? "" : getDicUser().getId());
        jsonObject.put("empName", null == getDicUser() ? "" : getDicUser().getEmpName());
        jsonObject.put("sexStr", null == getDicUser() ? "" : getDicUser().getSexStr());
        jsonObject.put("birthday", null == getDicUser() ? "" : DateUtil.dateToString(getDicUser().getBirthday(), DateUtil.FORMAT_DAY));
        jsonObject.put("birthplace", null == getDicUser() ? "" : getDicUser().getBirthplace());
        jsonObject.put("cardNumber", null == getDicUser() ? "" : getDicUser().getCardNumber());
        jsonObject.put("deptId", null == getDicDept() ? "" : getDicDept().getId());
        jsonObject.put("department", null == getDicDept() ? "" : getDicDept().getDeptName());
        jsonObject.put("passportCode", passportCode);
        jsonObject.put("signDate", DateUtil.dateToString(signDate, DateUtil.FORMAT_DAY));
        jsonObject.put("validDate", DateUtil.dateToString(validDate, DateUtil.FORMAT_DAY));
        jsonObject.put("signOrg", signOrg);
        jsonObject.put("useStatus", useStatus);
        jsonObject.put("storeStatus", storeStatus);
        if (storeStatus.equals("0")) {
            jsonObject.put("storeStatusStr", "在库");
        } else if (storeStatus.equals("1")) {
            jsonObject.put("storeStatusStr", "借出");
        }
        jsonObject.put("notes", notes);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("outOfDate", outOfDate());
        return jsonObject;
    }

}
