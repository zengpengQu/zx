package com.taiji.frame.model.entity.foreignaffairs.archivesData;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.constants.SecretLevel;
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
 * 案卷管理
 * Created by yuLei on 2018/8/6.
 */
@Entity
@Table(name="FA_DM_ARCHIVE",schema = "SCH_DUTY")
public class DocumentArchive extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(DocumentArchive.class);

    public DocumentArchive() {}

    /**
     * 全宗号
     */
    @Getter
    @Setter
    private String fondsNumber;

    /**
     * 目录号
     */
    @Getter
    @Setter
    private String catalogNumber;

    /**
     * 案卷号
     */
    @Getter
    @Setter
    private String fileNumber;

    /**
     * 档案号
     */
    @Getter
    @Setter
    private String archiveNumber;

    /**
     * 年度
     */
    private Date year;

    @DateTimeFormat(pattern = "yyyy")
    public void setYear(Date year) {
        this.year = year;
    }

    @DateTimeFormat(pattern = "yyyy")
    @JsonFormat(pattern = "yyyy", timezone = "GMT+8")
    public Date getYear() {
        return year;
    }

    /**
     * 保管期限
     */
    @Getter
    @Setter
    private String retentionPeriod;

    /**
     * 案卷题名
     */
    @Getter
    @Setter
    private String fileName;

    /**
     * 卷内文件份数
     */
    @Getter
    @Setter
    private Long fileSum;

    /**
     * 页数
     */
    @Getter
    @Setter
    private Long pageSum;

    /**
     * 编制日期
     */
    private Date compileDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setCompileDate(Date compileDate) {
        this.compileDate = compileDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getCompileDate() {
        return compileDate;
    }

    /**
     * 编制结束日期
     */
    private Date endDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getEndDate() {
        return endDate;
    }

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
                LOG.error("获取关联对象 DicDept  dicDept错误", e);
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 立卷人
     */
    @Getter
    @Setter
    private String writer;

    /**
     * 检查人
     */
    @Getter
    @Setter
    private String rummager;

    /**
     * 检查日期
     */
    private Date rummagerDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setRummagerDate(Date rummagerDate) {
        this.rummagerDate = rummagerDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getRummagerDate() {
        return rummagerDate;
    }

    /**
     * 密级（0：秘密，1：机密，2：绝密）
     */
    @Getter
    @Setter
    private String secretLevel;

    /**
     * 本卷情况说明
     */
    @Getter
    @Setter
    private String content;

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
     * 类别
     */
    public DocumentTeam documentTeam;

    public void setDocumentTeam(DocumentTeam documentTeam) {
        this.documentTeam = documentTeam;
    }

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DocumentTeam.class)
    @JoinColumn(name = "TEAM_ID", referencedColumnName = "ID")
    public DocumentTeam getDocumentTeam() {
        if(documentTeam != null) {
            try {
                documentTeam.getDelFlag();
            } catch (Exception e) {
                LOG.error("获取关联对象 DocumentTeam documentTeam 错误", e);
                return null;
            }
        }
        return documentTeam;
    }

    /**
     * 文件管理list
     */
    @Setter
    private List<Document> documentList;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "documentArchive", targetEntity = Document.class)
    public List<Document> getDocumentList() {
        return documentList;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("fondsNumber", fondsNumber);
        jsonObject.put("catalogNumber", catalogNumber);
        jsonObject.put("fileNumber", fileNumber);
        jsonObject.put("archiveNumber", archiveNumber);
        jsonObject.put("year", DateUtil.dateToString(year, DateUtil.FORMAT_YYYY));
        jsonObject.put("retentionPeriod", retentionPeriod);
        jsonObject.put("fileName", fileName);
        jsonObject.put("fileSum", fileSum);
        jsonObject.put("pageSum", pageSum);
        jsonObject.put("compileDate", DateUtil.dateToString(compileDate, DateUtil.FORMAT_DAY));
        jsonObject.put("endDate", DateUtil.dateToString(endDate, DateUtil.FORMAT_DAY));
        jsonObject.put("deptId", null == getDicDept() ? "" : getDicDept().getId());
        jsonObject.put("department", null == getDicDept() ? "" : getDicDept().getDeptName());
        jsonObject.put("writer", writer);
        jsonObject.put("rummager", rummager);
        jsonObject.put("rummagerDate", DateUtil.dateToString(rummagerDate, DateUtil.FORMAT_DAY));
        jsonObject.put("secretLevel", secretLevel);
        if (secretLevel.equals(SecretLevel.SECRET.value())) {
            jsonObject.put("secretLevelVal", "秘密");
        } else if (secretLevel.equals(SecretLevel.CONFIDENCE.value())) {
            jsonObject.put("secretLevelVal", "机密");
        } else if (secretLevel.equals(SecretLevel.TOP_SECRET.value())) {
            jsonObject.put("secretLevelVal", "绝密");
        }
        jsonObject.put("content", content);
        jsonObject.put("notes", notes);
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("teamId", null == getDocumentTeam() ? "" : getDocumentTeam().getId());
        jsonObject.put("teamName", null == getDocumentTeam() ? "" : getDocumentTeam().getTeamName());
        return jsonObject;
    }

}
