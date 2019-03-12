package com.taiji.frame.model.entity.foreignaffairs.bulletinBoard;

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
 * 公告栏管理
 * @author qzp
 * @date 2018/07/19
 */
@Entity
@Table(name = "DM_NBD_BOARD", schema = "SCH_DUTY")
public class BulletinBoard extends IdEntity implements Jsonable, Serializable {

    public BulletinBoard() {
    }

    /**
     * 标题
     */
    @Getter
    @Setter
    private String title;

    /**
     * 内容
     */
    @Getter
    @Setter
    private String content;

    /**
     * 发布者
     */
    @Setter
    private DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "PUBLISHER", referencedColumnName = "ID")
    public DicUser getDicUser() {
        return dicUser;
    }



    /**
     * 发布时间
     */
    private Date publishTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getPublishTime() {
        return publishTime;
    }

    /**
     * 创建时间
     */
    private Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 更新时间
     */
    private Date updateTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
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


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("title", title);
        jsonObject.put("content", content);
        jsonObject.put("publisherId", getDicUser().getId());
        jsonObject.put("publisher", getDicUser().getEmpName());
        jsonObject.put("publishTime", publishTime);
        //孙毅添加
        jsonObject.put("updateTimeIndexMain", DateUtil.dateToString(updateTime,DateUtil.FORMAT_DAY_CN));

        jsonObject.put("publishTimeStr", DateUtil.dateToString(publishTime, DateUtil.FORMAT_DAY));
        jsonObject.put("createTime", createTime);
        jsonObject.put("createTimeStr", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTime", updateTime);
        jsonObject.put("updateTimeStr", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("notes", notes);
        jsonObject.put("delFlag", delFlag);
        return jsonObject;
    }
}
