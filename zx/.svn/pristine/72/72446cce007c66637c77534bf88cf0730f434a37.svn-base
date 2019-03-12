package com.taiji.frame.model.systempara;

import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * 系统国家信息
 * Created by yuLei on 2018/8/16.
 */
@Entity
@Table(name = "TB_DIC_NATION",schema = "SCH_DUTY")
public class DicNation extends IdEntity implements Jsonable {

    /**
     * 国家名称
     */
    @Getter
    @Setter
    private String nationName;

    /**
     * 英文国家名称
     */
    @Getter
    @Setter
    private String enName;

    /**
     * 所属地区
     */
    @Getter
    @Setter
    private String area;

    /**
     * 风险等级
     */
    @Getter
    @Setter
    private String riskLevel;

    /**
     * 是否申根国家（0：是，1：不是）
     */
    @Getter
    @Setter
    private String isSchengen;

    /**
     * 是否互免签证（0：是，1：不是）
     */
    @Getter
    @Setter
    private String isExemption;

    /**
     * 是否统办（0：是，1：不是）
     */
    @Getter
    @Setter
    private String isConsort;

    /**
     * 是否启用（0：启用，1：不启用）
     */
    @Getter
    @Setter
    private String enable;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("nationName", nationName);
        jsonObject.put("enName", enName);
        jsonObject.put("area", area);
        jsonObject.put("riskLevel", riskLevel);
        jsonObject.put("isSchengen", isSchengen);
        jsonObject.put("isExemption", isExemption);
        jsonObject.put("isConsort", isConsort);
        jsonObject.put("enable", enable);
        return jsonObject;
    }

}
