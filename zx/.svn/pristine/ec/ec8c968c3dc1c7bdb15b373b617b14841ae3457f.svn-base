package com.taiji.frame.model.entity.foreignaffairs.taiwan;

import com.taiji.frame.model.util.IdEntity;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;

/**
 * @author qzp
 * @date 2018/08/07
 * 台湾社团文件关系表
 */
@Entity
@Table(name = "DM_PPM_TAIWAN_PARTY_FILE",schema = "SCH_DUTY")
public class TaiWanPartyFile extends IdEntity {
    private static final Logger LOG = LoggerFactory.getLogger(TaiWanPartyFile.class);

    /**
     * 台湾社团ID
     */
    @Setter
    private TaiWanParty taiWanParty;

    @OneToOne(fetch = FetchType.LAZY,targetEntity = TaiWanParty.class)
    @JoinColumn(name = "P_ID",referencedColumnName = "ID")
    public TaiWanParty getTaiWanParty() {
        if (taiWanParty != null){
            try {
                taiWanParty.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 TaiWanParty taiWanParty 失败", e);
            }
        }
        return taiWanParty;
    }

    /**
     * 文件ID
     */
    @Getter
    @Setter
    private String fileId;

    /**
     * 文件名
     */
    @Getter
    @Setter
    private String fileName;

    /**
     * 文件seq
     */
    @Setter
    @Getter
    public Integer seq;
}
