package com.taiji.frame.service.foreignaffairs.come;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeReport;
import com.taiji.frame.model.entity.foreignaffairs.come.ReportFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeReportVo;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 来访简报
 *
 * @author yx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ComeReportService extends BaseDAO<ComeReport>{
    private static final Logger LOG = LoggerFactory.getLogger(ComeReportService.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private ComeInfoService comeInfoService;

    @Autowired
    private ReportFileService reportFileService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 分页查询列表
     */
    public void load(Carrier<ComeReport> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from ComeReport t where 1 = 1");

        if (map.containsKey("comeInfoId")) {
            hql.append(" and t.comeInfo.id = :comeInfoId");
        }

        hql.append(" and t.delFlag = '0'");

        findNoPg(carrier, hql.toString(), map);
    }


    /**
     * 保存来访简报
     * @param comeReportVo
     */
    @Transactional(rollbackFor = Exception.class)
    public ComeReport saveReport(ComeReportVo comeReportVo, SysLogVo sysLogVo) {

        ComeReport comeReport;

        if (StringUtils.isEmpty(comeReportVo.getId())) {
            comeReport = new ComeReport();
        } else {
            comeReport = this.get(comeReportVo.getId());
        }

        String comeInfoId = comeReportVo.getComeInfoId();
        ComeInfo comeInfo = comeInfoService.get(comeInfoId);
        comeReport.setComeInfo(comeInfo);

        String sendOrg = comeReportVo.getSendOrg();
        comeReport.setSendOrg(sendOrg);

        Date sendDate = DateUtil.stringToDate(comeReportVo.getSendDateStr(), DateUtil.FORMAT_DAY);
        comeReport.setSendDate(sendDate);

        String title = comeReportVo.getTitle();
        comeReport.setTitle(title);

        String content = comeReportVo.getContent();
        comeReport.setContent(content);

        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN);
        comeReport.setUpdateTime(updateTime);
        // 设置删除标志，未删除
        comeReport.setDelFlag("0");

        try {
            super.save(comeReport);
            sysLogVo.setTypeName("来访简报");
            if(org.apache.commons.lang.StringUtils.isEmpty(comeReportVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(comeReport.getTitle());
            sysLogVo.setEntityId(comeReport.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error("保存来访简报失败" + e.getMessage(), e);
        }

        return comeReport;
    }

    /**
     * 保存附件信息
     * @param comeReport
     * @param uploadFile
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveReportFile(ComeReport comeReport, DicUploadFile uploadFile) {

        Assert.notNull(comeReport, "comeReport must not be null");
        Assert.notNull(uploadFile, "uploadFile must not be null");

        ReportFile reportFile = new ReportFile();

        reportFile.setComeReport(comeReport);
        reportFile.setDicUploadFile(uploadFile);
        reportFile.setSeq(0);

        try {
            reportFileService.save(reportFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据来访信息ID查找来访简报
     */
    public List<ComeReport> findReport(String comeInfoId) {
        Map<String, Object> map = new HashMap<>(1);

        StringBuffer hql = new StringBuffer();
        hql.append(" from ComeReport c where 1=1 and c.delFlag = '0'");
        if (StringUtils.isNotEmpty(comeInfoId)) {
            hql.append(" and c.comeInfo.id = :comeInfoId");
            map.put("comeInfoId", comeInfoId);
        }
        List<ComeReport> reportList = find(hql.toString(), map);

        return reportList;
    }
}
