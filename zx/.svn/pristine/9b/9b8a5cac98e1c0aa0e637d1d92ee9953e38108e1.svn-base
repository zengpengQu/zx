package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadPreparment;
import com.taiji.frame.model.entity.foreignaffairs.abroad.PreparementFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.util.BaseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AbroadPreparmentService extends BaseDAO<AbroadPreparment> {

    @Autowired
    private PreparementFileService preparementFileService;

    /**
     * 查询会议列表
     */
    public void load(Carrier<AbroadPreparment> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from AbroadPreparment t where 1 = 1");

        if (map.containsKey("abroadInfoId")) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
        }

        hql.append(" and t.delFlag = '0' order by t.updateTime desc");

        findNoPg(carrier, hql.toString(), map);
    }

    /**
     * 保存会议筹备附件信息
     * @param abroadPreparment
     * @param uploadFile
     */
    @Transactional(rollbackFor = Exception.class)
    public void savePreparementFile(AbroadPreparment abroadPreparment, DicUploadFile uploadFile) {

        Assert.notNull(abroadPreparment, "abroadPreparment must not be null");
        Assert.notNull(uploadFile, "uploadFile must not be null");

        PreparementFile preparementFile = new PreparementFile();

        preparementFile.setAbroadPreparment(abroadPreparment);
        preparementFile.setDicUploadFile(uploadFile);
        preparementFile.setSeq(0);

        try {
            preparementFileService.save(preparementFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
