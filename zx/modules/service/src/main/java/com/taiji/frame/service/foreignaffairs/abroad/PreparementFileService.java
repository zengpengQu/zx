package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.model.entity.foreignaffairs.abroad.PreparementFile;
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

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class PreparementFileService extends BaseDAO<PreparementFile> {
    private static final Logger LOG = LoggerFactory.getLogger(PreparementFileService.class);

    public List<PreparementFile> findByPreparementId(String preparementId) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from PreparementFile f where 1=1");

        Map<String, Object> map = new HashMap<>(1);
        if (StringUtils.isNotEmpty(preparementId)) {
            hql.append(" and f.abroadPreparment.id = :preparementId");
            map.put("preparementId", preparementId);
        }

        List<PreparementFile> preparementFiles = createQueryList(hql.toString(), map);

        return preparementFiles;
    }
}
