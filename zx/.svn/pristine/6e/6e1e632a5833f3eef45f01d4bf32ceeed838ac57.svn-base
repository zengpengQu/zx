package com.taiji.frame.model.systempara;

import com.fasterxml.jackson.annotation.JsonFormat;
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
import java.util.Date;

/**
 * 文件上传表
 *
 * @author yx
 */
@Entity
@Table(name = "TB_DIC_UPLOAD_FILE", schema = "SCH_DUTY")
public class DicUploadFile extends IdEntity implements Jsonable{

    /**
     * 文件保存状态：0：文件保存到临时文件夹；1：文件从临时文件夹转移到正式文件夹；2：文件删除
     */
    @Setter
    @Getter
    public Integer status;

    /**
     * 文件名
     */
    @Setter
    @Getter
    public String fileName;

    /**
     * 文件正式路径
     */
    @Setter
    @Getter
    public String path;

    /**
     * 文件临时路径
     */
    @Setter
    @Getter
    public String tempPath;

    /**
     * 创建时间
     */
    public Date createTime;
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
     * 备注
     */
    @Setter
    @Getter
    public String rmks;


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("status", status);
        jsonObject.put("fileName", fileName);
        jsonObject.put("path", path);
        jsonObject.put("tempPath", tempPath);
        jsonObject.put("createTime", createTime);
        jsonObject.put("rmks", rmks);

        return jsonObject;
    }
}
