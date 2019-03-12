package com.taiji.frame.model.vo.pubinfo.batch;

import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.schedule.DutyDaily;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import com.taiji.frame.model.vo.pubinfo.schedule.SectionVo;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * @author admin
 * 呈批件起草Vo
 * */
public class DraftBatchVo extends DraftBatch implements Jsonable,Serializable{

    @Setter
    @Getter
    private String batchDraftId;

    /**
     *  标题
     */
    @Getter
    @Setter
    public String title;

    /**
     * 流水号
     */
    @Setter
    @Getter
    public Integer serNumber;

    /**
     *   部门,暂时作废改用部门Id
     */
    @Getter
    @Setter
    public String orgName;

    /**
     * 部门Id
     */
    @Setter
    @Getter
    public String deptId;

    /**
     * 部门领导
     */
    @Getter
    @Setter
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




    /**
     * 内行文起草的时间
     */
    @Setter
    @Getter
    public String createTime;

    /**
     *  上报时间
     */
    @Getter
    @Setter
    public String sendTimeStr;

    /**
     *  结束时间
     */
    @Getter
    @Setter
    public String endTime;

    /**
     *  补录理由
     */
    @Getter
    @Setter
    public String reason;

    /**
     *  补录理由集合
     * */
    @Getter
    @Setter
    public List<DicReasonVo> dicReasonVoList;

    /**
     *  单位集合
     * */
    @Getter
    @Setter
    public List<DicDeptVo> dicDeptVoList;
}
