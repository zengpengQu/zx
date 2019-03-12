package com.taiji.frame.model.entity.foreignaffairs.archivesData;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicUser;
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

/**
 * 案卷分组
 * Created by yuLei on 2018/8/6.
 */
@Entity
@Table(name="FA_DM_TEAM",schema = "SCH_DUTY")
public class DocumentTeam extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(DocumentTeam.class);

    public DocumentTeam() {}

    /**
     * 分组名称
     */
    @Getter
    @Setter
    private String teamName;

    /**
     * 父节点ID
     */
    @Getter
    @Setter
    private String parentId;

    /**
     * 是否是叶子节点(0:否,1:是)
     */
    @Getter
    @Setter
    private String isLeaf;

    /**
     * 创建人ID
     */
    @Setter
    public DicUser dicUser;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    public DicUser getDicUser() {
        if(dicUser != null)
        {
            try {
                dicUser.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象DicUser dicUser 错误",e);
                return null;
            }
        }
        return dicUser;
    }

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

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("teamName", teamName);
        jsonObject.put("parentId", parentId);
        jsonObject.put("isLeaf", isLeaf);
        jsonObject.put("userId", null == getDicUser() ? "" : getDicUser().getId());
        jsonObject.put("empName", null == getDicUser() ? "" : getDicUser().getEmpName());
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        return jsonObject;
    }

}
