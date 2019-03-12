package com.taiji.frame.model.entity.pubinfo.supervision;

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
 * @author qzp
 * @date 2018/08/23
 * 督查事项反馈文件关联表
 */
@Entity
@Table(name = "PU_SUPERVISION_FEEDBACK_FILE",schema = "SCH_DUTY")
public class SupervisionFeedBackFile extends IdEntity implements Jsonable,Serializable {
    private static final Logger LOGGER = LoggerFactory.getLogger(SupervisionFeedBackFile.class);

    @Setter
    private SupervisionFeedBack supervisionFeedBack;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = SupervisionFeedBack.class)
    @JoinColumn(name = "FEEDBACK_ID", referencedColumnName = "ID")
    public SupervisionFeedBack getSupervisionFeedBack() {
        try {
            if (supervisionFeedBack != null){
                supervisionFeedBack.getId();
            }
        }catch (Exception e){
            LOGGER.error("获取关联对象 SupervisionFeedBack supervisionFeedBack 失败", e);
            return null;
        }
        return supervisionFeedBack;
    }

    /**
     * 与实体关联的文件顺序
     */
    @Setter
    @Getter
    public Integer seq;

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
                LOGGER.error("获取关联对象 DicUploadFile dicUploadFile 错误", e);
                return null;
            }
        }
        return dicUploadFile;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("fileId", getDicUploadFile() == null ? "" : getDicUploadFile().getId());
        jsonObject.put("seq", seq);
        return jsonObject;
    }
}
