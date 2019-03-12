package com.taiji.frame.model.vo.inspection.place;

import com.taiji.frame.model.entity.inspection.place.Place;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

/**
 * @author sy
 * 值班日志Vo
 * */
public class PlaceVo extends Place implements Jsonable,Serializable{

    /**
     * 部门Id
     */
    @Setter
    @Getter
    public String deptName;
    /**
     * 状态
     */
    @Setter
    @Getter
    public String correctPlace;

    /**
     * 年度
     */
    @Setter
    @Getter
    public String nowTimeStr;


    /**
     * 类别
     */
    @Setter
    @Getter
    public String actTypeName;

    /**
     * 上报时间
     */
    @Getter
    @Setter
    public String createTimeStr;
    /**
     * 反馈信息ID
     */
    @Getter
    @Setter
    public String feedbackId;

    @Getter
    @Setter
    private List<DateTypeVo> dateTypeList;

}
