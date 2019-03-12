package com.taiji.frame.model.entity.foreignaffairs.come;

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
 * @author yx
 * @date 2018/8/17
 */
@Entity
@Table(name = "FA_CVM_GIFT_RECEIVE", schema = "SCH_DUTY")
public class ComeGiftRecv extends IdEntity implements Jsonable, Serializable {

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
                return null;
            }
        }
        return comeInfo;
    }

    /**
     * 赠礼人
     */
    @Setter
    @Getter
    public String giver;

    /**
     * 受礼人
     */
    @Setter
    @Getter
    public String receiver;

    /**
     * 受礼人主要职务
     */
    @Setter
    @Getter
    public String mainDuty;

    /**
     * 礼品名称
     */
    @Setter
    @Getter
    public String giftName;

    /**
     * 礼品数量
     */
    @Getter
    @Setter
    public String num;

    /**
     * 处理意见
     */
    @Setter
    @Getter
    public String processOpinion;

    /**
     * 创建时间
     */
    @Setter
    public Date createTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return createTime;
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
        jsonObject.put("comeInfoId", getComeInfo() == null ? "" : getComeInfo().getId());
        jsonObject.put("giver", giver);
        jsonObject.put("receiver", receiver);
        jsonObject.put("mainDuty", mainDuty);
        jsonObject.put("giftName", giftName);
        jsonObject.put("num", num);
        jsonObject.put("processOpinion", processOpinion);
        jsonObject.put("updateTime", updateTime);

        return jsonObject;
    }
}
