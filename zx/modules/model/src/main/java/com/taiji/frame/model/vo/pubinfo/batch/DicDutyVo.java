package com.taiji.frame.model.vo.pubinfo.batch;

import com.taiji.frame.model.entity.pubinfo.batch.DicDuty;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 报送领导管理
 */
public class DicDutyVo extends DicDuty implements Jsonable,Serializable {

    /**
     * 模块id
     */
    @Setter
    @Getter
    public String dutyId;

    /**
     * 职务名称
     */
    @Getter
    @Setter
    public String leaName;


}
