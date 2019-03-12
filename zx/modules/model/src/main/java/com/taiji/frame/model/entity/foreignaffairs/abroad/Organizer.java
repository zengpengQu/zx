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
 * 主办单位字典表
 */
@Entity
@Table(name= "FA_OAM_ORGANIZER" , schema = "SCH_DUTY")
public class Organizer extends IdEntity implements Jsonable, Serializable {

    //0.通过继承IdEntity获得ID

    /**
     * 1.
     * 主办单位
     *
     */
    @Setter
    @Getter
    public String organizer;


    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("organizerId" , id);
        jsonObject.put("organizer" , organizer);

        return jsonObject;
    }
}
