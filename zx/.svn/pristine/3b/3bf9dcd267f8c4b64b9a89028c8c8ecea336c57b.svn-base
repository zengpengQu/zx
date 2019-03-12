package com.taiji.frame.model.entity.foreignaffairs.abroad;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
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
 * @author Zbf
 * Created by Zbf on 2018/06/21
 * 日程‘时’‘分’
 */
@Entity
@Table(name = "FA_OAM_SCHEDULE_SPECIFIC" , schema = "SCH_DUTY")
public class ScheduleSpecific extends IdEntity implements Jsonable, Serializable {

    //0.通过继承IdEntity获得ID

    /**
     * 1.
     * 日程信息
     *
     */
    @Setter
    public AbroadSchedule abroadSchedule;
    @ManyToOne(fetch = FetchType.LAZY , targetEntity = AbroadSchedule.class)
    @JoinColumn(name = "SCHEDULE_ID" , referencedColumnName = "ID")
    public AbroadSchedule getAbroadSchedule() {
        return abroadSchedule;
    }


    /**
     * 2.
     * 日程小时分钟
     *
     */
    @Setter
    public Date scheduleTime;
    @DateTimeFormat(pattern = "HH:mm")
    @JsonFormat(pattern = "HH:mm" , timezone = "GMT+8")
    public Date getScheduleTime() {
        return scheduleTime;
    }

    /**
     * 3.
     * 时段选择 0:不选择 1：上午 2：下午 3：全天
     *
     */
    @Setter
    public Period period;
    @ManyToOne(fetch = FetchType.LAZY , targetEntity = Period.class)
    @JoinColumn(name = "PERIOD_ID" , referencedColumnName = "ID")
    public Period getPeriod() {
        return period;
    }

    /**
     * 4.
     * 具体信息
     *
     */
    @Setter
    @Getter
    public String specificInfo;

    /**
     * 5.
     * 删除标记 0:显示 1：删除
     *
     */
    @Setter
    @Getter
    public String delFlag;


    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("scheduleSpecificId" , id);
        jsonObject.put("scheduleId" , abroadSchedule.getId());
        jsonObject.put("scheduleTime" , DateUtil.dateToString(scheduleTime , DateUtil.FORMAT_TIME_SHORT));
        jsonObject.put("periodId" , period.getId());
        jsonObject.put("period" , period.getPeriod());
        jsonObject.put("specificInfo" , specificInfo);
        jsonObject.put("delFlag" , delFlag);

        return jsonObject;
    }
}
