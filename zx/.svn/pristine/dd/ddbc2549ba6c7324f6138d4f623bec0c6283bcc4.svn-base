package com.taiji.frame.service.foreignaffairs.telegraph;

import com.taiji.frame.model.entity.foreignaffairs.telegraph.TelegraphManageFile;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 电报文件关联服务
 * @author qzp
 * @date 2018/07/26
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class TelegraphManageFileService extends BaseDAO<TelegraphManageFile> {
    private static final Logger log = LoggerFactory.getLogger(TelegraphManageFileService.class);

    @Transactional(rollbackFor = Exception.class)
    public TelegraphManageFile getTelegraphFile(String fileId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from TelegraphManageFile tf where 1 = 1");
        if (!StringUtils.isEmpty(fileId)){
            hql.append(" and tf.dicUploadFile.id = :fileId");
            params.put("fileId",fileId);
        }
        TelegraphManageFile telegraphManageFile = findUnique(hql.toString(),params);
        return telegraphManageFile;
    }

    public List<TelegraphManageFile> findByTelegraphId(String telegraphId) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from TelegraphManageFile r where 1=1");

        Map<String, Object> map = new HashMap<>(1);
        if (StringUtils.isNotEmpty(telegraphId)) {
            hql.append(" and r.telegraphManage.id = :telegraphId");
            map.put("telegraphId", telegraphId);
        }

        List<TelegraphManageFile> telegraphManageFiles = createQueryList(hql.toString(), map);

        return telegraphManageFiles;
    }
}
