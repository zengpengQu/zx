package com.taiji.frame.model.entity.pubinfo.supervision;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
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
 * @author qzp
 * @date 2018/08/23
 * 督查事项表
 */
@Entity
@Table(name = "PU_SUPERVISION_MATTER",schema = "SCH_DUTY")
public class SupervisionMatter extends IdEntity implements Jsonable,Serializable {

    /**
     * 督查事项
     */
    @Setter
    @Getter
    private String supMatter;

    /**
     * 主办单位
     */
    @Setter
    private DicDept hostUnit;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "HOST_UNIT_ID", referencedColumnName = "ID")
    public DicDept getHostUnit() {
        if(hostUnit != null){
            try {
                hostUnit.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return hostUnit;
    }

    /**
     * 协作单位
     */
    @Setter
    private DicDept cooperative;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "COOPERATIVE_UNIT_ID", referencedColumnName = "ID")
    public DicDept getCooperative() {
        if(cooperative != null){
            try {
                cooperative.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return cooperative;
    }

    /**
     * 状态
     * (0:未下发 1：已下发 2：已反馈)
     */
    @Setter
    @Getter
    private String status;

    /**
     * 办理要求
     */
    @Setter
    @Getter
    private String requirements;

    /**
     * 督查事项编号
     */
    @Setter
    @Getter
    private String serialNumber;

    /**
     * 下发日期
     */
    private Date issuedDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setIssuedDate(Date issuedDate) {
        this.issuedDate = issuedDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getIssuedDate() {
        return issuedDate;
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

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("supMatter",supMatter);
        jsonObject.put("hostUnitId",getHostUnit() == null ? "" : this.getHostUnit().getId());
        jsonObject.put("hostUnitName",getHostUnit() == null ? "" : this.getHostUnit().getDeptName());
        jsonObject.put("cooperativeId",getCooperative() == null ? "" : this.getCooperative().getId());
        jsonObject.put("cooperativeName",getCooperative() == null ? "" : this.getCooperative().getDeptName());
        jsonObject.put("status",status);
        String statusName = "";
        if ("0".equals(status)){
            statusName = "未下发";
        }else if ("1".equals(status)){
            statusName = "已下发";
        }else if ("2".equals(status)){
            statusName = "已反馈";
        }
        jsonObject.put("statusName",statusName);
        jsonObject.put("requirements",requirements);
        jsonObject.put("serialNumber",serialNumber);
        jsonObject.put("issuedDate",DateUtil.dateToString(issuedDate, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTime",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag",delFlag);
        return jsonObject;
    }
}
