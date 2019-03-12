package com.taiji.frame.model.vo.pubinfo.batch;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatchOut;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author wsh 2018-9-12
 * 呈批件外来文Vo
 * */
public class DraftBatchOutVo extends DraftBatchOut implements Jsonable,Serializable{


    /**
     *  来文单位
     */
    @Getter
    @Setter
    public String orgName;

    /**
     * 承办部门,暂时废除
     */
    @Getter
    @Setter
    public String deptName;

    /**
     * 使用承办方部门ID
     */
    @Setter
    @Getter
    public String orgId;

    /**
     * 承办部门领导
     */
    @Getter
    @Setter
    public String depLeader;

    /**
     *  联系电话
     */
    @Getter
    @Setter
    public String tel;

    /**
     *  标题
     */
    @Getter
    @Setter
    public String title;

    /**
     *  承办人（处室）
     */
    @Getter
    @Setter
    public String contractor;
    /**
     * 流水号
     */
    @Setter
    @Getter
    public Integer serNumber;

    /**
     *  审核人
     */
    @Getter
    @Setter
    public String approver;

    /**
     * 内行文起草的时间
     */
    @Setter
    @Getter
    public String createTime;

    /**
     *  是否会签（0否1是）
     */
    @Getter
    @Setter
    public String counterSignFlag;

    /**
     *  会签单位
     */
    @Getter
    @Setter
    public String counterSignUnit;

    /**
     *  编号
     */
    @Getter
    @Setter
    public String number;

    /**
     *  删除标志位
     */
    @Getter
    @Setter
    public String delFlag;
    /**
     *  状态(0未上报，1已上报，2已领取)
     */
    @Getter
    @Setter
    public String status;
    /**
     *  结束时间
     */
    @Getter
    @Setter
    public String endTime;

    /**
     *  查询开始时间
     */
    @Getter
    @Setter
    public String startDateWai;
    /**
     *  查询结束时间
     */
    @Getter
    @Setter
    public String endDateWai;

    /**
     * 查询 签报人
     */
    @Getter
    @Setter
    public String reporterWai;

    /**
     *  补录理由
     */
    @Getter
    @Setter
    public String reason;

    @Getter
    @Setter
    public List<DicReasonVo> dicReasonVoOutList;

    /**
     *  会签部门集合
     * */
    @Getter
    @Setter
    public List<DicDeptVo>dicDeptOutVoList ;
    /**
     *  承办部门集合
     * */
    @Getter
    @Setter
    public List<DicDeptVo>underUnitOutVoList ;
}
