package com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs;

import com.taiji.frame.model.util.IdEntity;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;

/**
 * 临时外事活动-文件上传关联表
 * Created by yuLei on 2018/7/20.
 */
@Entity
@Table(name = "FA_TFA_TEMP_AFFAIRS_FILE", schema = "SCH_DUTY")
public class TempAffairsFile extends IdEntity {

    private static final Logger LOG = LoggerFactory.getLogger(TempAffairsFile.class);

    /**
     * 临时外事活动ID
     */
    @Setter
    public TempAffairs tempAffairs;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = TempAffairs.class)
    @JoinColumn(name = "AFFAIRS_ID", referencedColumnName = "ID")
    public TempAffairs getTempAffairs() {
        if (tempAffairs != null) {
            try {
                tempAffairs.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 TempAffairs tempAffairs 失败", e);
                return null;
            }
        }
        return tempAffairs;
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
