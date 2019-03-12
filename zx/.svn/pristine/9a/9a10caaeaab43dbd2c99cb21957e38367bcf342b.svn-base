package com.taiji.frame.model.entity.pubinfo.contacts;

import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * @author sy
 * 通讯录-2表
 */
@Entity
@Table(name = "PU_CMM_LISTT", schema = "SCH_DUTY")
public class CmmListt extends IdEntity implements Jsonable, Serializable {

    /**
     * 所属单位编码
     */
    @Setter
    public DicDept dicDept;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = DicDept.class)
    @JoinColumn(name = "ORG_ID", referencedColumnName = "ID")
    public DicDept getDicDept() {
        return dicDept;
    }

    /**
     * 所属单位名称
     */
    @Getter
    @Setter
    public String orgName;

    /**
     * 办公电话
     */
    @Getter
    @Setter
    public String jobTel;

    /**
     * 办公室
     */
    @Getter
    @Setter
    public String location;

    /**
     * 排序
     */
    @Getter
    @Setter
    public String seq;

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    public String delFlag;

    /**
     * 分组编码
     */
    @Setter
    public AddressTeam addressTeam;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = AddressTeam.class)
    @JoinColumn(name = "TEAM_ID", referencedColumnName = "ID")
    public AddressTeam getAddressTeam() {
        return addressTeam;
    }

    @Setter
    private List<CmmList> cmmListUsers;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true, mappedBy = "cmmListDepts", targetEntity = CmmList.class)
    @Where(clause = "DEL_FLAG = 0")
    public List<CmmList> getCmmListUsers() {
        return cmmListUsers;
    }



    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("deptId", dicDept== null ? "" : dicDept.getId());
        jsonObject.put("deptName", dicDept== null ? "" : dicDept.getDeptName());
        jsonObject.put("orgName", orgName);
        jsonObject.put("deptJobTel", jobTel);
        jsonObject.put("location", location);
        jsonObject.put("seq", seq);
        jsonObject.put("delFlag", delFlag);
        jsonObject.put("teamId", addressTeam== null ? "" : addressTeam.getId());
        return jsonObject;
    }
}
