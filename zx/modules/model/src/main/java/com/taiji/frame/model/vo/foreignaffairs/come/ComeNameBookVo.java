package com.taiji.frame.model.vo.foreignaffairs.come;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

public class ComeNameBookVo implements Serializable {

    /**
     * 来访信息ID
     */
    @Setter
    @Getter
    public String comeInfoId;

    /**
     * 陪同人员基本信息
     */
    @Setter
    @Getter
    public List<ComeAccompanyVo> comeAccompanyList;

    /**
     * 陪同人员详细信息
     */
    @Setter
    @Getter
    public List<ComePeopleInfoVo> comePeopleInfoList;


    /**
     * 来访人员信息
     */
    @Getter
    @Setter
    public List<ComeVisitorVo> comeVisitorList;

}
