package com.taiji.frame.model.entity.foreignaffairs.file;

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
@Entity
@Table(name = "DM_FTM_FILE_MANAGEMENT_FILE",schema = "SCH_DUTY")
public class FileManageFile extends IdEntity implements Jsonable,Serializable {
    Logger logger = LoggerFactory.getLogger(FileManageFile.class);

    /**
     * 文件管理ID
     */
    @Setter
    private FileManage fileManage;

    @ManyToOne(fetch = FetchType.LAZY,targetEntity = FileManage.class)
    @JoinColumn(name = "FILE_MANAGE_ID",referencedColumnName = "ID")
    public FileManage getFileManage() {
        if (fileManage != null){
            try {
                fileManage.getId();
            }catch (Exception e){
                logger.error("",e);
                return null;
            }
        }
        return fileManage;
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
                logger.error("",e);
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
        jsonObject.put("fileId",getDicUploadFile().getId());
        return jsonObject;
    }
}
