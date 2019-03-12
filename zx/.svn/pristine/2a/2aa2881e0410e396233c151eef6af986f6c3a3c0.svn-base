package com.taiji.frame.service.foreignaffairs.file;

import com.taiji.frame.model.entity.foreignaffairs.file.FileManageFile;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 文件管理关联服务
 * @author qzp
 * @date 2018/07/28
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class FileManageFileService extends BaseDAO<FileManageFile> {

    @Transactional(rollbackFor = Exception.class)
    public FileManageFile getFileManageFile(String fileId){
        HashMap<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from FileManageFile ff where 1 = 1");
        if (!StringUtils.isEmpty(fileId)){
            hql.append(" and ff.dicUploadFile.id = :fileId");
            params.put("fileId",fileId);
        }
        FileManageFile fileManageFile = findUnique(hql.toString(),params);
        return fileManageFile;
    }

    public List<FileManageFile> findByFileId(String fileId) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from FileManageFile r where 1=1");

        Map<String, Object> map = new HashMap<>(1);
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and r.fileManage.id = :fileId");
            map.put("fileId", fileId);
        }

        List<FileManageFile> fileManageFiles = createQueryList(hql.toString(), map);

        return fileManageFiles;
    }
}
