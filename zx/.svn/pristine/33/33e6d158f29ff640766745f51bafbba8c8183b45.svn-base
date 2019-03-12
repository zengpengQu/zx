package com.taiji.frame.model.entity.foreignaffairs.taiwan;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.taiji.frame.common.util.DateUtil;
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
 * @author qzp
 * @date 2018/08/07
 * 台湾主要人士
 */
@Entity
@Table(name = "DM_PPM_TAIWAN_POLITICS",schema = "SCH_DUTY")
public class TaiWanPolitics extends IdEntity implements Jsonable,Serializable {

    /**
     * 姓名
     */
    @Setter
    @Getter
    private String mainName;

    /**
     * 性别 0男性，1女性
     */
    @Setter
    @Getter
    private String gender;


    /**
     * 出生日期
     */
    @Setter
    @Getter
    private Date birthday;

    /**
     * 所属单位
     */
    @Setter
    @Getter
    private String belongOrg;

    /**
     * 职务
     */
    @Setter
    @Getter
    private String duty;

    @Transient
    private String getSex() {
        if (null == gender) {
            return "未知";
        } else if (gender.equals("0")) {
            return "男";
        } else if (gender.equals("1")) {
            return "女";
        } else {
            return "未知";
        }
    }

    /**
     * 台湾社团ID
     */
    @Setter
    private TaiWanParty taiWanParty;

    @JoinColumn(name = "PARTY_ID",referencedColumnName = "ID")
    @ManyToOne(fetch = FetchType.LAZY,targetEntity = TaiWanParty.class)
    public TaiWanParty getTaiWanParty() {
        if (taiWanParty != null){
            try {
                taiWanParty.getId();
            } catch (Exception e) {
                return null;
            }
        }
        return taiWanParty;
    }

    /**
     * 创建时间
     */
    private Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * 更新时间
     */
    private Date updateTime;

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

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("mainName",mainName);
        jsonObject.put("gender", getSex());
        jsonObject.put("genderStr", getSex());
        jsonObject.put("birthday",DateUtil.dateToString(birthday, DateUtil.FORMAT_DAY));
        jsonObject.put("birthdayStr",DateUtil.dateToString(birthday, DateUtil.FORMAT_DAY));
        jsonObject.put("belongOrg",belongOrg);
        jsonObject.put("duty",duty);
        jsonObject.put("partyId",getTaiWanParty().getId());
        jsonObject.put("partyNameStr",getTaiWanParty().getPartyName());
        jsonObject.put("createTime",DateUtil.dateToString(createTime, DateUtil.FORMAT_DAY));
        jsonObject.put("updateTime",DateUtil.dateToString(updateTime, DateUtil.FORMAT_DAY));
        jsonObject.put("notes",notes);
        jsonObject.put("delFlag",delFlag);
        return jsonObject;
    }
}
