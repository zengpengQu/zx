package com.taiji.frame.model.entity.pubinfo.schedule;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * @author admin
 * 值班日报信息表
 */
@Entity
@Table(name = "PU_SCH_WATCH", schema = "SCH_DUTY")
public class DutyDaily extends IdEntity implements Jsonable, Serializable {

    /**
     * 所属单位编码
     */
    @Setter
    public DicDept dicDept;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {

        if(dicDept != null)
        {
            try {
                dicDept.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicDept;
    }

    /**
     * 值班员姓名
     * */
    @Getter
    @Setter
    public String creatorName;

    /**
     * 操作人
     */
    @Setter
    public DicUser dicUser;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicUser.class)
    @JoinColumn(name = "OPERATOR", referencedColumnName = "ID")
    public DicUser getDicUser() {

        if(dicUser != null)
        {
            try {
                dicUser.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return dicUser;
    }

    /**
     * 板块信息
     */
    @Setter
    public Section section;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = Section.class)
    @JoinColumn(name = "SECTION_ID", referencedColumnName = "ID")
    public Section getSection() {

        if(section != null)
        {
            try {
                section.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return section;
    }

    /**
     * 填报日期
     */
    @Setter
    public Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 联系电话
     */
    @Getter
    @Setter
    public String tel;

    /**
     * 签发领导
     */
    @Getter
    @Setter
    public String signLeader;

    /**
     * 内容
     */
    @Getter
    @Setter
    public String content;

    /**
     * 状态(0:未上报,1:已上报,2:已查收)
     */
    @Getter
    @Setter
    public String status;

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    public String delFlag;

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
     * 数据来源
     */
    @Getter
    @Setter
    public String dataSource;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("deptId", getDicDept() == null ? "" : this.getDicDept().getId());
        jsonObject.put("deptName", getDicDept() == null ? "" : this.getDicDept().getDeptName());
        jsonObject.put("absName",getDicDept() == null ? "" : (this.getDicDept().getAbsName()).substring((this.getDicDept().getAbsName()).indexOf('/') + 1));
        jsonObject.put("creatorName",creatorName);
        jsonObject.put("userId", getDicUser() == null ? "" : this.getDicUser().getId());
        jsonObject.put("userName", getDicUser() == null ? "" : this.getDicUser().getEmpName());
        jsonObject.put("sectionId", getSection() == null ? "" : this.getSection().getId());
        jsonObject.put("sectionName", getSection() == null ? "" : this.getSection().getSectionName());
        jsonObject.put("createTimeStr", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("tel", tel);
        jsonObject.put("signLeader", signLeader);
        jsonObject.put("content", content);
        jsonObject.put("status", status);

        String statusName = "";
        if ("0".equals(status)) {
            statusName = "未上报";
        } else if ("1".equals(status)) {
            statusName = "已上报";
        } else if ("2".equals(status)){
            statusName = "已查收";
        }
        jsonObject.put("statusName",statusName);
        //孙毅添加
        String statusNameStr = "";
        if ("0".equals(status)) {
            statusNameStr = "待上报";
        } else if ("1".equals(status)) {
            statusNameStr = "待查收";
        }
        jsonObject.put("statusNameStr", statusNameStr);
        jsonObject.put("indexContentStr", getSection() == null ? "" : this.getSection().getSectionName()+"&nbsp;&nbsp("+signLeader+" &nbsp;&nbsp 签发)");

        jsonObject.put("delFlag", delFlag);
        jsonObject.put("updateTimeStr", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("dataSource", dataSource);

        return jsonObject;
    }

}
