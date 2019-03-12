package com.taiji.frame.model.entity.pubinfo.batch;

import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serializable;

/**
 * @author admin
 * 板块类型
 */
@Entity
@Table(name = "PU_DUTY_SEQ", schema = "SCH_DUTY")
public class DicDuty extends IdEntity implements Jsonable,Serializable {

    /**
     *  职务名称
     * */
    @Getter
    @Setter
    protected String dutyName;

    /**
     *  排序
     * */
    @Getter
    @Setter
    protected String seq;

    /**
     *  删除标志位
     */
    @Getter
    @Setter
    public String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("dutyName", dutyName);
        jsonObject.put("seq", seq);
        jsonObject.put("deFlag",delFlag);

        return jsonObject;
    }




}
