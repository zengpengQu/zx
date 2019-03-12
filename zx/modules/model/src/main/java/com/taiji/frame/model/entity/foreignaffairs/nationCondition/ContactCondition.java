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
 * 交往情况
 * Created by yuLei on 2018/8/13.
 */
@Entity
@Table(name="DM_CIM_CONTACT_CONDITION",schema = "SCH_DUTY")
public class ContactCondition extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(ContactCondition.class);

    public ContactCondition() {}

    /**
     * 交往日期
     */
    private Date contactDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    public void setContactDate(Date contactDate) {
        this.contactDate = contactDate;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getContactDate() {
        return contactDate;
    }

    /**
     * 交往情况
     */
    @Getter
    @Setter
    private String contactCondition;

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    private String delFlag;

    /**
     * 交往类型(0:政协,1:其他)
     */
    @Getter
    @Setter
    private String contactType;

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
                LOG.error("获取关联对象 NationConditionManagement 错误", e);
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
        jsonObject.put("contactCondition", contactCondition);
        jsonObject.put("contactDate", DateUtil.dateToString(contactDate, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("contactType", contactType);
        if (contactType.equals("0")) {
            jsonObject.put("contactTypeVal", "政协");
        } else if (contactType.equals("1")) {
            jsonObject.put("contactTypeVal", "其他");
        }
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("nationId", null == getNationConditionManagement() ? "" : getNationConditionManagement().getId());
        return jsonObject;
    }

}
