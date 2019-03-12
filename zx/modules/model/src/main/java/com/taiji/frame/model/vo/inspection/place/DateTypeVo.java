package com.taiji.frame.model.vo.inspection.place;


import com.taiji.frame.model.entity.inspection.place.DateType;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author sy
 * 活动安排表
 */
public class DateTypeVo extends DateType implements Serializable {

    @Setter
    @Getter
    public String beginTimeStr;

    @Setter
    @Getter
    public String endTimeStr;

    @Setter
    @Getter
    public String placeIdStr;

}
