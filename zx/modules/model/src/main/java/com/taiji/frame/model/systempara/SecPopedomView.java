package com.taiji.frame.model.systempara;

import com.taiji.frame.model.util.IdEntity;
import org.hibernate.annotations.*;
import org.hibernate.annotations.OrderBy;

import javax.persistence.*;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.math.BigDecimal;
import java.util.List;

/**
 * Created by wd on 2016/2/16.
 * 系统资源
 */
@Entity
@Table(name="TB_SEC_POPEDOM_VIEW",schema = "SCH_DUTY")
public class SecPopedomView extends IdEntity{

    private String parentId;//父菜单ID

//    private SecPopedomView parentSecPopedomView; // 父菜单  （对应parentId）

    private String description;//描述

    private String name;//菜单名称

    private String type;//类型

    private String url;//链接

    private String position;//位置

    private Integer activity;//是否启用 （是:0;否:1）

//    private List<SecPopedomView> subSecPopedomViewList;//子菜单


//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "PARENT_ID")
//    public SecPopedomView getParentSecPopedomView() {
//        return parentSecPopedomView;
//    }
//
//    public void setParentSecPopedomView(SecPopedomView parentSecPopedomView) {
//        this.parentSecPopedomView = parentSecPopedomView;
//    }
//
//    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "parentSecPopedomView")
//    @OrderBy(clause = "id asc")
//    public List<SecPopedomView> getSubSecPopedomViewList() {
//        return subSecPopedomViewList;
//    }
//
//    public void setSubSecPopedomViewList(List<SecPopedomView> subSecPopedomViewList) {
//        this.subSecPopedomViewList = subSecPopedomViewList;
//    }

    @Column(name = "PARENT_ID", nullable = true)
    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    @Column(name = "DESCRIPTION", nullable = true)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    @Column(name = "NAME", nullable = true)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    @Column(name = "TYPE", nullable = true)
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    @Column(name = "URL", nullable = true)
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Column(name = "POSITION", nullable = true)
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    @Column(name = "ACTIVITY", nullable = false)
    public Integer getActivity() {
        return activity;
    }

    public void setActivity(Integer activity) {
        this.activity = activity;
    }


}
