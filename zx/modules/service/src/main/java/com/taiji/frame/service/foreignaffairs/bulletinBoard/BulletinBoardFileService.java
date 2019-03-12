package com.taiji.frame.service.foreignaffairs.bulletinBoard;

import com.taiji.frame.model.entity.foreignaffairs.bulletinBoard.BulletinBoardFile;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 公告栏附件服务
 * @author qzp
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class BulletinBoardFileService extends BaseDAO<BulletinBoardFile> {

    @Transactional(rollbackFor = Exception.class)
    public BulletinBoardFile getBulletinBoardFile(String fileId){
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from BulletinBoardFile bf where 1 = 1");
        if (!StringUtils.isEmpty(fileId)){
            hql.append(" and bf.dicUploadFile.id = :fileId");
            params.put("fileId",fileId);
        }
        BulletinBoardFile bulletinBoardFile = findUnique(hql.toString(), params);
        return bulletinBoardFile;
    }

    @Transactional(rollbackFor = Exception.class)
    public Boolean findByFileId(String fileId, String id) {
        Map<String, Object> params = new HashMap<String, Object>();
        StringBuffer hql = new StringBuffer(" from BulletinBoardFile t where 1 = 1");
        if (StringUtils.isNotEmpty(id)) {
            hql.append(" and t.bulletinBoard.id = :id");
            params.put("id", id);
        }
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and t.dicUploadFile.id = :fileId");
            params.put("fileId", fileId);
        }
        List<BulletinBoardFile> list = find(hql.toString(), params);
        if (null != list && list.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public List<BulletinBoardFile> findByBulletinId(String bulletinId) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from BulletinBoardFile r where 1=1");

        Map<String, Object> map = new HashMap<>(1);
        if (StringUtils.isNotEmpty(bulletinId)) {
            hql.append(" and r.bulletinBoard.id = :bulletinId");
            map.put("bulletinId", bulletinId);
        }

        List<BulletinBoardFile> bulletinBoardFiles = createQueryList(hql.toString(), map);

        return bulletinBoardFiles;
    }
}
