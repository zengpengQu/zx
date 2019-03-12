package com.taiji.frame.model.vo.pubinfo.batch;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.batch.LeaderManage;
import com.taiji.frame.model.entity.pubinfo.batch.RegisterBatch;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author wsh
 * 呈批件流转登记
 * */
public class RegisterBatchVo extends RegisterBatch implements Jsonable,Serializable{

    /**
     * 流转登记的编码
     */
    @Setter
    @Getter
    private String batchDraftRegId;

    /**
     * 流转登记的编码
     */
    @Setter
    @Getter
    private String batchDraftDetId;


    /**
     * 报送领导
     * */
    @Getter
    @Setter
    protected String reportLeader;

    /**
     * 职务名称
     */
    @Getter
    @Setter
    public String dutyName;

    /**
     *   领导批示
     * */
    @Getter
    @Setter
    protected String conmentsLeader;

    /**
     * 报送部门名称
     */
    @Setter
    @Getter
    public String deptName;

    /**
     * 呈批件标题
     */
    @Getter
    @Setter
    public String title;

    /**
     * 内行文id
     */
    @Setter
    @Getter
    public String batchId;

    /**
     * 外行文id
     */
    @Setter
    @Getter
    public String batchOutId;

    /**
     * 领导批示的时间,原来的
     */
    @Getter
    @Setter
    public String updateTimeStr;


    /**
     *  职务集合
     * */
    @Getter
    @Setter
    public List<DicDutyVo> dicDutyVoList;

    /**
     * 领导批示集合
     */
    @Getter
    @Setter
    public List<LeaderConmentsVo> LeaderConmentsList;

    /**
     * 领导姓名的集合
     */
    @Setter
    @Getter
    public List<LeaderManageVo> leaderManageList;

    /*@Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("updateTimeSeq",updateTimeStr);
        return jsonObject;
    }*/

}
