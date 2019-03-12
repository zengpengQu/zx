package com.taiji.frame.model.entity.foreignaffairs.council;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.hibernate.annotations.Where;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author sy
 * Created by suny on 2018/7/4.
 * 局务会议实体类
 */

@Entity
@Table(name = "OM_BFA_MEETING", schema = "SCH_DUTY")
public class Congress extends IdEntity implements Jsonable, Serializable {

    /**
     * 会议标题
     */
    @Getter
    @Setter
    public String title;

    /**
     * 会议内容
     */
    @Getter
    @Setter
    public String content;

    /**
     * 会议时间
     */
    @Setter
    public Date time;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getTime() {
        return time;
    }

    /**
     * 会议地点
     */
    @Getter
    @Setter
    public String meetingSite;

    /**
     * 参加会议人员
     */
    @Getter
    @Setter
    public String  attendence;

    /**
     * 局务会议信息
     */
    @Setter
    private List<Attendance> attendanceList;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "meetingId", targetEntity = Attendance.class)
    @Where(clause = "DEL_FLAG = 0")
    public List<Attendance> getAttendanceList() {
        return attendanceList;
    }

    /**
     * 会议其它内容
     */
    @Getter
    @Setter
    public String  other;

    /**
     * 创建时间
     */
    @Setter
    public Date  catTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getCatTime() {
        return catTime;
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
        jsonObject.put("title", title);
        jsonObject.put("content", content);
        jsonObject.put("meetingSite", meetingSite);
        //参会人员，出勤状态为正常的显示
        String str = "";
        if(null != attendanceList && attendanceList.size()>0) {
            for (Attendance attendance : attendanceList) {
                if ("正常".equals(attendance.getAttendEnce())) {
                    str += attendance.getAttendName() + "，";
                }
            }
        }
        if (!"".equals(str)) {
            str = str.substring(0,str.length()-1);
        }
        jsonObject.put("attendence", attendence);
        jsonObject.put("other", other);
        jsonObject.put("catTime", DateUtil.dateToString(catTime, DateUtil.FORMAT_DAY));
        jsonObject.put("time", DateUtil.dateToString(time, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag",delFlag);
        return jsonObject;
    }

}
