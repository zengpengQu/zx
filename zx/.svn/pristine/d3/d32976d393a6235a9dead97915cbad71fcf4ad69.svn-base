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
@Table(name = "FA_OAM_PREPARMEET" , schema = "SCH_DUTY")
public class AbroadPreparment extends IdEntity implements Jsonable, Serializable {

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
     * 会议名称
     *
     */
    @Setter
    @Getter
    public String meetingName;

    /**
     *
     * 会议日期
     *
     */
    @Setter
    public Date meetingDate;
    @DateTimeFormat(pattern ="yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd" , timezone = "GMT+8")
    public Date getMeetingDate() {
        return meetingDate;
    }

    /**
     *
     * 会议时间
     *
     */
    @Setter
    @Getter
    public String meetingTime;

    /**
     *
     * 会议地点
     *
     */
    @Setter
    @Getter
    public String meetingPlace;

    /**
     *
     * 参会人员
     *
     */
    @Setter
    @Getter
    public String attendees;

    /**
     * 文件原始名称
     */
    @Setter
    @Getter
    public String realName;

    /**
     * 文件存储路径
     */
    @Setter
    @Getter
    public String fileDir;

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
        jsonObject.put("meetingName" , meetingName);
        jsonObject.put("meetingDateStr" , meetingDate==null ? "" : DateUtil.dateToString(meetingDate , DateUtil.FORMAT_DAY));
        jsonObject.put("meetingTime" , meetingTime);
        jsonObject.put("meetingPlace" , meetingPlace);
        jsonObject.put("attendees" , attendees);
        jsonObject.put("realName", realName);
        jsonObject.put("fileDir", fileDir);
        jsonObject.put("uuidName", fileDir==null ? "" : fileDir.substring(fileDir.lastIndexOf("\\") + 1));
        jsonObject.put("createTimeStr" , createTime==null ? "" : DateUtil.dateToString(createTime , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("updateTimeStr" , updateTime==null ? "" : DateUtil.dateToString(updateTime , DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("delFlag", delFlag);
        return jsonObject;
    }

}
