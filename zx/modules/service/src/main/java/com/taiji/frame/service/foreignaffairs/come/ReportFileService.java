package com.taiji.frame.service.foreignaffairs.come;

import com.taiji.frame.model.entity.foreignaffairs.come.ReceptionFile;
import com.taiji.frame.model.entity.foreignaffairs.come.ReportFile;
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
 * 来访简报文件服务
 *
 * @author yx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ReportFileService extends BaseDAO<ReportFile> {
    private static final Logger LOG = LoggerFactory.getLogger(ReportFileService.class);

    public List<ReportFile> findByReportId(String reportId) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from ReportFile r where 1=1");

        Map<String, Object> map = new HashMap<>(1);
        if (StringUtils.isNotEmpty(reportId)) {
            hql.append(" and r.comeReport.id = :reportId");
            map.put("reportId", reportId);
        }

        List<ReportFile> reportFiles = createQueryList(hql.toString(), map);

        return reportFiles;
    }
}
