package com.taiji.frame.model.entity.foreignaffairs.come;

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

/**
 * 来访接待计划附件-上传文件关联表
 *
 * @author yx
 */
@Entity
@Table(name = "FA_CVM_RECEPTION_FILE", schema = "SCH_DUTY")
public class ReceptionFile extends IdEntity implements Jsonable{

    private static final Logger LOG = LoggerFactory.getLogger(ReceptionFile.class);

    /**
     * 接待计划ID
     */
    @Setter
    public ComeReception comeReception;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = ComeReception.class)
    @JoinColumn(name = "RECEPTION_ID", referencedColumnName = "ID")
    public ComeReception getComeReception() {
        if (comeReception != null) {
            try {
                comeReception.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 ComeReception comereception 失败", e);
                return null;
            }
        }
        return comeReception;
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
        jsonObject.put("receptionId", getComeReception() == null ? "" : getComeReception().getId());
        jsonObject.put("fileId", getDicUploadFile() == null ? "" : getDicUploadFile().getId());
        jsonObject.put("seq", seq);

        return jsonObject;
    }
}
