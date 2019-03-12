package com.taiji.frame.model.vo.pubinfo.schedule;

import com.taiji.frame.model.entity.pubinfo.schedule.WorkFeedback;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.Transient;
import java.io.Serializable;
import java.util.List;

/**
 * @author pengyx
 */
public class WorkFeedbackVo extends WorkFeedback implements Jsonable, Serializable {

    /**
     * 一周工作情况ID
     */
    @Getter
    @Setter
    private String workId;

    /**
     * 反馈部门ID
     */
    @Getter
    @Setter
    private String deptId;

    /**
     * 参会人员ID
     * */
    @Getter
    @Setter
    private String participantsId;

    /**
     * 反馈部门名称
     */
    @Getter
    @Setter
    private String deptName;

    /**
     * 报送日期
     * */
    @Getter
    @Setter
    private String feedbackDateStr;

    /**
     * 局级领导带班情况
     * */
    @Getter
    @Setter
    List<WorkGuideVo> workGuideList;

    /**
     * 局级领导离京和脱产学习
     * */
    @Getter
    @Setter
    List<WorkStudyVo> workStudyList;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", getId());
        jsonObject.put("feedbackDateStr", feedbackDateStr);

        return jsonObject;
    }
}
