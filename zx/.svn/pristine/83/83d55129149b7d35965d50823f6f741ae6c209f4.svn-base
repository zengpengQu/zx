package com.taiji.frame.service.foreignaffairs.privateAbroad;

import com.taiji.frame.model.entity.foreignaffairs.privateAbroad.PrivatePassportFile;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 因私护照文件上传关联表service
 * Created by yuLei on 2018/8/2.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class PrivatePassportFileService extends BaseDAO<PrivatePassportFile> {

    public Boolean findByBPIdAndFileId (String BPId, String fileId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from PrivatePassportFile t where 1 = 1");
        if (StringUtils.isNotEmpty(BPId)) {
            hql.append(" and t.privatePassport.id = :BPId");
            params.put("BPId", BPId);
        }
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and t.fileId = :fileId");
            params.put("fileId", fileId);
        }
        List<PrivatePassportFile> privatePassportFileList = find(hql.toString(), params);
        if (null != privatePassportFileList && privatePassportFileList.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public PrivatePassportFile findBPId (String BPId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from PrivatePassportFile t where 1 = 1");
        if (StringUtils.isNotEmpty(BPId)) {
            hql.append(" and t.privatePassport.id  = :BPId");
            params.put("BPId", BPId);
        }
        PrivatePassportFile privatePassportFile = findUnique(hql.toString(), params);
        return privatePassportFile;
    }

}
