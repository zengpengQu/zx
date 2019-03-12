package com.taiji.frame.model.entity.pubinfo.schedule;


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
 * @author admin
 * 一周工作情况信息表
 */

@Entity
@Table(name = "PU_SCH_WORK", schema = "SCH_DUTY")
public class WeekWork extends IdEntity implements Jsonable, Serializable {

    /**
     * 综合处长会议
     */
    @Getter
    @Setter
    public String meeting;

    /**
     * 开始日期
     */
    @Setter
    public Date startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getStartDate() {
        return startDate;
    }

    /**
     * 结束日期
     */
    @Getter
    @Setter
    public Date endDate;

    /**
     * 状态(0:未下发 1：已下发 2：已反馈)
     */
    @Getter
    @Setter
    public String status;

    /**
     * 下发日期
     */
    @Getter
    @Setter
    public Date sendDate;

    /**
     * 创建时间
     */
    @Getter
    @Setter
    public Date createTime;

    /**
     * 发起单位
     * */
    @Setter
    public DicDept dicDept;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {

        if (dicDept != null) {
            try {
                dicDept.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicDept;
    }


    /**
     * 创建人
     * */
    @Getter
    @Setter
    public String createName;

    /**
     * 联系电话
     * */
    @Getter
    @Setter
    public String tel;

    /**
     * 最后更新时间
     */
    @Getter
    @Setter
    public Date updateTime;

    /**
     * 删除标志
     */
    @Getter
    @Setter
    public String delFlag;


    @Transient
    @Override
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("meeting", meeting);
        jsonObject.put("startDateStr", DateUtil.dateToString(startDate, DateUtil.FORMAT_DAY));
        jsonObject.put("endDateStr", DateUtil.dateToString(endDate, DateUtil.FORMAT_DAY));
        jsonObject.put("status", status);
        jsonObject.put("sendDateStr", DateUtil.dateToString(sendDate, DateUtil.FORMAT_DAY));
        jsonObject.put("createTimeStr", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("createName",createName);
        try {
            jsonObject.put("deptId", dicDept == null ? "" : this.getDicDept().getId());
            jsonObject.put("deptName", dicDept == null ? "" : this.getDicDept().getDeptName());
        }catch (Exception e){

        }
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT));
        jsonObject.put("tel",tel == null ? "" : tel);
        if(status!=null) {
            switch (status) {
                case "0":
                    jsonObject.put("statusStr", "待下发");
                    break;
                case "1":
                    jsonObject.put("statusStr", "待反馈");
                    break;
                default:
            }
        }
        return jsonObject;
    }
}
