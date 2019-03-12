package com.taiji.frame.model.vo.pubinfo.schedule;

import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import java.io.Serializable;

public class SectionVo implements Jsonable,Serializable {


    /**
     * 板块ID
     * */
    @Getter
    @Setter
    private String sectionId;

    /**
     * 板块内容
     * */
    @Getter
    @Setter
    private String sectionContent;


    @Override
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("sectionId",sectionId);
        jsonObject.put("sectionContent",sectionContent);

        return jsonObject;
    }
}
