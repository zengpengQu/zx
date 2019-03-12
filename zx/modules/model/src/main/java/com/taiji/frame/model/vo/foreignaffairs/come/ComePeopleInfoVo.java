package com.taiji.frame.model.vo.foreignaffairs.come;

import com.taiji.frame.model.entity.foreignaffairs.come.ComePeopleInfo;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 来访陪同人员信息Vo
 *
 * @author yx
 */
public class ComePeopleInfoVo extends ComePeopleInfo implements Jsonable, Serializable{

    /**
     * 陪同人员Id
     */
    @Setter
    @Getter
    public String userId;

    /**
     * 出生日期Str
     */
    @Setter
    @Getter
    public String birthdayStr;

}
