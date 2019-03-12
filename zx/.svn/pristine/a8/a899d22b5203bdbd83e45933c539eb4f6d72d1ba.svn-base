package com.taiji.frame.model.entity.pubinfo.batch;

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
 * @author admin
 * 板块类型
 */
@Entity
@Table(name = "PU_SUBJECT_REG", schema = "SCH_DUTY")
public class RegisterBatch extends IdEntity implements Jsonable,Serializable {


    /**
     * 内行文呈批件编码
     * */
    @Setter
    public DraftBatch draftBatch;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DraftBatch.class)
    @JoinColumn(name = "SUBJECT_ID", referencedColumnName = "ID")
    public DraftBatch getDraftBatch() {

        if(draftBatch != null)
        {
            try {
                draftBatch.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return draftBatch;
    }

    /**
     * 外行文呈批件编码
     * */
    @Setter
    public DraftBatchOut draftBatchOut;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DraftBatchOut.class)
    @JoinColumn(name = "SUBJECTOUT_ID", referencedColumnName = "ID")
    public DraftBatchOut getDraftBatchOut() {

        if(draftBatchOut != null)
        {
            try {
                draftBatchOut.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return draftBatchOut;
    }

    /**
     * 领导部门编码,暂时作废
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
     * 职务编码
     */
    @Setter
    public DicDuty dicDuty;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDuty.class)
    @JoinColumn(name = "DUTY_ID", referencedColumnName = "ID")
    public DicDuty getDicDuty() {

        if(dicDuty != null)
        {
            try {
                dicDuty.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicDuty;
    }

    /**
     * 领导姓名编码
     */
    @Setter
    public LeaderManage leaderManage;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = LeaderManage.class)
    @JoinColumn(name = "LEA_ID", referencedColumnName = "ID")
    public LeaderManage getLeaderManage(){
        if(leaderManage != null)
        {
            try {
                leaderManage.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return leaderManage;
    }

    /**
     * 领导部门名称，暂时作废
     */
    @Getter
    @Setter
    public String deptName;


    /**
     * 领导姓名
     * */
    @Getter
    @Setter
    protected String reportLeader;

    /**
     *   领导批示
     * */
    @Getter
    @Setter
    protected String conmentsLeader;

    /**
     * 领导职务名称
     */
    @Getter
    @Setter
    public String dutyName;

    /**
     *   删除标志位
     * */
    @Getter
    @Setter
    protected String delFlag;

    /**
     * 根据领导姓名进行排序
     */
    @Setter
    @Getter
    public Integer seq;

    /**
     *  表更新时间
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
        jsonObject.put("leaId",getLeaderManage() == null ? "": this.getLeaderManage().getId());
        jsonObject.put("reportLeader",getLeaderManage() == null ? "" : this.getLeaderManage().getLeaName());
        jsonObject.put("draftBatch", getDraftBatch()== null ? "" : this.getDraftBatch().getId());
        jsonObject.put("draftBatchOut", getDraftBatchOut()== null ? "" : this.getDraftBatchOut().getId());
        jsonObject.put("deptId", getDicDept() == null ? "" : this.getDicDept().getId());
        jsonObject.put("dicDuty", getDicDuty()== null ? "" : this.getDicDuty().getId());
        jsonObject.put("dutyName",dutyName);
        jsonObject.put("deptName",deptName);
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTimeStr", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("conmentsLeaer", conmentsLeader);
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("seq",seq);
        return jsonObject;
    }



}
