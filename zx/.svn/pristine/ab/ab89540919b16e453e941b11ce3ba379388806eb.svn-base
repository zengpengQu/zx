package com.taiji.frame.model.entity.foreignaffairs.telegraph;

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
 * 电报管理
 * @author qzp
 * @date 2018/07/24
 */
@Entity
@Table(name = "DM_FTM_TELG_MANAGEMENT",schema = "SCH_DUTY")
public class TelegraphManage extends IdEntity implements Jsonable, Serializable {
    public TelegraphManage() {
    }

    /**
     * 接收日期
     */
    private Date receiveTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setReceiveTime(Date receiveTime) {
        this.receiveTime = receiveTime;
    }
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getReceiveTime() {
        return receiveTime;
    }

    /**
     * 内部序号
     */
    @Getter
    @Setter
    private String inSerialNum;

    /**
     * 报号
     */
    @Getter
    @Setter
    private String telegramNum;

    /**
     * 密级
     */
    @Getter
    @Setter
    private String secClass;

    /**
     * 数量
     */
    @Getter
    @Setter
    private  String quantity;

    /**
     * 来文单位
     */
    @Getter
    @Setter
    private String senderOrg;

    /**
     * 来文类型
     */
    @Getter
    @Setter
    private String telegramType;

    /**
     * 来文标题
     */
    @Getter
    @Setter
    private String telegramTitle;

    /**
     * 录入人
     */
    @Setter
    private DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "RECODER", referencedColumnName = "ID")
    public DicUser getDicUser() {
        if (dicUser != null){
            try {
                dicUser.getId();
            }catch (Exception e){
                return null;
            }
        }
        return dicUser;
    }

    /**
     * 创建时间
     */
    private Date createTime;

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
    private Date updateTime;

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
     * 删除标志(0未删除,1已删除)
     */
    @Getter
    @Setter
    private String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("receiveTime",receiveTime);
        jsonObject.put("receiveTimeStr",DateUtil.dateToString(receiveTime, DateUtil.FORMAT_DAY));
        jsonObject.put("inSerialNum",inSerialNum);
        jsonObject.put("telegramNum",telegramNum);
        jsonObject.put("secClass",secClass);
        jsonObject.put("quantity",quantity);
        jsonObject.put("senderOrg",senderOrg);
        jsonObject.put("telegramType",telegramType);
        jsonObject.put("telegramTitle",telegramTitle);
        jsonObject.put("dicUserId",getDicUser().getId());
        jsonObject.put("dicUser",getDicUser().getEmpName());
        jsonObject.put("createTime",createTime);
        jsonObject.put("createTimeStr",DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTime",updateTime);
        jsonObject.put("updateTimeStr",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("notes",notes);
        jsonObject.put("delFlag",delFlag);
        return jsonObject;
    }
}
