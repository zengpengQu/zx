package com.taiji.frame.model.entity.foreignaffairs.gift;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

/**
 * @author pengyx
 * 礼品类型表
 */
@Entity
@Table(name = "FA_MOG_TYPEGM", schema = "SCH_DUTY")
public class DicGiftType extends IdEntity implements Jsonable, Serializable {

    /**
     * 礼品类型名称
     * */
    @Getter
    @Setter
    private String typeName;

    /**
     * 礼品类型编码
     * */
    @Getter
    @Setter
    private String typeNumber;

    /**
     * 礼品录入人
     * */
    @Getter
    @Setter
    private String createName;
    
    @Getter
    @Setter
    private String status;
    

    /**
     * 礼品录入时间
     * */
    private Date createTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 最后更新时间
     * */
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
     * 备注信息
     * */
    @Getter
    @Setter
    private String remark;

    /**
     * 删除标志
     * */
    @Getter
    @Setter
    private String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("typeName", typeName);
        jsonObject.put("typeNumber", typeNumber);
        jsonObject.put("createName", createName);
        jsonObject.put("createTime", createTime);
        jsonObject.put("remark", remark);
        jsonObject.put("status", status);

        return jsonObject;
    }
}
