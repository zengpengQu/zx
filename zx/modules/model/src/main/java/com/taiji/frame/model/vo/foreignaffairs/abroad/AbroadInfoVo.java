package com.taiji.frame.model.vo.foreignaffairs.abroad;

import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class AbroadInfoVo extends AbroadInfo implements Jsonable,Serializable {
    @Getter
    @Setter
    public String groupLevelId;

    @Getter
    @Setter
    public String groupLevelName;

    @Getter
    @Setter
    public String startDateStr;

    @Getter
    @Setter
    public String endDateStr;

    @Getter
    @Setter
    public String orgId;

    @Getter
    @Setter
    public String orgName;

    @Getter
    @Setter
    public String abroadTaskId;

    @Getter
    @Setter
    public String abroadTaskName;

    @Getter
    @Setter
    public String costSourceId;

    @Getter
    @Setter
    public String costSourceName;


    @Getter
    @Setter
    public String startTime;

    @Getter
    @Setter
    public String endTime;

    @Getter
    @Setter
    public String leaderName;

    @Getter
    @Setter
    public String leaderId;

    @Getter
    @Setter
    public String outDeptName;

}
