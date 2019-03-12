package com.taiji.frame.model.entity.foreignaffairs.circulate;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.file.FileManage;
import com.taiji.frame.model.entity.foreignaffairs.telegraph.TelegraphManage;
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
 * 传阅记录
 * @author qzp
 * @date 2018/07/24
 */
@Entity
@Table(name = "DM_FTM_CIRCULATION",schema = "SCH_DUTY")
public class CirculateRecord extends IdEntity implements Jsonable,Serializable {
    public CirculateRecord() {

    }

    /**
     * 电报管理
     */
    @Setter
    private TelegraphManage telegraphManage;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = TelegraphManage.class)
    @JoinColumn(name = "TELG_ID", referencedColumnName = "ID")
    public TelegraphManage getTelegraphManage() {
        if (telegraphManage != null){
            try {
                telegraphManage.getId();
            }catch (Exception e){
                return null;
            }
        }
        return telegraphManage;
    }

    /**
     * 文件管理
     */
    @Setter
    private FileManage fileManage;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = FileManage.class)
    @JoinColumn(name = "FILE_ID", referencedColumnName = "ID")
    public FileManage getFileManage() {
        if (fileManage != null){
            try {
                fileManage.getId();
            }catch (Exception e){
                return null;
            }
        }
        return fileManage;
    }

    /**
     * 文件电报类型
     */
    @Setter
    @Getter
    private String type;

    /**
     * 借出时间
     */
    private Date lendTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setLendTime(Date lendTime) {
        this.lendTime = lendTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getLendTime() {
        return lendTime;
    }

    /**
     * 归还时间
     */
    private Date returnTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public void setReturnTime(Date returnTime) {
        this.returnTime = returnTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getReturnTime() {
        return returnTime;
    }

    /**
     * 去向
     */
    @Setter
    @Getter
    private String destination;

    /**
     * 流转
     */
    @Setter
    @Getter
    private String circulation;

    /**
     * 存档标志
     */
    @Setter
    @Getter
    private String archiveFlag;

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
    @Setter
    @Getter
    private String notes;

    /**
     * 删除标志(0未删除,1已删除)
     */
    @Setter
    @Getter
    private String delFlag;


    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
//        jsonObject.put("telegraphManageId",getTelegraphManage().getId());
//        jsonObject.put("fileManageId",getFileManage().getId());
        jsonObject.put("type",type);
        jsonObject.put("lendTime",lendTime);
        jsonObject.put("lendTimeStr",DateUtil.dateToString(lendTime, DateUtil.FORMAT_DAY));
        jsonObject.put("returnTime",returnTime);
        jsonObject.put("returnTimeStr",DateUtil.dateToString(returnTime, DateUtil.FORMAT_DAY));
        jsonObject.put("destination",destination);
        jsonObject.put("circulation",circulation);
        jsonObject.put("archiveFlag",archiveFlag);
        jsonObject.put("createTime",createTime);
        jsonObject.put("createTimeStr",DateUtil.dateToString(createTime, DateUtil.FORMAT_TIME));
        jsonObject.put("updateTime",updateTime);
        jsonObject.put("updateTimeStr",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY_HOUR_MIN));
        jsonObject.put("notes",notes);
        jsonObject.put("delFlag",delFlag);

        return jsonObject;
    }
}
