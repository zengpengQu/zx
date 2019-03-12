package com.taiji.frame.service.foreignaffairs.come;

import com.taiji.frame.model.entity.foreignaffairs.come.ReceptionFile;
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
 * 接待计划附件服务
 *
 * @author yx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ReceptionFileService extends BaseDAO<ReceptionFile>{

    private static final Logger LOG = LoggerFactory.getLogger(ReceptionFileService.class);

    public List<ReceptionFile> findByReceptionId(String receptionId) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from ReceptionFile r where 1=1");

        Map<String, Object> map = new HashMap<>(1);
        if (StringUtils.isNotEmpty(receptionId)) {
            hql.append(" and r.comeReception.id = :receptionId");
            map.put("receptionId", receptionId);
        }

        List<ReceptionFile> receptionFiles = createQueryList(hql.toString(), map);

        return receptionFiles;
    }

}
