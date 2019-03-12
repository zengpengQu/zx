package com.taiji.frame.model.vo.pubinfo.contacts;

import com.taiji.frame.model.entity.pubinfo.contacts.CmmListt;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author sy
 * 单位通讯录Vo
 * */
public class AddressTeamVo extends CmmListt implements Jsonable,Serializable {

    @Getter
    @Setter
    public String parentId;

    @Getter
    @Setter
    public String teamName;



    @Getter
    @Setter
    public String delFlag;

    @Getter
    @Setter
    public String deptId;

    @Getter
    @Setter
    public String isLeaf;
}
