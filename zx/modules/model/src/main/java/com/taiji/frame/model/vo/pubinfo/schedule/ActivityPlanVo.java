package com.taiji.frame.model.vo.pubinfo.schedule;

import com.taiji.frame.model.entity.pubinfo.schedule.ActivityPlan;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author admin
 * 领导活动安排
 */

public class ActivityPlanVo extends ActivityPlan implements Jsonable, Serializable {

    /**
     * 开始日期
     */
    @Getter
    @Setter
    private String startDateStr;

    /**
     * 结束日期
     */
    @Getter
    @Setter
    private String endDateStr;

    /**
     * 下发日期
     */
    @Getter
    @Setter
    private String sendTimeStr;

    /**
     * 创建时间
     */
    @Getter
    @Setter
    private String createTimeStr;

    /**
     * 创建人ID
     */
    @Getter
    @Setter
    private String creatorId;

    /**
     * 创建人姓名
     */
    @Getter
    @Setter
    private String creatorName;

}