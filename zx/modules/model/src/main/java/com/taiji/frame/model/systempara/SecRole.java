package com.taiji.frame.model.systempara;

import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by wd b 2016/2/16.
 * 系统角色
 */
@Entity
@Table(name="TB_SEC_ROLE",schema = "SCH_DUTY")
public class SecRole extends IdEntity implements Jsonable{

    @Getter
    @Setter
    private String roleDesc;//角色描述

    @Getter
    @Setter
    private String roleName;//角色名称

    @Getter
    @Setter
    private Integer isactive;//是否启用 0禁用，1激活

    @Getter
    @Setter
    private Date updDate;

    @Getter
    @Setter
    private String updEmp;

    private List<DicUser>  dicUserList;  //拥有此角色的人列表

    private List<SecPopedomView> secPopedomViewList;  //拥有此角色的菜单列表


    /**
     * 获得角色关联用户。保存角色，关联用户集合不为空，级联操作关联表。
     */
    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(name = "TB_SEC_PRI_ASS",schema = "SCH_DUTY", joinColumns = {@JoinColumn(name = "ROLE_ID", updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "USER_ID", updatable = false)})
    public List<DicUser> getDicUserList() {
        return dicUserList;
    }

    public void setDicUserList(List<DicUser> dicUserList) {
        this.dicUserList = dicUserList;
    }
    /**
     * 获得角色关联权限项。保存角色，关联权限项集合不为空，级联操作关联表。
     */
    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(name = "TB_SEC_POP_ASS",schema="SCH_DUTY", joinColumns = {@JoinColumn(name = "ROLE_ID", updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "POPE_ID", updatable = false)})
    @OrderBy(value = "position asc")
    @Where(clause = "activity=1")
    public List<SecPopedomView> getSecPopedomViewList() {
        return secPopedomViewList;
    }

    public void setSecPopedomViewList(List<SecPopedomView> secPopedomViewList) {
        this.secPopedomViewList = secPopedomViewList;
    }

    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
        jsonObject.put("roleName", roleName);
        jsonObject.put("isactive", isactive);
        jsonObject.put("roleDesc", roleDesc);
        return jsonObject;
    }
}
