package com.taiji.frame.model.vo.pubinfo.batch;

import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import java.io.Serializable;

public class DicDeptVo extends DicDept implements Jsonable,Serializable {


    /**
     * 单位ID
     * */
    @Getter
    @Setter
    private String deptId;

    /**
     * 单位名称
     * */
    @Getter
    @Setter
    private String deptName;

    @Getter
    @Setter
    private String parentId;




    @Override
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();

        jsonObject.put("deptId",deptId);
        jsonObject.put("parentId",parentId);
        jsonObject.put("deptName",deptName);
        return jsonObject;
    }

}
