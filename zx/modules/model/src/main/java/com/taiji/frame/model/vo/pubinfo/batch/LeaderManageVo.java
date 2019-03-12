package com.taiji.frame.model.vo.pubinfo.batch;

import com.taiji.frame.model.entity.pubinfo.batch.DicDuty;
import com.taiji.frame.model.entity.pubinfo.batch.LeaderManage;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author wsh
 * @date 2018/9/18
 * 报送领导的信息管理
 */
public class LeaderManageVo extends LeaderManage implements Jsonable,Serializable {

    /**
     * 领导姓名Id
     */
    @Getter
    @Setter
    public String lea_Id;
    /**
     *   领导姓名
     * */
    @Getter
    @Setter
    public String leaName;

    /**
     * 领导职务
     */
    @Getter
    @Setter
    public String dutyName;
    /**
     * 性别
     */
    @Getter
    @Setter
    public String sex;//性别 0男性，1女性

    //秘书姓名
    @Getter
    @Setter
    public String secretart;

    @Getter
    @Setter
    public String phone;//手机号
    @Getter
    @Setter
    public String tel;//办公电话
    /**
     * 出生日期
     */
    @Getter
    @Setter
    public String birth;
    /**
     * 职务的名称
     */
    @Setter
    @Getter
    public String duName;

    /**
     * 人员的排序字段
     * @return
     */
    @Getter
    @Setter
    public Integer seq;

    /**
     * 职务集合
     */
    @Getter
    @Setter
    public List<DicDutyVo>dicDutyVoList;



}
