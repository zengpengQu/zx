package com.taiji.frame.model.entity.foreignaffairs.businessPassport;

import com.taiji.frame.model.util.IdEntity;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;

/**
 * 因公护照-文件上传关联表
 * Created by yuLei on 2018/7/26.
 */
@Entity
@Table(name = "BP_BUSINESS_PASSPORT_FILE", schema = "SCH_DUTY")
public class BusinessPassportFile extends IdEntity {

    private static final Logger LOG = LoggerFactory.getLogger(BusinessPassportFile.class);

    /**
     * 因公护照ID
     */
    @Setter
    public BusinessPassport businessPassport;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = BusinessPassport.class)
    @JoinColumn(name = "PASSPORT_ID", referencedColumnName = "ID")
    public BusinessPassport getBusinessPassport() {
        if (businessPassport != null) {
            try {
                businessPassport.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 BusinessPassport businessPassport 失败", e);
                return null;
            }
        }
        return businessPassport;
    }

    /**
     * 文件ID
     */
    @Getter
    @Setter
    private String fileId;

    /**
     * 文件seq
     */
    @Setter
    @Getter
    public Integer seq;

}
