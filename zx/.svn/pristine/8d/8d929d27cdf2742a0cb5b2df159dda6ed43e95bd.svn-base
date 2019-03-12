package com.taiji.frame.model.entity.pubinfo.schedule;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
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
 * 领导活动安排会议通知信息表
 */
@Entity
@Table(name = "PU_ACTIVITY_SCH", schema = "SCH_DUTY")
public class ActivityPlan extends IdEntity implements Jsonable, Serializable {

    /**
     * 是否开会（0：开会 1：不开会）
     */
    @Getter
    @Setter
    public String meetingFlag;

    /**
     * 会议内容
     */
    @Getter
    @Setter
    public String content;

    /**
     * 状态(0未下发，1已下发，2已反馈)
     */
    @Getter
    @Setter
    public String status;

    /**
     * 下发时间
     */
    @Getter
    @Setter
    public Date sendTime;

    /**
     * 是否删除
     */
    @Getter
    @Setter
    public String delFlag;

    /**
     * 创建时间
     */
    @Getter
    @Setter
    public Date createTime;

    /**
     * 更新时间
     */
    @Getter
    @Setter
    public Date updateTime;

    /**
     * 创建人
     */
    @Setter
    public DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "CREATE_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {

        if (dicUser != null) {
            try {
                dicUser.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicUser;
    }

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

    @Getter
    @Setter
    public String tel;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("meetingFlag", meetingFlag);
        jsonObject.put("content", content);
       /* StringBuffer w = new StringBuffer();
        for(int i=0;i<content.length()-1;i++){
            String c = content.substring(i,i+1);
            if(c.compareTo("\u4e00")>0 && c.compareTo("\u9fa5")<0){
                w.append(c);
                if(w.length()>9){
                    break;
                }
            }
        }
        w.append("....");
        jsonObject.put("contentStr", w.toString());*/
        jsonObject.put("status", status);
        jsonObject.put("sendTimeStr", sendTime == null ? "" : DateUtil.dateToString(sendTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("createTimeStr", createTime == null ? "" : DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTimeStr", updateTime == null ? "" : DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        try {
            jsonObject.put("createId", dicUser == null ? "" : dicUser.getId());
            jsonObject.put("createName", dicUser == null ? "" : dicUser.getEmpName());
            jsonObject.put("tel",tel == null ? "" : tel);
            jsonObject.put("deptId",null == dicDept ? "" : dicDept.getId());
            jsonObject.put("deptName",null == dicDept ? "" : dicDept.getDeptName());
        }catch (Exception e){
        }


        String meetingFlagName = "";

        if ("0".equals(meetingFlag)) {
            meetingFlagName = "开会";
        } else {
            meetingFlagName = "不开会";
        }
        jsonObject.put("meetingFlagName",meetingFlagName);
        if(status!=null) {
            switch (status) {
                case "0":
                    jsonObject.put("activityStatusStr", "待修改 下发");
                    break;
                case "1":
                    jsonObject.put("activityStatusStr", "待反馈");
                    break;
                default:
            }
        }
        return jsonObject;
    }
}
