package com.taiji.frame.model.systempara;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by wd on 2016/2/16.
 * 系统部门表
 */
@Entity
@Table(name="TB_DIC_DEPT",schema = "SCH_DUTY")
public class DicDept extends IdEntity implements Jsonable{


    /**
     * 卫士通资源信息编码
     */
    @Getter
    @Setter
    private String rmsNo;

    /**
     * 部门名称
     */
    @Getter
    @Setter
    private String deptName;

    /**
     * 部门描述
     */
    @Getter
    @Setter
    private String deptDscr;

    /**
     * 操作人
     */
    @Getter
    @Setter
    private String updEmp;

    /**
     * 操作时间
     */
    @Getter
    @Setter
    private Date updDate;

    /**
     * 部门级别
     */
    @Getter
    @Setter
    private Long deptLevel;

    /**
     * 所属部门 pId
     */
    @Getter
    @Setter
    private String parentCode;

    /**
     * zTree ID
     */
    @Getter
    @Setter
    private String deptCode;

    /**
     * 邮政编码
     */
    @Getter
    @Setter
    private String postalCode;

    /**
     * 部门电话
     */
    @Getter
    @Setter
    private String tel;

    /**
     * 隶属关系
     */
    @Getter
    @Setter
    private String ownership;

    /**
     * 单位性质
     */
    @Getter
    @Setter
    private String property;

    /**
     * 单位类别
     */
    @Getter
    @Setter
    private String category;

    /**
     * 单位地址
     */
    @Getter
    @Setter
    private String address;

    /**
     * 编制类型
     */
    @Getter
    @Setter
    private String authType;

    /**
     * 部门名称检索
     * */
    @Getter
    @Setter
    private String absName;

    /**
     * 部门ID检索
     * */
    @Getter
    @Setter
    private String absCode;

    /**
     * 部门显示顺序
     * */
    @Getter
    @Setter
    private Float seq;

    /**
     * 是否删除(1：未删除,0：已删除)
     */
    @Getter
    @Setter
    private Integer status;

    @Setter
    private List<DicUser> dicUserList;


    @OneToMany(cascade = CascadeType.ALL,fetch = FetchType.LAZY,mappedBy = "dicDept",targetEntity = DicUser.class)
    public List<DicUser> getDicUserList() {
        return dicUserList;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("deptName", null == getDeptName() ? "" : getDeptName());
        jsonObject.put("deptDscr",null == getDeptDscr() ? "" : getDeptDscr());
        jsonObject.put("updEmp", null == getUpdEmp() ? "" : getUpdEmp());
        jsonObject.put("updDate", DateUtil.dateToString(updDate, DateUtil.FORMAT_DAY));
        jsonObject.put("deptLevel",null == getDeptLevel() ? "" : getDeptLevel());
        jsonObject.put("parentCode",null == getParentCode() ? "" : getParentCode());
        jsonObject.put("deptCode", null == getDeptCode() ? "" : getDeptCode());
        jsonObject.put("postalCode", null == getPostalCode() ? "" : getPostalCode());
        jsonObject.put("tel", null == getTel() ? "" : getTel());
        jsonObject.put("ownership", null == getOwnership() ? "" : getOwnership());
        jsonObject.put("property", null == getProperty() ? "" : getProperty());
        jsonObject.put("category", null == getCategory() ? "" : getCategory());
        jsonObject.put("address", null == getAddress() ? "" : getAddress());
        jsonObject.put("authType", null == getAuthType() ? "" : getAuthType());
        jsonObject.put("status",null == getStatus() ? "" : getStatus());
        jsonObject.put("absName",null == getAbsName() ? "" : absName.substring(absName.indexOf('/') + 1));
        jsonObject.put("absCode",null == getAbsCode() ? "" : absCode.substring(absCode.indexOf("/") + 1));
        jsonObject.put("seq",seq);
        return jsonObject;
    }

}