package com.taiji.frame.model.vo.taiwanCard;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class TaiWanInfoUserVo  implements Serializable {


    @Setter
    @Getter
    public String userInfoId;

    @Setter
    @Getter
    public String userTaiWanId;


    @Setter
    @Getter
    public String userDeptId;


    @Setter
    @Getter
    public String userDeptName;

    @Setter
    @Getter
    public String userPeopleId;

    @Setter
    @Getter
    public String userName;


    @Setter
    @Getter
    public String userDegree;
    @Setter
    @Getter
    public String userNotes;


    @Setter
    @Getter
    public String userDuty;

    @Setter
    @Getter
    public String userDutyTai;

}
