package com.taiji.frame.service.foreignaffairs.archivesData;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.archivesData.DocumentArchive;
import com.taiji.frame.model.vo.foreignaffairs.archivesData.DocumentArchiveVo;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 案卷管理
 * Created by yuLei on 2018/8/6.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DocumentArchiveService extends BaseDAO<DocumentArchive> {

    /**
     * 分页查询列表
     */
    public void load(Carrier<DocumentArchive> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from DocumentArchive t where 1 = 1");
        if (map.containsKey("teamId")) {
            if (null != map.get("teamId")) {
                hql.append(" and t.documentTeam.id in (:teamId)");
            } else {//当前节点没有案卷资料信息
                hql.append(" and t.documentTeam.id = null");
            }
        }
        if (map.containsKey("fondsNumber")) {
            hql.append(" and t.fondsNumber = :fondsNumber");
        }
        if (map.containsKey("fileNumber")) {
            hql.append(" and t.fileNumber = :fileNumber");
        }
        if (map.containsKey("archiveNumber")) {
            hql.append(" and t.archiveNumber = :archiveNumber");
        }
        if (map.containsKey("catalogNumber")) {
            hql.append(" and t.catalogNumber = :catalogNumber");
        }
        if (map.containsKey("secretLevel")) {
            hql.append(" and t.secretLevel = :secretLevel");
        }
        if (map.containsKey("fileName")) {
            hql.append(" and t.fileName like :fileName");
        }
        if (map.containsKey("retentionPeriod")) {
            hql.append(" and t.retentionPeriod = :retentionPeriod");
        }
        if (map.containsKey("startTime") && map.containsKey("endTime")) {
            hql.append(" and t.compileDate between to_date(:startTime, 'YYYY-MM-DD') and to_date(:endTime, 'YYYY-MM-DD')");
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");

        find(carrier, hql.toString(), map);
    }

    public Boolean findDocumentArchiveByTeamId(String teamId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from DocumentArchive t where 1 = 1 and t.delFlag = '0' ");
        hql.append(" and t.documentTeam.id = :teamId");
        params.put("teamId", teamId);
        List<DocumentArchive> documentArchiveList = find(hql.toString(), params);
        if (null != documentArchiveList && documentArchiveList.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public List<String> findIdsByTeamIds(List<String> teamIds, DocumentArchiveVo documentArchiveVo) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from DocumentArchive t where 1 = 1 and t.delFlag = '0' ");
        if (null != teamIds && teamIds.size() > 0) {
            hql.append(" and t.documentTeam.id in (:teamIds)");
            params.put("teamIds", teamIds);
        }
        if (null != documentArchiveVo) {
            if (StringUtils.isNotEmpty(documentArchiveVo.getFondsNumber())) {
                hql.append(" and t.fondsNumber = :fondsNumber");
                params.put("fondsNumber", documentArchiveVo.getFondsNumber());
            }
            if (StringUtils.isNotEmpty(documentArchiveVo.getFileNumber())) {
                hql.append(" and t.fileNumber = :fileNumber");
                params.put("fileNumber", documentArchiveVo.getFileNumber());
            }
            if (StringUtils.isNotEmpty(documentArchiveVo.getArchiveNumber())) {
                hql.append(" and t.archiveNumber = :archiveNumber");
                params.put("archiveNumber", documentArchiveVo.getArchiveNumber());
            }
            if (StringUtils.isNotEmpty(documentArchiveVo.getCatalogNumber())) {
                hql.append(" and t.catalogNumber = :catalogNumber");
                params.put("catalogNumber", documentArchiveVo.getCatalogNumber());
            }
            if (StringUtils.isNotEmpty(documentArchiveVo.getSecretLevel())) {
                hql.append(" and t.secretLevel = :secretLevel");
                params.put("secretLevel", documentArchiveVo.getSecretLevel());
            }
            if (StringUtils.isNotEmpty(documentArchiveVo.getFileName())) {
                hql.append(" and t.fileName like :fileName");
                params.put("fileName", "%" + documentArchiveVo.getFileName() + "%");
            }
            if (StringUtils.isNotEmpty(documentArchiveVo.getRetentionPeriod())) {
                hql.append(" and t.retentionPeriod = :retentionPeriod");
                params.put("retentionPeriod", documentArchiveVo.getRetentionPeriod());
            }
            if (StringUtils.isNotEmpty(documentArchiveVo.getStartTime()) && StringUtils.isNotEmpty(documentArchiveVo.getEndTime())) {
                hql.append(" and t.compileDate between to_date(:startTime, 'YYYY-MM-DD') and to_date(:endTime, 'YYYY-MM-DD')");
                params.put("startTime", documentArchiveVo.getStartTime());
                params.put("endTime", documentArchiveVo.getEndTime());
            }
        }
        List<DocumentArchive> documentArchiveList = find(hql.toString(), params);
        List<String> ids = new ArrayList<>();
        if (null != documentArchiveList && documentArchiveList.size() > 0) {
            for (DocumentArchive documentArchive : documentArchiveList) {
                ids.add(documentArchive.getId());
            }
        }
        return ids;
    }

}
