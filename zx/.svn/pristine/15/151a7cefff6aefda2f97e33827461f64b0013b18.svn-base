package com.taiji.frame.model.vo.pubinfo.supervision;

import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionMatter;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author qzp
 * @date 2018/08/23
 * 督查事项表Vo
 */
public class SupervisionMatterVo extends SupervisionMatter implements Jsonable,Serializable {

    /**
     * 主办单位ID
     */
    @Setter
    @Getter
    private String hostUnitId;

    /**
     * 协作单位ID
     */
    @Setter
    @Getter
    private String cooperativeId;

    @Setter
    @Getter
    private String deptId;

    /**
     * 下发日期start
     */
    @Setter
    @Getter
    private String beginTime;

    /**
     * 下发日期end
     */
    @Setter
    @Getter
    private String endTime;

    /**
     * 下发日期
     */
    @Setter
    @Getter
    private String issuedDateStr;


    /**
     * 是否具有查看其他部门记录的权限
     */
    @Getter
    @Setter
    private String viewOthers;

}
