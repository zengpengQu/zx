package com.taiji.frame.model.entity.foreignaffairs.passportRecord;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 证照催还记录
 * Created by yuLei on 2018/8/2.
 */
@Entity
@Table(name = "DM_PPM_ASK_RETURN", schema = "SCH_DUTY")
public class AskReturnRecord extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(AskReturnRecord.class);

    public AskReturnRecord() {}

    /**
     * 经办人
     */
    @Setter
    public DicUser dicUser;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        if(dicUser != null) {
            try {
                dicUser.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicUser dicUser错误",e);
                return null;
            }
        }
        return dicUser;
    }

    /**
     * 证件编号
     */
    @Getter
    @Setter
    private String documentCode;

    /**
     * 姓名
     */
    @Getter
    @Setter
    private String peopleName;

    /**
     * 催还内容
     */
    @Getter
    @Setter
    private String askContent;

    /**
     * 催还时间
     */
    public Date askTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setAskTime(Date askTime) {
        this.askTime = askTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getAskTime() {
        return askTime;
    }

    /**
     * 创建时间
     */
    public Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 更新时间
     */
    public Date updateTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * 备注
     */
    @Getter
    @Setter
    private String notes;

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    private String delFlag;

    /**
     * 证件/通行证ID
     */
    @Getter
    @Setter
    private String permitId;

    /**
     * 状态码(0:因私护照,1:赴台通行证,2:港澳通行证)
     */
    @Getter
    @Setter
    private String permitType;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("userId", null == getDicUser() ? "" : getDicUser().getId());
        jsonObject.put("userName", null == getDicUser() ? "" : getDicUser().getEmpName());
        jsonObject.put("documentCode", documentCode);
        jsonObject.put("peopleName", peopleName);
        jsonObject.put("askContent", askContent);
        jsonObject.put("askTime", DateUtil.dateToString(askTime, DateUtil.FORMAT));
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT));
        jsonObject.put("notes", notes);
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("permitId", permitId);
        jsonObject.put("permitType", permitType);
        if (permitType.equals("0")) {
            jsonObject.put("permitTypeVal", "因私护照");
        } else if (permitType.equals("1")) {
            jsonObject.put("permitTypeVal", "赴台通行证");
        } else if (permitType.equals("2")) {
            jsonObject.put("permitTypeVal", "港澳通行证");
        }
        return jsonObject;
    }

}
