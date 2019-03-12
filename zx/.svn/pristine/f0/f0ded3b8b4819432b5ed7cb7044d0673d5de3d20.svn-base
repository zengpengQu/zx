package com.taiji.frame.model.entity.foreignaffairs.abroad;

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

@Entity
@Table(name = "FA_OAM_PREPAREMENT_FILE", schema = "SCH_DUTY")
public class PreparementFile extends IdEntity implements Jsonable{
    private static final Logger LOG = LoggerFactory.getLogger(PreparementFile.class);

    /**
     * 筹备会议 ID
     */
    @Setter
    public AbroadPreparment abroadPreparment;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = AbroadPreparment.class)
    @JoinColumn(name = "PREPAREMENT_ID", referencedColumnName = "ID")
    public AbroadPreparment getAbroadPreparment() {
        if (abroadPreparment != null) {
            try {
                abroadPreparment.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 AbroadPreparment abroadPreparment 失败", e);
                return null;
            }
        }
        return abroadPreparment;
    }

    /**
     * 文件ID
     */
    @Setter
    public DicUploadFile dicUploadFile;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicUploadFile.class)
    @JoinColumn(name = "FILE_ID", referencedColumnName = "ID")
    public DicUploadFile getDicUploadFile() {
        if (dicUploadFile != null) {
            try {
                dicUploadFile.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicUploadFile dicUploadFile 错误", e);
                return null;
            }
        }
        return dicUploadFile;
    }

    /**
     * 与实体关联的文件顺序
     */
    @Setter
    @Getter
    public Integer seq;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("preparementId", getAbroadPreparment() == null ? "" : getAbroadPreparment().getId());
        jsonObject.put("fileId", getDicUploadFile() == null ? "" : getDicUploadFile().getId());
        jsonObject.put("seq", seq);

        return jsonObject;
    }
}
