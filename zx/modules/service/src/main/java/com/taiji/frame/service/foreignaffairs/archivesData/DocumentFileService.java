package com.taiji.frame.service.foreignaffairs.archivesData;

import com.taiji.frame.model.entity.foreignaffairs.archivesData.DocumentFile;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * 文件管理附件关联表
 * Created by yuLei on 2018/8/9.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DocumentFileService extends BaseDAO<DocumentFile> {

    public DocumentFile findDocumentFileByFileId(String fileId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from DocumentFile t where 1 = 1 and t.fileId = :fileId");
        params.put("fileId", fileId);
        DocumentFile documentFile = findUnique(hql.toString(), params);
        return documentFile;
    }

}
