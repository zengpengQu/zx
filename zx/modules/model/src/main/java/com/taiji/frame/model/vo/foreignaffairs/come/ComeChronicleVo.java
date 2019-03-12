package com.taiji.frame.model.vo.foreignaffairs.come;

import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.Chronicle;
import lombok.Getter;
import lombok.Setter;

public class ComeChronicleVo extends Chronicle {

    /**
     * 来访信息ID
     */
    @Setter
    @Getter
    public String comeInfoId;

    @Setter
    @Getter
    public String beginTimeStr;

    @Setter
    @Getter
    public String endTimeStr;
}
