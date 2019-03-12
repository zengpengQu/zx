package com.taiji.frame.service.foreignaffairs.tempForeignAffairs;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.TempAffairs;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.TempAffairsFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.util.BaseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Map;

/**
 * 临时外事活动
 * Created by yuLei on 2018/7/17.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class TempAffairsService extends BaseDAO<TempAffairs> {

    @Autowired
    private TempAffairsFileService tempAffairsFileService;

    /**
     * 分页查询临时外事活动列表
     */
    public void load(Carrier<TempAffairs> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from TempAffairs t where 1 = 1");
        if (map.containsKey("groupName")) {
            hql.append(" and t.groupName like :groupName");
        }
        if (map.containsKey("contacts")) {
            hql.append(" and t.contacts like :contacts");
        }
        if (map.containsKey("contactsTel")) {
            hql.append(" and t.contactsTel like :contactsTel");
        }
        if (map.containsKey("sponsor")) {
            hql.append(" and t.dicDept.id = :sponsor");
        }
        if (map.containsKey("groupLevel")) {
            hql.append(" and t.dicParam.id = :groupLevel");
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");

        find(carrier, hql.toString(), map);
    }

    @Transactional(rollbackFor = Exception.class)
    public void saveTempAffairsFile(TempAffairs tempAffairs, String fileId) {
        Assert.notNull(tempAffairs, "tempAffairs must not be null");
        Assert.notNull(fileId, "fileId must not be null");

        TempAffairsFile tempAffairsFile = new TempAffairsFile();
        tempAffairsFile.setFileId(fileId);
        tempAffairsFile.setTempAffairs(tempAffairs);
        tempAffairsFile.setSeq(0);
        try {
            tempAffairsFileService.save(tempAffairsFile);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
