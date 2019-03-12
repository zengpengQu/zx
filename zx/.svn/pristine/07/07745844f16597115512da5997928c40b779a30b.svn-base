package com.taiji.frame.model.entity.foreignaffairs.telegraph;

import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 电报文件上传关系表实体
 * @author qzp
 * @date 2018/07/26
 */
@Entity
@Table(name = "DM_FTM_TELG_MANAGEMENT_FILE",schema = "SCH_DUTY")
public class TelegraphManageFile extends IdEntity implements Jsonable, Serializable {
    Logger logger = LoggerFactory.getLogger(TelegraphManageFile.class);

    /**
     * 电报管理ID
     */
    @Setter
    private TelegraphManage telegraphManage;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = TelegraphManage.class)
    @JoinColumn(name = "TELEGRAPH_ID",referencedColumnName = "ID")
    public TelegraphManage getTelegraphManage() {
        if (telegraphManage != null){
            try {
                telegraphManage.getId();
            }catch (Exception e){
                logger.error("获取关联对象 TelegraphManage telegraphManage 失败",e);
                return null;
            }
        }
        return telegraphManage;
    }

    /**
     * 与实体关联的文件顺序
     */
    @Setter
    @Getter
    private Integer seq;

    /**
     * 文件ID
     */
    @Setter
    private DicUploadFile dicUploadFile;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = DicUploadFile.class)
    @JoinColumn(name = "FILE_ID",referencedColumnName = "ID")
    public DicUploadFile getDicUploadFile() {
        if (dicUploadFile != null){
            try {
                dicUploadFile.getId();
            }catch (Exception e){
                logger.error("获取关联对象 DicUploadFile dicUploadFile 失败",e);
                return null;
            }
        }
        return dicUploadFile;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("seq",seq);
        jsonObject.put("fileId",getDicUploadFile() == null ? "":getDicUploadFile().getId());
        return jsonObject;
    }
}
