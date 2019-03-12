package com.taiji.frame.model.vo.foreignaffairs.nationCondition;

import com.taiji.frame.model.entity.foreignaffairs.nationCondition.CitySceneryIntro;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 城市/景点简介VO扩展类
 * Created by yuLei on 2018/8/15.
 */
public class CitySceneryIntroVo extends CitySceneryIntro implements Jsonable, Serializable {

    /**
     * 国家情况ID
     */
    @Getter
    @Setter
    public String nationId;

}
