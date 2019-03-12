package com.taiji.frame.model.vo.foreignaffairs.nationCondition;

import com.taiji.frame.model.entity.foreignaffairs.nationCondition.ContactCondition;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 交往情况VO扩展类
 * Created by yuLei on 2018/8/15.
 */
public class ContactConditionVo extends ContactCondition implements Jsonable, Serializable {

    /**
     * 国家情况ID
     */
    @Getter
    @Setter
    public String nationId;

}