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

@Entity
@Table(name = "FA_OAM_SCHEDULE" , schema = "SCH_DUTY")
public class AbroadSchedule extends IdEntity implements Jsonable , Serializable {

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
     *
     * 日期
     *
     */
    @Setter
    public Date day;
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd" , timezone = "GMT+8")
    public Date getDay() {
        return day;
    }

    /**
     *
     * 时段
     *
     */
    @Setter
    @Getter
    public String period;

    /**
     *
     * 活动安排
     *
     */
    @Setter
    @Getter
    public String content;

    /**
     *
     * 备注信息
     *
     */
    @Setter
    @Getter
    public String noteInfo;

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
        jsonObject.put("dayStr" , day==null ? "" : DateUtil.dateToString(day , DateUtil.FORMAT_DAY));
        jsonObject.put("period" , period);
        jsonObject.put("content" , content);
        jsonObject.put("noteInfo" , noteInfo);
        jsonObject.put("createTimeStr" , createTime==null ? "" : DateUtil.dateToString(createTime , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("updateTimeStr" , updateTime==null ? "" : DateUtil.dateToString(updateTime , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("delFlag", delFlag);
        return jsonObject;
    }


}
