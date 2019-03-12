package com.taiji.frame.model.entity.foreignaffairs.nationCondition;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.systempara.DicNation;
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
 * 国家情况管理
 * Created by yuLei on 2018/8/13.
 */
@Entity
@Table(name="DM_CIM_NATION_CONDITION_MANAGEMENT",schema = "SCH_DUTY")
public class NationConditionManagement extends IdEntity implements Jsonable, Serializable {

    private static final Logger LOG = LoggerFactory.getLogger(NationConditionManagement.class);

    public NationConditionManagement() {}

    /**
     * 国家名称
     */
    @Setter
    public DicNation dicNation;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicNation.class)
    @JoinColumn(name = "NATION_NAME", referencedColumnName = "ID")
    public DicNation getDicNation() {
        if(dicNation != null) {
            try {
                dicNation.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象DicNation dicNation错误",e);
                return null;
            }
        }
        return dicNation;
    }

    /**
     * 国家简介
     */
    @Getter
    @Setter
    private String nationIntro;

    /**
     * 所属地区
     */
    @Getter
    @Setter
    private String belongArea;

    /**
     * 是否一带一路国家(0:是,1:否)
     */
    @Getter
    @Setter
    private String isOborNation;

    /**
     * 是否周边国家(0:是,1:否)
     */
    @Getter
    @Setter
    private String isAroundNation;

    /**
     * 是否阿拉伯国家(0:是,1:否)
     */
    @Getter
    @Setter
    private String isArabNation;

    /**
     * 是否其他西方发达国家(0:是,1:否)
     */
    @Getter
    @Setter
    private String isWestNation;

    /**
     * 是否其他国家(0:是,1:否)
     */
    @Getter
    @Setter
    private String isOtherNation;

    /**
     * 风俗礼仪禁忌
     */
    @Getter
    @Setter
    private String moresProtocolTaboo;

    /**
     * 入境注意事项
     */
    @Getter
    @Setter
    private String ehtryNotices;

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
     * 重要人物简介list
     */
    @Setter
    private List<VipPersonIntro> vipPersonIntroList;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "nationConditionManagement", targetEntity = VipPersonIntro.class)
    public List<VipPersonIntro> getVipPersonIntroList() {
        return vipPersonIntroList;
    }

    /**
     * 重要议会简介list
     */
    @Setter
    private List<ParliamentIntro> parliamentIntroList;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "nationConditionManagement", targetEntity = ParliamentIntro.class)
    public List<ParliamentIntro> getParliamentIntroList() {
        return parliamentIntroList;
    }

    /**
     * 交往情况list
     */
    @Setter
    private List<ContactCondition> contactConditionList;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "nationConditionManagement", targetEntity = ContactCondition.class)
    public List<ContactCondition> getContactConditionList() {
        return contactConditionList;
    }

    /**
     * 城市/景点简介list
     */
    @Setter
    private List<CitySceneryIntro> citySceneryIntroList;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "nationConditionManagement", targetEntity = CitySceneryIntro.class)
    public List<CitySceneryIntro> getCitySceneryIntroList() {
        return citySceneryIntroList;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("nationId", null == getDicNation() ? "" : getDicNation().getId());
        jsonObject.put("nationName", null == getDicNation() ? "" : getDicNation().getNationName());
        jsonObject.put("nationIntro", nationIntro);
        jsonObject.put("belongArea", belongArea);
        jsonObject.put("isOborNation", isOborNation);
        if (isArabNation.equals("0")) {
            jsonObject.put("isOborNationVal", "是");
        } else if (isArabNation.equals("1")) {
            jsonObject.put("isOborNationVal", "否");
        }
        jsonObject.put("isAroundNation", isAroundNation);
        if (isAroundNation.equals("0")) {
            jsonObject.put("isAroundNationVal", "是");
        } else if (isAroundNation.equals("1")) {
            jsonObject.put("isAroundNationVal", "否");
        }
        jsonObject.put("isArabNation", isArabNation);
        if (isArabNation.equals("0")) {
            jsonObject.put("isArabNationVal", "是");
        } else if (isArabNation.equals("1")) {
            jsonObject.put("isArabNationVal", "否");
        }
        jsonObject.put("isWestNation", isWestNation);
        if (isWestNation.equals("0")) {
            jsonObject.put("isWestNationVal", "是");
        } else if (isWestNation.equals("1")) {
            jsonObject.put("isWestNationVal", "否");
        }
        jsonObject.put("isOtherNation", isOtherNation);
        if (isOtherNation.equals("0")) {
            jsonObject.put("isOtherNationVal", "是");
        } else if (isOtherNation.equals("1")) {
            jsonObject.put("isOtherNationVal", "否");
        }
        jsonObject.put("moresProtocolTaboo", moresProtocolTaboo);
        jsonObject.put("ehtryNotices", ehtryNotices);
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("createTime", DateUtil.dateToString(createTime, DateUtil.FORMAT_DAYTIME));
        jsonObject.put("updateTime", DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAYTIME));
        return jsonObject;
    }

}
