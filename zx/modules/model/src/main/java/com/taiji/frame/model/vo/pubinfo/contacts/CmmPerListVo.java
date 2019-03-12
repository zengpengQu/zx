package com.taiji.frame.model.vo.pubinfo.contacts;

import com.taiji.frame.model.entity.pubinfo.contacts.CmmList;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
/**
 * @author sy
 * 人员通讯录Vo
 * */
public class CmmPerListVo extends CmmList implements Jsonable,Serializable {

    /**
     * 单位ID
     * */
    @Getter
    @Setter
    public String dicDeptId;
    /**
     * 用户ID
     * */
    @Getter
    @Setter
    public String dicUserId;

    /**
     * 分组ID
     * */
    @Getter
    @Setter
    public String comListtId;

    /**
     * 人员姓名
     * */
    @Getter
    @Setter
    public String name;

    /**
     * 职务
     * */
    @Getter
    @Setter
    public String proTypeId;

    /**
     * 出生年月字符串格式
     * */
    @Getter
    @Setter
    public String birthDateStr;








}
