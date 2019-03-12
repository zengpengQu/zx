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
 * 视察考察调研活动调整
 */
@Entity
@Table(name = "IN_ACT_CORRECT", schema = "SCH_DUTY")
public class Correct extends IdEntity implements Jsonable, Serializable {


    /**
     * 活动安排ID
     */
    @Setter
    public Place placeList;
    @ManyToOne(fetch = FetchType.LAZY, targetEntity = Place.class)
    @JoinColumn(name = "ACT_LIST_ID", referencedColumnName = "ID")
    public Place getPlaceList() {
        return placeList;
    }

    /**
     * 调整备注
     */
    @Getter
    @Setter
    public String text;

    /**
     * 状态，1，未调整，2以调整
     */
    @Getter
    @Setter
    public String state;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("text",text);
        jsonObject.put("placeId",placeList.getId());
        jsonObject.put("state",state);

        return jsonObject;
    }
}
