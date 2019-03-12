package com.taiji.frame.model.entity.pubinfo.contacts;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author sy
 * 通讯录分组表
 */
@Entity
@Table(name = "PU_ADDRESS_TEAM", schema = "SCH_DUTY")
public class AddressTeam extends IdEntity implements Jsonable, Serializable {


    /**
     * 用户表ID获得用户表信息
     */
    @Setter
    public DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "PERS_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        return dicUser;
    }

    /**
     * 分组名称
     */
    @Getter
    @Setter
    public String teamName;

    /**
     * 父id
     */
    @Setter
    public AddressTeam addressTeam;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = AddressTeam.class)
    @JoinColumn(name = "PARENT_ID", referencedColumnName = "ID")
    public AddressTeam getAddressTeam(){return addressTeam;}

    /**
     * 是否叶子节点
     */
    @Getter
    @Setter
    public String isLeaf;

    /**
     * 填报日期
     */
    @Setter
    public Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 如果添加 前端页面需要增加
     * 1:表示当前分组为用户,2:表示部门
     */
    @Getter
    @Setter
    public String delFlag;


    /**
     * 部门ID  暂无用
     */
    @Setter
    @Getter
    public String deptId;



    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("userId", dicUser.getUserId());
        jsonObject.put("userName", dicUser.getEmpName());
        jsonObject.put("createTimeStr", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("isLeaf", isLeaf);
        jsonObject.put("teamName", teamName);
        jsonObject.put("parentId", addressTeam.getId());
        return jsonObject;
    }
}