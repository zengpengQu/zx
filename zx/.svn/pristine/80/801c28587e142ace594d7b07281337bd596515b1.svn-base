package com.taiji.frame.model.entity.foreignaffairs.abroad;

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
 * @author Zbf
 * Created by Zbf on 2018/06/21
 * 费用来源字典表
 */
@Entity
@Table(name = "FA_OAM_COST_SOURCE" , schema = "SCH_DUTY")
public class CostSource extends IdEntity implements Jsonable,Serializable {

    //0.通过继承IdEntity获得ID

    /**
     * 1.
     * 费用来源
     *
     */
    @Setter
    @Getter
    public String source;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("sourceId" , id);
        jsonObject.put("source" , source);

        return jsonObject;
    }
}
