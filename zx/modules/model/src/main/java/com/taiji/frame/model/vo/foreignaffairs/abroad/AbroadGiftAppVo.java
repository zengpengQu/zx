package com.taiji.frame.model.vo.foreignaffairs.abroad;

import com.taiji.frame.model.entity.foreignaffairs.gift.GiftApplication;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

public class AbroadGiftAppVo extends GiftApplication implements Jsonable,Serializable {

    @Getter
    @Setter
    public String abroadInfoId;

}
