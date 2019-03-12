package com.taiji.frame.service.foreignaffairs.businessPassport;

import com.taiji.frame.model.entity.foreignaffairs.businessPassport.BusinessPassportFile;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 因公护照文件上传关联表service
 * Created by yuLei on 2018/7/27.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class BusinessPassportFileService extends BaseDAO<BusinessPassportFile> {

    public Boolean findByBPIdAndFileId (String BPId, String fileId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from BusinessPassportFile t where 1 = 1");
        if (StringUtils.isNotEmpty(BPId)) {
            hql.append(" and t.businessPassport.id = :BPId");
            params.put("BPId", BPId);
        }
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and t.fileId = :fileId");
            params.put("fileId", fileId);
        }
        List<BusinessPassportFile> businessPassportFileList = find(hql.toString(), params);
        if (null != businessPassportFileList && businessPassportFileList.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public BusinessPassportFile findBPId (String BPId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from BusinessPassportFile t where 1 = 1");
        if (StringUtils.isNotEmpty(BPId)) {
            hql.append(" and t.businessPassport.id  = :BPId");
            params.put("BPId", BPId);
        }
        BusinessPassportFile BusinessPassportFile = findUnique(hql.toString(), params);
        return BusinessPassportFile;
    }

}
