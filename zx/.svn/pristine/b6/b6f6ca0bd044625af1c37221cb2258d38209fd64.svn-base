package com.taiji.frame.model.entity.pubinfo.contacts;

import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;

import javax.persistence.*;
import java.io.Serializable;
/**
 * @author sy
 * 通讯录中间表
 * 貌似 无用
 */
@Entity
@Table(name = "PU_ADD_TEAM", schema = "SCH_DUTY")
public class AddTeam extends IdEntity implements Jsonable, Serializable {

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

    /**
     * 分组编码
     */
    @Setter
    public CmmList cmmList;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = AddressTeam.class)
    @JoinColumn(name = "CMM_LIST_ID", referencedColumnName = "ID")
    public CmmList getCmmList() {
        return cmmList;
    }

    /**
     * 删除标志(0:未删除,1:删除)
     */
    @Getter
    @Setter
    public String delFlag;

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("id", id);
        jsonObject.put("teamId", addressTeam.getId());
        jsonObject.put("cmmListId", cmmList.getId());
        jsonObject.put("delFlag", delFlag);

        return jsonObject;
    }
}
