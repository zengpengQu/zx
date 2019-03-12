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
 * 来访简报-上传文件关联表
 *
 * @author yx
 */
@Entity
@Table(name = "FA_CVM_REPORT_FILE", schema = "SCH_DUTY")
public class ReportFile extends IdEntity implements Jsonable{

    private static final Logger LOG = LoggerFactory.getLogger(ReportFile.class);

    /**
     * 来访简报ID
     */
    @Setter
    public ComeReport comeReport;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = ComeReport.class)
    @JoinColumn(name = "REPORT_ID", referencedColumnName = "ID")
    public ComeReport getComeReport() {
        if (comeReport != null) {
            try {
                comeReport.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 ComeReport comeReport 失败", e);
                return null;
            }
        }
        return comeReport;
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
        jsonObject.put("reportId", getComeReport() == null ? "" : getComeReport().getId());
        jsonObject.put("fileId", getDicUploadFile() == null ? "" : getDicUploadFile().getId());
        jsonObject.put("seq", seq);

        return jsonObject;
    }
}
