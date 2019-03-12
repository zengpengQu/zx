package com.taiji.frame.model.vo.taiwanCard;

import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanInfo;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.List;

public class TaiWanInfoVo extends TaiWanInfo implements Jsonable,Serializable {

    /**
     * 赴台信息ID
     */
    @Setter
    @Getter
    private String infoId;

    /**
     * 组团部门ID
     */
    @Setter
    @Getter
    private String groupDepartment;

    /**
     * 赴台时间
     */
    @Setter
    @Getter
    private String goTimeStr;

    /**
     * 赴台时间
     */
    @Setter
    @Getter
    private String endTimeStr;

    @Setter
    @Getter
    private List<TaiWanInfoUserVo> taiWanInfoUserListVo;
}
