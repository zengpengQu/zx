package com.taiji.frame.service.foreignaffairs.tempForeignAffairs;

import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.TempAffairsFile;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 临时外事活动文件上传
 * Created by yuLei on 2018/7/20.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class TempAffairsFileService extends BaseDAO<TempAffairsFile> {

    public Boolean findByAffairsIdAndFileId (String affairsId, String fileId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from TempAffairsFile t where 1 = 1");
        if (StringUtils.isNotEmpty(affairsId)) {
            hql.append(" and t.tempAffairs.id = :affairsId");
            params.put("affairsId", affairsId);
        }
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and t.fileId = :fileId");
            params.put("fileId", fileId);
        }
        List<TempAffairsFile> tempAffairsFileList = find(hql.toString(), params);
        if (null != tempAffairsFileList && tempAffairsFileList.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public List<TempAffairsFile> findByAffairsId (String affairsId) {
        Map<String, Object> params = new HashMap<>(1);
        StringBuffer hql = new StringBuffer(" from TempAffairsFile t where 1 = 1");
        if (StringUtils.isNotEmpty(affairsId)) {
            hql.append(" and t.tempAffairs.id  = :affairsId");
            params.put("affairsId", affairsId);
        }
        List<TempAffairsFile> tempAffairsFileList = find(hql.toString(), params);
        return tempAffairsFileList;
    }

}
