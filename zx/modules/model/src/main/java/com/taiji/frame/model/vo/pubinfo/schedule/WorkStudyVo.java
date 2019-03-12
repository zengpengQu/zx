package com.taiji.frame.model.vo.pubinfo.schedule;

import com.taiji.frame.model.entity.pubinfo.schedule.WorkStudy;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author admin
 * 局级领导离京和脱产学习Vo
 */
public class WorkStudyVo extends WorkStudy implements Jsonable, Serializable {

    /**
     * 反馈工作情况ID
     */
    @Getter
    @Setter
    private String feedbackId;

    /**
     * 离京和脱产学习开始日期
     */
    @Setter
    @Getter
    private String startDateStr;

    /**
     * 离京和脱产学习结束日期
     */
    @Setter
    @Getter
    private String endDateStr;
}
