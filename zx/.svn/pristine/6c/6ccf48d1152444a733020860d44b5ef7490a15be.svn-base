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
 * @author zbf
 * Created by Zbf on 2018/06/21
 * 出访任务字典表
 */
@Entity
@Table(name = "FA_OAM_ACCESS_TASK" , schema = "SCH_DUTY")
public class AccessTask extends IdEntity implements Jsonable, Serializable {

    //0.通过继承IdEntity获得ID

    /**
     * 1.
     * 出访任务
     *
     */
    @Setter
    @Getter
    public String accessTask;


    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("accessTaskId" , id);
        jsonObject.put("accessTask" , accessTask);

        return jsonObject;
    }
}
