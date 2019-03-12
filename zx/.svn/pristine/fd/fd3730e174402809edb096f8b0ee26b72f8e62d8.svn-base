package com.taiji.frame.model.entity.pubinfo.schedule;

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
import java.io.File;
import java.io.Serializable;
import java.util.Date;

/**
 * 值班日报文件表
 *
 * @author yx
 * Created on 2018/6/15.
 */
@Entity
@Table(name = "PU_SCH_DUTY_FILE", schema = "SCH_DUTY")
public class DutyFile extends IdEntity implements Jsonable, Serializable {

    /**
     * 值班日报期数
     */
    @Setter
    @Getter
    public String dutyNum;

    /**
     * 日报日期
     */
    @Setter
    public Date dutyTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getDutyTime() {
        return dutyTime;
    }

    /**
     * 日报文本内容
     */
    @Setter
    @Getter
    public String content;

    /**
     * 日报原始名称
     */
    @Setter
    @Getter
    public String realName;

    /**
     * 日报文件存储路径
     */
    @Setter
    @Getter
    public String fileDir;

    /**
     * 更新时间
     */
    @Setter
    public Date updateTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Setter
    @Getter
    public String delFlag;

    /**
     * 上传者
     */
    @Setter
    @Getter
    public String uploader;

    /**
     * 操作者
     */
    @Setter
    public DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "OPERATOR", referencedColumnName = "ID")
    public DicUser getDicUser() {
        return dicUser;
    }

    /**
     * 发布状态, 0：未发布， 1：已发布
     */
    @Setter
    @Getter
    public String publishStatus;


    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("dutyNum", dutyNum);
        jsonObject.put("dutyTimeStr", DateUtil.dateToString(dutyTime, DateUtil.FORMAT_DAY));
        jsonObject.put("content", content);
        jsonObject.put("realName", realName);
        jsonObject.put("fileDir", fileDir);
        jsonObject.put("uuidName", fileDir.substring(fileDir.lastIndexOf(File.separator) + 1));
        jsonObject.put("updateTime", updateTime == null ? "" : DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("uploader", uploader);
        jsonObject.put("userId", dicUser == null ? "" : dicUser.getUserId());
        jsonObject.put("userName", dicUser == null ? "" : dicUser.getUpdEmp());
        jsonObject.put("publishStatus", publishStatus);

        return jsonObject;
    }
}
