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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author qzp
 * @date 2018/08/10
 * 赴台通行证管理实体
 */
@Entity
@Table(name = "DM_PPM_TAIWAN",schema = "SCH_DUTY")
public class TaiWanCard extends IdEntity implements Jsonable,Serializable {

    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanCard.class);

    public TaiWanCard() {
    }

    /**
     * 证件持有人
     */
    @Setter
    private DicUser dicUser;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "PEOPLEINFO_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        if (dicUser != null){
            try {
                dicUser.getId();
            } catch (Exception e) {
                LOGGER.error("获取关联对象 DicUser dicUser 错误",e);
                return null;
            }
        }
        return dicUser;
    }

    /**
     * 部门ID
     */
    @Setter
    private DicDept dicDept;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "DEPT_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {
        if (dicDept != null){
            try {
                dicDept.getId();
            } catch (Exception e) {
                LOGGER.error("获取关联对象 DicDept dicDept 错误",e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 证件新旧(0:旧的、1:新的)
     */
    @Setter
    @Getter
    private String newOld;

    /**
     * 身份证号
     */
    @Setter
    @Getter
    private String idNumber;

    /**
     * 证件号码
     */
    @Setter
    @Getter
    private String permitCode;

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
     * 签发地点
     */
    @Setter
    @Getter
    private String signSite;

    /**
     * 签发机关
     */
    @Setter
    @Getter
    private String signOrg;

    /**
     * 有效期至
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
     * 是否过期(0:临近逾期、1:逾期、2:过期、3:正常)
     */
    @Setter
    @Getter
    private String isExpired;


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
        //当前日期+20天
        String curDate20 = DateUtil.getDateStr(DateUtil.addDay(tempCurDate, 20));
        //当前日期+6个月
        String curDate180 = DateUtil.getDateStr(DateUtil.addMonth(tempCurDate, 6));
        //截止日期
        String validDate = DateUtil.getDateStr(this.validDate);
        //行政级别
        if (curDate.compareTo(validDate) >= 0) {//已经过期
            return "outed";
        } else {
            if (curDate180.compareTo(validDate) >= 0) {//临近过期(指证件临近过期前六个月列表醒目提醒)
                if (curDate20.compareTo(validDate) >= 0) {//临近逾期(指在职员工20个工作日内列表逾期醒目标识)
                    return "out20";
                } else {//没有逾期但临近过期
                    return "out180";
                }
            } else {//没过期
                return "noOut";
            }
        }
    }



    /**
     * 保管机构
     */
    @Setter
    @Getter
    private String keepOrg;

    /**
     * 是否借出(0:交来、1:借出、2:归还)
     */
    @Getter
    @Setter
    private String isBorrow;

    /**
     * 附件关联表
     */
    @Setter
    private TaiWanCardFile taiWanCardFile;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "taiWanCard", targetEntity = TaiWanCardFile.class)
    public TaiWanCardFile getTaiWanCardFile() {
        return taiWanCardFile;
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
    @Setter
    @Getter
    private String notes;

    /**
     * 删除标志(0未删除、1已删除)
     */
    @Setter
    @Getter
    private String delFlag;


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("empName",getDicUser().getEmpName());
        jsonObject.put("deptName",getDicDept().getDeptName());
        jsonObject.put("department",getDicUser().getDicDept().getDeptName());
        jsonObject.put("sex",getDicUser().getSexStr());
        jsonObject.put("birthday",DateUtil.dateToString(getDicUser().getBirthday(), DateUtil.FORMAT_DAY));
        jsonObject.put("newOld",newOld);
        jsonObject.put("idNumber",idNumber);
        jsonObject.put("permitCode",permitCode);
        jsonObject.put("signDate",DateUtil.dateToString(signDate, DateUtil.FORMAT_DAY));
        jsonObject.put("signSite",signSite);
        jsonObject.put("signOrg",signOrg);
        jsonObject.put("validDate",DateUtil.dateToString(validDate, DateUtil.FORMAT_DAY));
        jsonObject.put("isExpired",isExpired);
        jsonObject.put("outOfDate",outOfDate());
        jsonObject.put("keepOrg",keepOrg);
        jsonObject.put("isBorrow",isBorrow);
        jsonObject.put("createTime",DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTime",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("notes",notes);
        jsonObject.put("delFlag",delFlag);
        return jsonObject;
    }
}
