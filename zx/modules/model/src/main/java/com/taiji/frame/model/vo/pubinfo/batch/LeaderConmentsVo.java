package com.taiji.frame.model.vo.pubinfo.batch;

import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import java.io.Serializable;

public class LeaderConmentsVo implements Jsonable,Serializable {

    //领导名称
    @Getter
    @Setter
    public String leaderName;

    //领导职务
    @Setter
    @Getter
    public String dutyName;

    //领导批示
    @Getter
    @Setter
    public String conments;

    //批示时间
    @Setter
    @Getter
    public String timeStr;


   @Override
    public JSON getJsonObject(){
       JSONObject jsonObject = new JSONObject();
       jsonObject.put("leaderName",leaderName == null ? "" : leaderName);
       jsonObject.put("dutyName",dutyName == null ? "" : dutyName);
       jsonObject.put("conments",conments == null ? "" : conments);
       jsonObject.put("timeStr",timeStr == null ? "" : timeStr);
       return  jsonObject;
   }
}
