package com.taiji.frame.model.entity.pubinfo.batch;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @author admin
 * 板块类型
 */
@Entity
@Table(name = "PU_SUBJECT_REG", schema = "SCH_DUTY")
public class RegisterBatchOut extends IdEntity implements Jsonable,Serializable {


    /**
     * 呈批件编码
     * */
    @Setter
    public DraftBatchOut draftBatchOut;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DraftBatch.class)
    @JoinColumn(name = "SUBJECT_ID", referencedColumnName = "ID")
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
     *   删除标志位
     * */
    @Getter
    @Setter
    protected String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("draftBatch", getDraftBatchOut()== null ? "" : this.getDraftBatchOut().getId());
        jsonObject.put("reportLeader",reportLeader);
        jsonObject.put("conmentsLeaer", conmentsLeader);
        jsonObject.put("delFlag", delFlag);
        return jsonObject;
    }



}
