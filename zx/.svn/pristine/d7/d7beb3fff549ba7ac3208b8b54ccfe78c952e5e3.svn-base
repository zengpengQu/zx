package com.taiji.frame.service.foreignaffairs.archivesData;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.archivesData.Document;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 文件管理
 * Created by yuLei on 2018/8/8.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DocumentService extends BaseDAO<Document> {

    /**
     * 分页查询列表
     */
    public void load(Carrier<Document> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from Document t where 1 = 1");
        if (map.containsKey("dmIds")) {
            if (null != map.get("dmIds")) {
                hql.append(" and t.documentArchive.id in (:dmIds)");
            } else {//当前节点没有文件资料信息
                hql.append(" and t.documentArchive.id = null");
            }
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");

        find(carrier, hql.toString(), map);
    }

    public List<Document> findByArchiveId(String dmId) {
        StringBuffer hql = new StringBuffer();
        Map<String, Object> map = new HashMap<>(2);

        hql.append(" from Document t where 1 = 1");

        if (StringUtils.isNotEmpty(dmId)) {
            hql.append(" and t.documentArchive.id = :dmId");
            map.put("dmId", dmId);
        }
        hql.append(" and t.delFlag = 0");

        return find(hql.toString(), map);
    }

}
