package com.taiji.frame.model.entity.inspection.place;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @author sy
 * 地区表
 */
@Entity
@Table(name = "TB_DIC_DISTRICT", schema = "SCH_DUTY")
public class District extends IdEntity implements Jsonable, Serializable {

    /**
     * 地区编号
     */
    @Getter
    @Setter
    public String code;
    /**
     * 所属地区编号
     */
    @Getter
    @Setter
    public String parentCode;

    /**
     * 地区名称
     */
    @Setter
    @Getter
    public String districtName;

    /**
     * 经度
     */
    @Getter
    @Setter
    public String longitude;

    /**
     * 纬度
     */
    @Getter
    @Setter
    public String latitude;

    /**
     * 状态，1可用 ，0不可用
     */
    @Setter
    @Getter
    public String status;


    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id",id);
        jsonObject.put("code",code);
        jsonObject.put("parentCode",parentCode);
        jsonObject.put("districtName",districtName);
        jsonObject.put("longitude",longitude);
        jsonObject.put("latitude",latitude);
        return jsonObject;
    }
}
