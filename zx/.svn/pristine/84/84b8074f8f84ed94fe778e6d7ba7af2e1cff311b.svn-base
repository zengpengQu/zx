package com.taiji.frame.model.entity.pubinfo.schedule;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author admin
 * 下周局级领导带班情况信息表
 */

@Entity
@Table(name = "PU_SCH_WORK_GUIDE", schema = "SCH_DUTY")
public class WorkGuide extends IdEntity implements Jsonable, Serializable {

    /**
     * 工作情况编码
     */
    @Setter
    public WorkFeedback workFeedback;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = WorkFeedback.class)
    @JoinColumn(name = "FEEDBACK_ID", referencedColumnName = "ID")
    public WorkFeedback getWorkFeedback() {
        if (workFeedback != null) {
            try {
                workFeedback.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return workFeedback;
    }

    /**
     * 姓名
     */
    @Setter
    @Getter
    public String name;


    /**
     * 开始时间
     */
    @Setter
    @Getter
    public Date startDate;


    /**
     * 手机号
     */
    @Setter
    @Getter
    public String phone;


    /**
     * 结束时间
     */
    @Setter
    @Getter
    public Date endDate;


    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Setter
    @Getter
    public String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("feedbackId", getWorkFeedback() == null ? "" : this.getWorkFeedback().getId());
        jsonObject.put("name", getName() == null ? "" : getName());
        jsonObject.put("startDateStr", DateUtil.dateToString(startDate, DateUtil.FORMAT_DAY));
        jsonObject.put("phone", getPhone() == null ? "" : getPhone());
        jsonObject.put("endDateStr", DateUtil.dateToString(endDate, DateUtil.FORMAT_DAY));

        return jsonObject;
    }
}

