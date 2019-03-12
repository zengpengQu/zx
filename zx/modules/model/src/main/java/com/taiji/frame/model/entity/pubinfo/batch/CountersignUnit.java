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

@Entity
@Table(name = "PU_SUBJECT_UNIT", schema = "SCH_DUTY")
public class CountersignUnit extends IdEntity implements Jsonable,Serializable {
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
     * 会签单位
     * @return
     */
    @Setter
    public DicDept countersignUnit;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "COUNTERSIGN_UNIT", referencedColumnName = "ID")
    public DicDept getCountersignUnit(){
        if(countersignUnit != null)
        {
            try {
                countersignUnit.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return countersignUnit;
    }

    /**
     * 会签意见
     * @return
     */
    @Getter
    @Setter
    public String countersignOpinion;

    /**
     * 会签人姓名
     * @return
     */
    @Setter
    @Getter
    public String countersignName;

    /**
     *  表更新时间
     */
    public Date updateTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setUpdateTime (Date updateTime){this.updateTime = updateTime;}

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getUpdateTime() {
        return updateTime;
    }

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("draftBatch", getDraftBatch()== null ? "" : this.getDraftBatch().getId());
        jsonObject.put("draftBatchOut", getDraftBatchOut()== null ? "" : this.getDraftBatchOut().getId());
        jsonObject.put("unitId",getCountersignUnit() == null ? "" : this.getCountersignUnit().getId());
        jsonObject.put("countersignUnit",getCountersignUnit() == null ? "" : this.getCountersignUnit().getDeptName());
        jsonObject.put("countersignOpinion",countersignOpinion);
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("countersignName",countersignName);
        jsonObject.put("updateTimeSeq", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        return jsonObject;
    }


}
