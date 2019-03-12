package com.taiji.frame.model.entity.foreignaffairs.nationCondition;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
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
 * 重要议会简介
 * Created by yuLei on 2018/8/13.
 */
@Entity
@Table(name="DM_CIM_PARLIAMENT_INTRO",schema = "SCH_DUTY")
public class ParliamentIntro extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(ParliamentIntro.class);

    public ParliamentIntro() {}

    /**
     * 议会名称
     */
    @Getter
    @Setter
    private String parliamentName;

    /**
     * 议会简介
     */
    @Getter
    @Setter
    private String parliamentIntro;

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
     * 国家情况管理
     */
    public NationConditionManagement nationConditionManagement;

    public void setNationConditionManagement(NationConditionManagement nationConditionManagement) {
        this.nationConditionManagement = nationConditionManagement;
    }

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = NationConditionManagement.class)
    @JoinColumn(name = "NATION_ID", referencedColumnName = "ID")
    public NationConditionManagement getNationConditionManagement() {
        if(nationConditionManagement != null) {
            try {
                nationConditionManagement.getDelFlag();
            } catch (Exception e) {
                LOG.error("获取关联对象NationConditionManagement 错误", e);
                return null;
            }
        }
        return nationConditionManagement;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("parliamentName", parliamentName);
        jsonObject.put("parliamentIntro", parliamentIntro);
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("nationId", null == getNationConditionManagement() ? "" : getNationConditionManagement().getId());
        return jsonObject;
    }

}
