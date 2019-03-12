package com.taiji.frame.model.entity.foreignaffairs.archivesData;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 文件管理
 * Created by yuLei on 2018/8/8.
 */
@Entity
@Table(name = "FA_DM_DOCUMENT", schema = "SCH_DUTY")
public class Document extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(Document.class);

    public Document() {}

    /**
     * 案卷ID
     */
    @Setter
    private DocumentArchive documentArchive;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DocumentArchive.class)
    @JoinColumn(name = "DM_ID", referencedColumnName = "ID")
    public DocumentArchive getDocumentArchive() {
        return documentArchive;
    }

    /**
     * 文件编号
     */
    @Getter
    @Setter
    private String documentNumber;

    /**
     * 文件题名
     */
    @Getter
    @Setter
    private String documentName;

    /**
     * 责任人
     */
    @Getter
    @Setter
    private String dutyPerson;

    /**
     * 文件形成日期
     */
    private Date formationDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setFormationDate(Date formationDate) {
        this.formationDate = formationDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getFormationDate() {
        return formationDate;
    }

    /**
     * 页号
     */
    @Getter
    @Setter
    private Long pageNumber;

    /**
     * 编制单位
     */
    public DicDept dicDept;

    public void setDicDept(DicDept dicDept) {
        this.dicDept = dicDept;
    }

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {
        if(dicDept != null) {
            try {
                dicDept.getDeptName();
            } catch (Exception e) {
                LOG.error("获取关联对象  DicDept  dicDept错误", e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 备注
     */
    @Getter
    @Setter
    private String notes;

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    private String delFlag;

    /**
     * 创建时间
     */
    public Date createTime;

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
    public Date updateTime;

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
     * 文件管理附件list
     */
    @Setter
    private List<DocumentFile> documentFileList;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "document", targetEntity = DocumentFile.class)
    public List<DocumentFile> getDocumentFileList() {
        return documentFileList;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("dmId", null == getDocumentArchive() ? "" : getDocumentArchive().getId());
        jsonObject.put("archiveNumber", null == getDocumentArchive() ? "" : getDocumentArchive().getArchiveNumber());
        jsonObject.put("teamName", null == getDocumentArchive() ? "" : getDocumentArchive().getDocumentTeam().getTeamName());
        jsonObject.put("documentNumber", documentNumber);
        jsonObject.put("documentName", documentName);
        jsonObject.put("dutyPerson", dutyPerson);
        jsonObject.put("formationDate", DateUtil.dateToString(formationDate, DateUtil.FORMAT_DAY));
        jsonObject.put("pageNumber", pageNumber);
        jsonObject.put("deptId", null == getDicDept() ? "" : getDicDept().getId());
        jsonObject.put("department", null == getDicDept() ? "" : getDicDept().getDeptName());
        jsonObject.put("notes", notes);
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        if (null != getDocumentFileList() && getDocumentFileList().size() > 0) {
            StringBuffer fileNames = new StringBuffer();
            for (int i = 0; i < getDocumentFileList().size(); i ++) {
                if (getDocumentFileList().size() - 1 == i) {
                    fileNames.append(getDocumentFileList().get(i).getFileName());
                } else {
                    fileNames.append(getDocumentFileList().get(i).getFileName() + "，");
                }
            }
            jsonObject.put("fileNames", fileNames.toString());
        } else {
            jsonObject.put("fileNames", "无附件");
        }
        return jsonObject;
    }

}
