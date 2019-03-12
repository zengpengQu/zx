package com.taiji.frame.model.entity.pubinfo.batch;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.schedule.Section;
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
 * 呈批件起草内行文
 */
@Entity
@Table(name = "PU_INSIDE_SUBJECT", schema = "SCH_DUTY")
public class DraftBatch extends IdEntity implements Jsonable, Serializable {

    /**
     * 会签单位编码改为：报送部门编码
     */
    @Setter
    public DicDept dicDept;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {

        if(dicDept != null)
        {
            try {
                dicDept.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 理由编码
     * */
    @Setter
    public DicReason dicReason;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicReason.class)
    @JoinColumn(name = "REASON_ID", referencedColumnName = "ID")
    public DicReason getDicReason() {

        if(dicReason != null)
        {
            try {
                dicReason.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicReason;
    }


    /**
     * 流水号
     */
    @Setter
    @Getter
    public Integer serNumber;

    /**
     *  会签意见
     */
    @Getter
    @Setter
    public String counterSignOpinion;


    /**
     *  标题
     */
    @Getter
    @Setter
    public String title;

    /**
     *   部门，此字段暂时作废
     */
    @Getter
    @Setter
    public String orgName;

    /**
     *  部门领导
     */
    @Setter
    @Getter
    public String depLeader;

    /**
     * 	拟稿人
     */
    @Getter
    @Setter
    public String reporter;

    /**
     * 	核稿人
     */
    @Getter
    @Setter
    public String checker;

    /**
     *  联系电话
     */
    @Getter
    @Setter
    public String tel;

    /**
     *   会签单位
     */
    @Getter
    @Setter
    public String counterSignUnit;

    /**
     *   是否会签（0否1是）
     */
    @Getter
    @Setter
    public String counterSignFlag;

    @Transient
    public String getCounterSignFlagStr() {
        if (null == counterSignFlag) {
            return "未知";
        } else if (counterSignFlag.equals("1")) {
            return "是";
        } else if (counterSignFlag.equals("0")) {
            return "否";
        } else {
            return "未知";
        }
    }

    /**
     *  状态(0未上报，1已核稿，2已上报，3已查收，4已办结)
     */
    @Getter
    @Setter
    public String status;

    /**
     *  删除标志位
     */
    @Getter
    @Setter
    public String delFlag;

    /**
     * 中介单位，获取到当前单位的第二级,用于领导批示导出
     */
    @Getter
    @Setter
    public String mediUnit;

    /**
     *  上报时间
     */
    public Date sendTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setSendTime (Date sendTime){this.sendTime = sendTime;}

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getSendTime() {
        return sendTime;
    }

    /**
     *  呈批件更新的时间
     */
    public Date updateTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setUpdateTime (Date updateTime){this.updateTime = updateTime;}

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getUpdateTime() {
        return updateTime;
    }

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("deptId", getDicDept() == null ? "" : this.getDicDept().getId());
        jsonObject.put("orgName", getDicDept() == null ? "" : getDicDept().getDeptName());
        jsonObject.put("dicReason", getDicReason() == null ? "" : this.getDicReason().getId());
        jsonObject.put("counterSignOpinion", counterSignOpinion);
        jsonObject.put("title",title);
        jsonObject.put("reporter", reporter);
        jsonObject.put("checker", checker);
        jsonObject.put("tel", tel);
        jsonObject.put("counterSignUnit", counterSignUnit);
        jsonObject.put("counterSignFlag", counterSignFlag);
        jsonObject.put("counterSignFlagStr",this.getCounterSignFlagStr());
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("sendTime", DateUtil.dateToString(sendTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTimeIndex", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTimeSeq", DateUtil.dateToString(sendTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("status", status);
        jsonObject.put("depLeader",depLeader);
        jsonObject.put("serNumber",depLeader);
        jsonObject.put("mediUnit",mediUnit);
        String statusName = "";
        if ("0".equals(status)) {
            statusName = "未上报";
        } else if ("1".equals(status)) {
            statusName = "已上报";
        } else if ("2".equals(status)){
            statusName = "已查收";
        }

        String indexStatusName = "";
        switch (status){
            case "0":
                indexStatusName = "待核稿";
                break;
            case "1":
                indexStatusName = "已核稿待上报";
                break;
            case "2":
                indexStatusName = "已上报待查收";
                break;
            case "3":
                indexStatusName = "已查收待办结";
                break;
            case "4":
                indexStatusName = "已办结";
                break;
                default:
        }
        jsonObject.put("indexStatusName", indexStatusName);

        return jsonObject;
    }

}
