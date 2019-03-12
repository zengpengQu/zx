package com.taiji.frame.model.entity.foreignaffairs.archivesData;

import com.taiji.frame.model.util.IdEntity;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;

/**
 * 案卷文件管理-文件上传关联表
 * Created by yuLei on 2018/8/8.
 */
@Entity
@Table(name = "FA_DM_DOCUMENT_FILE", schema = "SCH_DUTY")
public class DocumentFile extends IdEntity {

    private static final Logger LOG = LoggerFactory.getLogger(DocumentFile.class);

    /**
     * 临时外事活动ID
     */
    @Setter
    public Document document;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = Document.class)
    @JoinColumn(name = "DOCUMENT_ID", referencedColumnName = "ID")
    public Document getDocument() {
        if (document != null) {
            try {
                document.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 Document document 失败", e);
                return null;
            }
        }
        return document;
    }

    /**
     * 文件ID
     */
    @Getter
    @Setter
    private String fileId;

    /**
     * 文件名
     */
    @Getter
    @Setter
    private String fileName;


    /**
     * 文件seq
     */
    @Setter
    @Getter
    public Integer seq;

}
