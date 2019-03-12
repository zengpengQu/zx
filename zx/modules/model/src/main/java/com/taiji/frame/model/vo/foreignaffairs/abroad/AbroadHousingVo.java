package com.taiji.frame.model.vo.foreignaffairs.abroad;

import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadHousing;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class AbroadHousingVo extends AbroadHousing implements Jsonable,Serializable {

    @Getter
    @Setter
    public String abroadInfoId;

    @Setter
    @Getter
    public String checkinDateStr;



}