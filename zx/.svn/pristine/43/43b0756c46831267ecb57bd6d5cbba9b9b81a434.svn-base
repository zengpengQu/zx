package com.taiji.frame.model.vo.pubinfo.batch;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;

public class ConmentsVo implements Jsonable,Serializable {

    /**
     * 存储更新的时间
     * @return
     */
    @Getter
    @Setter
    public Date updateTime;

    /**
     * 用于存储更新时间的时分秒
     */
    @Setter
    @Getter
    public String hourTime;

    /**
     * 存储会签人的姓名，领导批示时的领导姓名
     * @return
     */
    @Setter
    @Getter
    public String reportLeader;

    /**
     * 存储会签单位
     * @return
     */
    @Getter
    @Setter
    public String countersignUnitName;

    /**
     * 存储领导批示时领导的职务
     * @return
     */
    @Setter
    @Getter
    public String dutyName;

    /**
     * 存储会签人意见，领导的批示
     * @return
     */
    @Getter
    @Setter
    public String conmentsLeaer;

    @Override
    @Transient
    public JSON getJsonObject() {

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("updateTime",updateTime == null ? "":updateTime);
        jsonObject.put("reportLeader",reportLeader == null ? "":reportLeader);
        jsonObject.put("countersignUnitName",countersignUnitName == null ? "":countersignUnitName);
        jsonObject.put("dutyName",dutyName == null ? "":dutyName);
        jsonObject.put("conmentsLeaer",conmentsLeaer == null ? "":conmentsLeaer);
        jsonObject.put("hourTime",hourTime == null ? "":hourTime);
        return jsonObject;
    }
}
