package com.taiji.frame.model.systempara;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import java.beans.Transient;
import java.util.Date;


/**
 * 卫士通推送组织架构资源表
 *
 * @author yx
 */
public class WstDept extends IdEntity implements Jsonable {

    /**
     * 组织架构编码
     */
    @Getter
    @Setter
    private String rmsNo;

    /**
     * 名称
     */
    @Getter
    @Setter
    private String rmsName;

    /**
     * 上级组织架构编码
     */
    @Getter
    @Setter
    private String rmsParentNo;

    /**
     * 行政级别
     * 允许值:
     * 0-国家、
     * 1-省（自治区、直辖市）、
     * 2-市（地、州）、
     * 3-县（区）、
     * 4-下级单位、
     * 5-直属单位、
     * 6-部门、
     * 7-小组）
     */
    @Getter
    @Setter
    private String rmsLevel;

    /**
     * 资源状态（0：在用，1-停用，2-销毁）
     */
    @Getter
    @Setter
    private Integer rmsStatus;

    /**
     * 更新日期
     */
    @Getter
    @Setter
    private Date updDate;

    /**
     * 操作人
     */
    @Getter
    @Setter
    private String updEmp;





    @Transient
    @Override
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("rmsNo", null == getRmsNo() ? "" : getRmsNo());
        jsonObject.put("rmsName", null == getRmsName() ? "" : getRmsName());
        jsonObject.put("rmsParentNo", null == getRmsParentNo() ? "" : getRmsParentNo());
        jsonObject.put("rmsLevel", null == getRmsLevel() ? "" : getRmsLevel());
        jsonObject.put("updDate", DateUtil.dateToString(updDate, DateUtil.FORMAT_DAY));
        jsonObject.put("updEmp", null == getUpdEmp() ? "" : getUpdEmp());
        jsonObject.put("rmsStatus", null == getRmsStatus() ? "" : getRmsStatus());

        return jsonObject;
    }
}
