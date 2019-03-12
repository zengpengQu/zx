package com.taiji.frame.model.entity.foreignaffairs.bulletinBoard;

import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.util.IdEntity;
import com.taiji.frame.model.util.Jsonable;
import lombok.Getter;
import lombok.Setter;
import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.persistence.*;

/**
 * 公告栏管理-上传文件关联表
 * @author qzp
 * @date 2018/07/19
 */
@Entity
@Table(name = "DM_NBD_BOARD_FILE", schema = "SCH_DUTY")
public class BulletinBoardFile extends IdEntity implements Jsonable {

    private static final Logger LOG = LoggerFactory.getLogger(BulletinBoardFile.class);

    /**
     * 公告栏管理ID
     */
    @Setter
    private BulletinBoard bulletinBoard;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = BulletinBoard.class)
    @JoinColumn(name = "BOARD_ID", referencedColumnName = "ID")
    public BulletinBoard getBulletinBoard() {
        if (bulletinBoard != null) {
            try {
                bulletinBoard.getId();
            } catch (Exception e) {
                LOG.error("获取关联对象 BulletinBoard bulletinBoard 失败", e);
                return null;
            }
        }
        return bulletinBoard;
    }

    /**
     * 与实体关联的文件顺序
     */
    @Setter
    @Getter
    public Integer seq;

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



    @Override
    @Transient
    public JSON getJsonObject() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", id);
//        jsonObject.put("bulletinBoardId", getBulletinBoard() == null ? "" : getBulletinBoard().getId());
        jsonObject.put("fileId", getDicUploadFile() == null ? "" : getDicUploadFile().getId());
        jsonObject.put("seq", seq);
        return jsonObject;
    }
}
