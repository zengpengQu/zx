package com.taiji.frame.model.entity.pubinfo.schedule;

import com.taiji.frame.model.util.IdEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * @author admin
 * 板块类型
 */
@Entity
@Table(name = "PU_SECTION_TYPE", schema = "SCH_DUTY")
public class Section extends IdEntity implements Serializable {

    /**
     * 板块名称
     * */
    @Getter
    @Setter
    protected String sectionName;

    /**
     * 删除标记
     * */
    @Getter
    @Setter
    protected String delFlag;

    /**
     * 板块重要度
     * */
    @Getter
    @Setter
    protected String level;


}
