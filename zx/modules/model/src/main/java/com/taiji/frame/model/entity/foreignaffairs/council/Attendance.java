package com.taiji.frame.model.entity.foreignaffairs.council;

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
 * Created by suny on 2018/7/4.
 * @author sy
 * 会议出勤情况表
 */

@Entity
@Table(name = "OM_BFA_ATTENDANCE" , schema = "SCH_DUTY")
public class Attendance  extends IdEntity implements Jsonable, Serializable {

    /**
     * 局务会议标题
     */
    @Getter
    @Setter
    public String meetingTitle;

    /**
     * 出勤人员名字
     */
    @Getter
    @Setter
    public String attendName;

    /**
     * 职务
     */
    @Getter
    @Setter
    public String attendDuty;

    /**
     * 出勤情况(0:表示正常，1：出差，2：休假，3事假，4；病假，5缺席)
     */
    @Getter
    @Setter
    public String attendEnce;

    /**
     * 缺勤原因
     */
    @Getter
    @Setter
    public String attendOther;

    /**
     * 出勤时间
     */
    @Setter
    public Date attendTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getAttendTime() {
        return attendTime;
    }

    /**
     * 局务会议出勤情况
     */
    @Setter
    public  Congress meetingId;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = Congress.class)
    @JoinColumn(name = "MEETING_ID", referencedColumnName = "ID")
    public Congress getMeetingId() {
        return meetingId;
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
        jsonObject.put("id", id);
        jsonObject.put("meetingTitle", meetingTitle);
        jsonObject.put("attendName", attendName);
        jsonObject.put("attendDuty", attendDuty);
        if(attendEnce!=null) {
            switch (attendEnce) {
                case "0":
                    jsonObject.put("attendEnce", "正常");
                    break;
                case "1":
                    jsonObject.put("attendEnce", "出差");
                    break;
                case "2":
                    jsonObject.put("attendEnce", "休假");
                    break;
                case "3":
                    jsonObject.put("attendEnce", "事假");
                    break;
                case "4":
                    jsonObject.put("attendEnce", "病假");
                    break;
                case "5":
                    jsonObject.put("attendEnce", "缺席");
                    break;
                default:
                    jsonObject.put("attendEnce", "");
            }
        }else {
            jsonObject.put("attendEnce", "");
        }
        jsonObject.put("attendTime", DateUtil.dateToString(attendTime, DateUtil.FORMAT_DAY));
        jsonObject.put("attendOther", attendOther);
        return jsonObject;
    }
}
