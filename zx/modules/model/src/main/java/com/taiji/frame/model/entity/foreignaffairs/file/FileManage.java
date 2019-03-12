package com.taiji.frame.model.entity.foreignaffairs.file;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;
/**
 * 文件管理
 * @author qzp
 * @date 2018/07/24
 */
@Entity
@Table(name = "DM_FTM_FILE_MANAGEMENT", schema = "SCH_DUTY")
public class FileManage extends IdEntity implements Jsonable,Serializable {
    public FileManage() {
    }

    /**
     * 收件时间
     */
    private Date receiveTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setReceiveTime(Date receiveTime){
        this.receiveTime = receiveTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    public Date getReceiveTime(){
        return receiveTime;
    }

    /**
     * 内部序号
     */
    @Setter
    @Getter
    private String inSerialNum;

    /**
     * 来文单位
     */
    @Setter
    @Getter
    private String senderOrg;

    /**
     * 文号
     */
    @Setter
    @Getter
    private String fileNum;

    /**
     * 来文类型
     */
    @Setter
    @Getter
    private String fileType;

    /**
     * 来文标题
     */
    @Setter
    @Getter
    private String fileTitle;

    /**
     * 数量
     */
    @Setter
    @Getter
    private  String quantity;

    /**
     * 密级
     */
    @Setter
    @Getter
    private String secClass;

    /**
     * 保密期限
     */
    @Setter
    @Getter
    private String secDeadline;

    /**
     * 回收属性
     */
    @Setter
    @Getter
    private String recycleProp;

    /**
     * 回收状态
     */
    @Setter
    @Getter
    private String recycleStatus;

    /**
     * 备注
     */
    @Setter
    @Getter
    private String notes;

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
        jsonObject.put("receiveTime",receiveTime);
        jsonObject.put("receiveTimeSt",DateUtil.dateToString(receiveTime, DateUtil.FORMAT_DAY));
        jsonObject.put("inSerialNum",inSerialNum);
        jsonObject.put("senderOrg",senderOrg);
        jsonObject.put("fileNum",fileNum);
        jsonObject.put("fileType",fileType);
        jsonObject.put("fileTitle",fileTitle);
        jsonObject.put("quantity",quantity);
        jsonObject.put("secClassStr",secClass);
        jsonObject.put("secDeadline",secDeadline);
        jsonObject.put("recycleProp",recycleProp);
        jsonObject.put("recycleStatus",recycleStatus);
        jsonObject.put("notes",notes);
        jsonObject.put("createTime",createTime);
        jsonObject.put("createTimeStr",DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTime",updateTime);
        jsonObject.put("updateTimeStr",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag",delFlag);
        return jsonObject;
    }
}
