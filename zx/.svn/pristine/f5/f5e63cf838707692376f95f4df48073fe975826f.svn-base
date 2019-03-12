package com.taiji.frame.model.systempara;


import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;


/**
 * 卫士通推送资源
 *
 * @author yx
 */
@Entity
@Table(name = "TB_WST_RESOURCE", schema = "SCH_DUTY")
public class WstResource extends IdEntity implements Jsonable {

    /**
     * 资源版本
     */
    @Getter
    @Setter
    private Integer rmsVersion;

    /**
     * 资源信息编码
     */
    @Getter
    @Setter
    private String rmsNo;

    /**
     * 所属资源信息管理服务系统编码
     */
    @Getter
    @Setter
    private String rmsRmsid;

    /**
     * 名称
     */
    @Getter
    @Setter
    private String rmsName;

    /**
     * 资源信息状态：0-在用，1-停用，2-销毁
     */
    @Getter
    @Setter
    private Integer rmsStatus;


    @Transient
    @Override
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("rmsNo", rmsNo);
        jsonObject.put("rmsRmsid", rmsRmsid);
        jsonObject.put("rmsName", rmsName);
        jsonObject.put("rmsStatus", rmsStatus);
        jsonObject.put("rmsVersion", rmsVersion);

        return jsonObject;
    }
}