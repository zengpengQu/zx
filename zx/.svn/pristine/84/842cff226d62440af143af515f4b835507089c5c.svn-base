package com.taiji.frame.service.pubinfo.supervision;

import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionFeedBackFile;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 督查反馈附件服务
 * @author qzp
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class SupervisionFeedBackFileService extends BaseDAO<SupervisionFeedBackFile> {

    @Transactional(rollbackFor = Exception.class)
    public SupervisionFeedBackFile getFeedBackFile(String feedBackId) {
        HashMap<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from SupervisionFeedBackFile sb where 1 = 1");
        if (StringUtils.isNotEmpty(feedBackId)){
            hql.append(" and sb.supervisionFeedBack.id = :feedBackId");
            params.put("feedBackId",feedBackId);
        }
        SupervisionFeedBackFile supervisionFeedBackFile = findUnique(hql.toString(), params);
        return supervisionFeedBackFile;
    }

//    @Transactional(rollbackFor = Exception.class)
//    public SupervisionFeedBackFile getSupervisionFeedBack(String feedBackId) {
//        Map<String, Object> params = new HashMap<>();
//        StringBuffer hql = new StringBuffer("from SupervisionFeedBackFile sf where 1 = 1");
//        if (StringUtils.isNotEmpty(feedBackId)){
//            hql.append(" and sf.supervisionFeedBack.id = :feedBackId");
//            params.put("feedBackId",feedBackId);
//        }
//        SupervisionFeedBackFile supervisionFeedBackFile = findUnique(hql.toString(), params);
//        return supervisionFeedBackFile;
//    }

    @Transactional(rollbackFor = Exception.class)
    public Boolean isExist(String fileId, String feedBackId) {
        Map<String, Object> params = new HashMap<String, Object>();
        StringBuffer hql = new StringBuffer(" from SupervisionFeedBackFile sb where 1 = 1");
        if (StringUtils.isNotEmpty(feedBackId)) {
            hql.append(" and sb.supervisionFeedBack.id = :feedBackId");
            params.put("feedBackId", feedBackId);
        }
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and sb.dicUploadFile.id = :fileId");
            params.put("fileId", fileId);
        }
        List<SupervisionFeedBackFile> list = find(hql.toString(),params);
        if (null != list && list.size() > 0) {
            return true;
        } else {
            return false;
        }
    }
}
