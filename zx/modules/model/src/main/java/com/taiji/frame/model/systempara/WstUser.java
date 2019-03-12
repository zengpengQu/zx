package com.taiji.frame.model.systempara;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.Date;


/**
 * 卫士通推送人员资源表
 *
 * @author yx
 */
@Entity
@Table(name = "TB_WST_USER", schema = "SCH_DUTY")
public class WstUser extends IdEntity implements Jsonable {

    /**
     * 人员资源编码
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
     * 密码
     */
    @Getter
    @Setter
    private String rmsPassword;

    /**
     * 性别（允许值：男、女）
     */
    @Getter
    @Setter
    private String rmsGender;

    /**
     * 民族
     */
    @Getter
    @Setter
    private String rmsNationality;

    /**
     * 出生日期
     */
    @Getter
    @Setter
    private Date rmsBirthday;

    /**
     * 出生地
     */
    @Getter
    @Setter
    private String rmsHomePlace;

    /**
     * 所属组织机构编码
     */
    @Getter
    @Setter
    private String rmsOrgNo;

    /**
     * 电子邮件
     */
    @Getter
    @Setter
    private String rmsEmail;

    /**
     * 密级（核心、重要、一般、非涉密）
     */
    @Getter
    @Setter
    private String rmsSecurityLevel;

    /**
     * 职务编码
     */
    @Getter
    @Setter
    private String rmsPostNo;

    /**
     * 职务级别编码
     */
    @Getter
    @Setter
    private String rmsPostLevelNo;

    /**
     * 联系电话
     */
    @Getter
    @Setter
    private String rmsTelephoneNumber;

    /**
     * 资源状态（0：在用，1-停用，2-销毁）
     */
    @Getter
    @Setter
    private Integer rmsStatus;

    /**
     * 更新时间
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

    /**
     * 用户id
     */
    @Getter
    @Setter
    private String userId;

    @Transient
    @Override
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("rmsNo", null == getRmsName() ? "" : getRmsNo());
        jsonObject.put("rmsName", null == getRmsName() ? "" : getRmsName());
        jsonObject.put("rmsPassword", null == getRmsPassword() ? "" : getRmsPassword());
        jsonObject.put("rmsGender", null == getRmsGender() ? "" : getRmsGender());
        jsonObject.put("rmsNationality", null == getRmsNationality() ? "" : getRmsNationality());
        jsonObject.put("rmsBirthday", null == getRmsBirthday() ? "" : getRmsBirthday());
        jsonObject.put("rmsHomePlace", null == getRmsHomePlace() ? "" : getRmsHomePlace());
        jsonObject.put("rmsOrgNo", null == getRmsOrgNo() ? "" : getRmsOrgNo());
        jsonObject.put("rmsEmail", null == getRmsEmail() ? "" : getRmsEmail());
        jsonObject.put("rmsSecurityLevel", null == getRmsSecurityLevel() ? "" : getRmsSecurityLevel());
        jsonObject.put("rmsPostNo", null == getRmsPostNo() ? "" : getRmsPostNo());
        jsonObject.put("rmsPostLevelNo", null == getRmsPostLevelNo() ? "" : getRmsPostLevelNo());
        jsonObject.put("rmsTelephoneNumber", null == getRmsTelephoneNumber() ? "" : getRmsTelephoneNumber());
        jsonObject.put("rmsStatus", null == getRmsStatus() ? "" : getRmsStatus());
        jsonObject.put("updDate", DateUtil.dateToString(updDate, DateUtil.FORMAT_DAY));
        jsonObject.put("updEmp", null == getUpdEmp() ? "" : getUpdEmp());
        jsonObject.put("userId", null == getUserId() ? "" : getUserId());

        return jsonObject;
    }
}