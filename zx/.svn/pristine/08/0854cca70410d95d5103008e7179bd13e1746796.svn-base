package com.taiji.frame.model.systempara;

import com.taiji.frame.model.util.IdEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by wd on 2016/2/16.
 * 系统参数
 */
@Entity
@Table(name="TB_DIC_PARA",schema = "SCH_DUTY")
public class DicPara extends IdEntity{
    private String typeName;//名称

    @Column(name = "TYPE_NAME", nullable = false)
    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}
