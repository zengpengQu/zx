package com.taiji.frame.model.entity.foreignaffairs.come;


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
 * 来访简报
 *
 * @author yx
 */
@Entity
@Table(name = "FA_CVM_REPORT", schema = "SCH_DUTY")
public class ComeReport extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(ComeReport.class);

    /**
     * 来访基本信息
     */
    @Setter
    public ComeInfo comeInfo;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = ComeInfo.class)
    @JoinColumn(name = "BASICINFO_ID", referencedColumnName = "ID")
    public ComeInfo getComeInfo() {
        if (comeInfo != null) {
            try {
                comeInfo.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 ComeInfo comeInfo 错误", e);
                return null;
            }
        }
        return comeInfo;
    }

    /**
     * 简报标题
     */
    @Setter
    @Getter
    public String title;

    /**
     * 简报内容
     */
    @Setter
    @Getter
    public String content;

    /**
     * 报送单位
     */
    @Setter
    @Getter
    public String sendOrg;

    /**
     * 报送日期
     */
    @Setter
    public Date sendDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getSendDate() {
        return sendDate;
    }

    /**
     * 更新时间
     */
    public Date updateTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    public String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("comeInfoId", getComeInfo() == null ? "" : this.getComeInfo().getId());
        jsonObject.put("title", title);
        jsonObject.put("content", content);
        jsonObject.put("sendOrg", sendOrg);
        jsonObject.put("sendDateStr", DateUtil.dateToString(sendDate, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTimeStr", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("delFlag", delFlag);

        return jsonObject;
    }
}
