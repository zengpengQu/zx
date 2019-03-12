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
 * 时段选择
 *
 */
@Entity
@Table(name = "FA_OAM_PERIOD" , schema = "SCH_DUTY")
public class Period extends IdEntity implements Jsonable, Serializable{

    //0.通过继承IdEntity获得ID

    /**
     * 1.
     * 时段选择 0：不选择 1：上午 2：下午 3：全天
     *
     */
    @Setter
    @Getter
    public String period;



    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("periodId" , id);
        jsonObject.put("period" , period);

        return jsonObject;
    }
}
