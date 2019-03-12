package com.taiji.frame.model.entity.foreignaffairs.taiwanCard;

import com.taiji.frame.model.util.IdEntity;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;

/**
 * 赴台通行证文件实体
 * @author qzp
 * @date 2018/08/13
 */
@Entity
@Table(name = "DM_PPM_TAIWAN_FILE", schema = "SCH_DUTY")
public class TaiWanCardFile extends IdEntity {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanCardFile.class);

    /**
     * 赴台通行证ID
     */
    @Setter
    private TaiWanCard taiWanCard;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = TaiWanCard.class)
    @JoinColumn(name = "TAIWAN_ID", referencedColumnName = "ID")
    public TaiWanCard getTaiWanCard() {
        if (taiWanCard != null) {
            try {
                taiWanCard.getId();
            } catch (Exception e) {
                LOGGER.error("获取关联对象 TaiWanCard taiWanCard 失败", e);
                return null;
            }
        }
        return taiWanCard;
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
