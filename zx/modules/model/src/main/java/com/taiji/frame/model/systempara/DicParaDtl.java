package com.taiji.frame.model.systempara;

import com.taiji.frame.model.util.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

/**
 * Created by wd on 2016/2/16.
 * 系统参数明细
 */
@Entity
@Table(name="TB_DIC_PARA_DTL",schema = "SCH_DUTY")
public class DicParaDtl extends IdEntity{

    @Getter
    @Setter
    private String paraType;//类型

    @Getter
    @Setter
    private String paraName;//名称

    @Getter
    @Setter
    private String paraDscr;//描述

    @Getter
    @Setter
    private Integer isDelete;//是否删除   0未删；1已删

    @Getter
    @Setter
    private Integer seq;//排序  顺序 0代表最高等级
}
