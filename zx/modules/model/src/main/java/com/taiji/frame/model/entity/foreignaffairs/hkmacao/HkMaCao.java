package com.taiji.frame.model.entity.foreignaffairs.hkmacao;

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
import java.util.Date;

/**
 * @author qzp
 * @date 2018/08/01
 * 港澳通行证管理
 */
@Entity
@Table(name = "DM_PPM_HKMACAO",schema = "SCH_DUTY")
public class HkMaCao extends IdEntity implements Jsonable {

    private static final Logger log = LoggerFactory.getLogger(HkMaCao.class);

    /**
     * 人员ID
     */
    @Setter
    private DicUser dicUser;
    @ManyToOne(fetch = FetchType.LAZY,targetEntity = DicUser.class)
    @JoinColumn(name = "PEOPLEINFO_ID",referencedColumnName = "ID")
    public DicUser getDicUser() {
        if (dicUser != null){
            try {
                dicUser.getId();
            }catch (Exception e){
                log.error("获取关联对象 DicUser dicUser 错误",e);
                return null;
            }
        }
        return dicUser;
    }

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
     * 签发机关
     */
    @Setter
    @Getter
    private String signOrg;

    /**
     * 使用状态(0正常、1临近逾期、2已逾期)
     */
    @Setter
    @Getter
    private String useStatus;

    /**
     * 保管状态(0在库、1借出)
     */
    @Setter
    @Getter
    private String storeStatus;

    /**
     * 备注
     */
    @Setter
    @Getter
    private String notes;

    /**
     * 创建时间
     */
    private Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
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
     * 删除标志(0未删除、1已删除)
     */
    @Setter
    @Getter
    private String delFlag;

    /**
     * 工作部门
     */
    public DicDept dicDept;

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
                log.error("获取关联对象DicDept dicDept 错误", e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 销毁状态(0未销毁、1已销毁)
     */
    @Setter
    @Getter
    private String destroy;


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("dicUser",getDicUser().getEmpName());
        jsonObject.put("permitCode",permitCode);
        jsonObject.put("signDateStr",DateUtil.dateToString(signDate, DateUtil.FORMAT_DAY));
        jsonObject.put("validDateStr",DateUtil.dateToString(validDate, DateUtil.FORMAT_DAY));
        jsonObject.put("signOrg",signOrg);
        jsonObject.put("useStatus", useStatus);
        jsonObject.put("storeStatus",storeStatus);
        jsonObject.put("notes",notes);
//        jsonObject.put("createTime",DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTime",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTimeStr",DateUtil.dateToString(updateTime, DateUtil.FORMAT_TIME));
        jsonObject.put("delFlag",delFlag);
        jsonObject.put("deptId", null == getDicDept() ? "" : getDicDept().getId());
        jsonObject.put("department", null == getDicDept() ? "" : getDicDept().getDeptName());
        jsonObject.put("destroy", destroy);
        return jsonObject;
    }
}
