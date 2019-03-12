package com.taiji.frame.model.vo.pubinfo.schedule;

import com.taiji.frame.model.entity.pubinfo.schedule.DutyDaily;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

/**
 * @author admin
 * 值班日志Vo
 * */
public class DutyDailyVo extends DutyDaily implements Jsonable,Serializable{

    /**
     * 单位ID
     * */
    @Getter
    @Setter
    public String deptId;

    /**
     * 单位名称
     * */
    @Getter
    @Setter
    public String deptName;

    /**
     * 值班员ID
     * */
    @Getter
    @Setter
    public String userId;

    /**
     * 值班员姓名
     * */
    @Getter
    @Setter
    public String userName;

    /**
     * 板块ID
     * */
    @Getter
    @Setter
    public String sectionId;

    /**
     * 板块名称
     * */
    @Getter
    @Setter
    public String sectionName;

    /**
     * 填报日期字符串格式
     * */
    @Getter
    @Setter
    public String createTimeStr;

    /**
     * 板块信息
     * */
    @Getter
    @Setter
    public List<SectionVo> sectionVoList;
}
