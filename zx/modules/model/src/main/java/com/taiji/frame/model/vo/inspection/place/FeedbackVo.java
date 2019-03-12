package com.taiji.frame.model.vo.inspection.place;

import com.taiji.frame.model.entity.inspection.place.Feedback;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author sy
 * */
public class FeedbackVo extends Feedback implements Jsonable,Serializable{

    /**
     * 活动安排Id
     */
    @Setter
    @Getter
    public String placeId;
    /**
     * 反馈信息Id
     */
    @Setter
    @Getter
    public String feedbackId;


    /**
     * 部门Id
     */
    @Setter
    @Getter
    public String deptId;
    /**
     * 活动状态
     */
    @Setter
    @Getter
    public String reportState;
    /**
     * 活动标题
     */
    @Setter
    @Getter
    public String title;
    /**
     * 活动性质
     */
    @Setter
    @Getter
    public String actTypeId;
    /**
     * 承办单位
     */
    @Setter
    @Getter
    public String dicdeptName;


    /**
     * 开始时间
     */
    @Setter
    @Getter
    public String beginTimeStr;

    /**
     * 结束时间
     */
    @Setter
    @Getter
    public String endTimeStr;

    /**
     * 判断是何操作
     */
    @Setter
    @Getter
    public String ifFeedback;


}
