package com.taiji.frame.model.systempara;

import com.taiji.frame.model.util.IdEntity;

import javax.persistence.*;

/**
 * Created by wd on 2016/2/16.
 * 系统角色与资源对照
 */
@Entity
@Table(name="TB_SEC_POP_ASS",schema = "SCH_DUTY")
public class SecPopAss extends IdEntity{
    private SecRole role;//角色（外键 roleID）

    private SecPopedomView pope;//资源（外键 popeID）

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ROLE_ID",nullable = false)
    public SecRole getRole() {
        return role;
    }

    public void setRole(SecRole role) {
        this.role = role;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "POPE_ID",nullable = false)
    public SecPopedomView getPope() {
        return pope;
    }

    public void setPope(SecPopedomView pope) {
        this.pope = pope;
    }
}
