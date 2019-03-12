package com.taiji.frame.model.vo.pubinfo.batch;

import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import java.io.Serializable;

public class DicReasonVo extends DicReason implements Jsonable,Serializable {


    /**
     * 板块ID
     * */
    @Getter
    @Setter
    private String reasonId;

    /**
     * 板块内容
     * */
    @Getter
    @Setter
    private String reason;


    @Override
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("reasonId",reasonId);
        jsonObject.put("reason",reason);

        return jsonObject;
    }
}
