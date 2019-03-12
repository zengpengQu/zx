package com.taiji.frame.model.entity.foreignaffairs.privateAbroad;

import com.taiji.frame.model.util.IdEntity;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;

/**
 * 因私护照-文件上传关联表
 * Created by yuLei on 2018/8/2.
 */
@Entity
@Table(name = "DM_PPM_PASSPORT_FILE", schema = "SCH_DUTY")
public class PrivatePassportFile extends IdEntity {

    private static final Logger LOG = LoggerFactory.getLogger(PrivatePassportFile.class);

    /**
     * 因公护照ID
     */
    @Setter
    public PrivatePassport privatePassport;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = PrivatePassport.class)
    @JoinColumn(name = "PASSPORT_ID", referencedColumnName = "ID")
    public PrivatePassport getPrivatePassport() {
        if (privatePassport != null) {
            try {
                privatePassport.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 PrivatePassport privatePassport 失败", e);
                return null;
            }
        }
        return privatePassport;
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
