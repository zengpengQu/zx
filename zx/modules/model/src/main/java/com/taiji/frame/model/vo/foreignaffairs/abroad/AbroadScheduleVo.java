package com.taiji.frame.model.vo.foreignaffairs.abroad;

import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadSchedule;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class AbroadScheduleVo extends AbroadSchedule implements Jsonable,Serializable {

    @Getter
    @Setter
    public String abroadInfoId;

    @Setter
    @Getter
    public String dayStr;

}
