package com.taiji.frame.model.entity.foreignaffairs.hkmacao;

import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.util.IdEntity;
import lombok.Getter;
import lombok.Setter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;

/**
 * @author qzp
 * @date 2018/08/07
 * 港澳通行证文件关系表
 */
@Entity
@Table(name = "DM_PPM_HKMACAO_FILE",schema = "SCH_DUTY")
public class HkMaCaoFile extends IdEntity {
    private static final Logger LOG = LoggerFactory.getLogger(HkMaCaoFile.class);

    /**
     * 港澳通行证ID
     */
    @Setter
    private HkMaCao hkMaCao;

    @OneToOne(fetch = FetchType.LAZY,targetEntity = HkMaCao.class)
    @JoinColumn(name = "HKMACAO_ID",referencedColumnName = "ID")
    public HkMaCao getHkMaCao() {
        if (hkMaCao != null){
            try {
                hkMaCao.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 HkMaCao hkMaCao 失败", e);
            }
        }
        return hkMaCao;
    }

    /**
     * 文件ID
     */
    @Setter
    public DicUploadFile dicUploadFile;

    @OneToOne(fetch = FetchType.LAZY, targetEntity = DicUploadFile.class)
    @JoinColumn(name = "FILE_ID", referencedColumnName = "ID")
    public DicUploadFile getDicUploadFile() {
        if (dicUploadFile != null) {
            try {
                dicUploadFile.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 DicUploadFile dicUploadFile 错误", e);
                return null;
            }
        }
        return dicUploadFile;
    }

    /**
     * 文件seq
     */
    @Setter
    @Getter
    public Integer seq;
}
