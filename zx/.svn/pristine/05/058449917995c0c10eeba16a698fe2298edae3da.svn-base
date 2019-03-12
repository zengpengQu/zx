package com.taiji.frame.service.foreignaffairs.archivesData;

import com.taiji.frame.model.entity.foreignaffairs.archivesData.DocumentTeam;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 案卷分组
 * Created by yuLei on 2018/8/6.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DocumentTeamService extends BaseDAO<DocumentTeam> {

    public List<DocumentTeam> findDocumentTeamList() {
        StringBuffer hql = new StringBuffer(" from DocumentTeam t where 1 = 1 and t.delFlag = '0'");
        hql.append(" order by t.createTime asc");
        List<DocumentTeam> documentTeamList = find(hql.toString());
        return documentTeamList;
    }

    public Boolean findDocumentTeamByParentId(String parentId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from DocumentTeam t where 1 = 1 and t.delFlag = '0' ");
        hql.append(" and t.parentId = :parentId");
        params.put("parentId", parentId);
        List<DocumentTeam> documentTeamList = find(hql.toString(), params);
        if (null != documentTeamList && documentTeamList.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public List<String> findIdsByParentId(String parentId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from DocumentTeam t where 1 = 1 and t.delFlag = '0' ");
        hql.append(" and t.parentId = :parentId");
        params.put("parentId", parentId);
        List<DocumentTeam> documentTeamList = find(hql.toString(), params);
        List<String> ids = new ArrayList<>();
        if (null != documentTeamList && documentTeamList.size() > 0) {
            for (DocumentTeam documentTeam : documentTeamList) {
                ids.add(documentTeam.getId());
            }
        }
        return ids;
    }

    public List<DocumentTeam> findDocumentTeamByNullParentId() {
        StringBuffer hql = new StringBuffer(" from DocumentTeam t where 1 = 1 and t.delFlag = '0' ");
        hql.append(" and t.parentId = null");
        hql.append(" order by t.createTime asc");
        List<DocumentTeam> documentTeamList = find(hql.toString());
        return documentTeamList;
    }

    public List<DocumentTeam> findChildNodeByParentId(String parentId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from DocumentTeam t where 1 = 1 and t.delFlag = '0' ");
        hql.append(" and t.parentId = :parentId");
        hql.append(" order by t.createTime asc");
        params.put("parentId", parentId);
        List<DocumentTeam> documentTeamList = find(hql.toString(), params);
        return documentTeamList;
    }

}
