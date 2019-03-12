package com.taiji.frame.service.foreignaffairs.come;

import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeReception;
import com.taiji.frame.model.entity.foreignaffairs.come.ReceptionFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeReceptionVo;
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

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 来访接待计划
 *
 * @author yx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ComeReceptionService extends BaseDAO<ComeReception> {

    private static final Logger LOG = LoggerFactory.getLogger(ComeReceptionService.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private ComeInfoService comeInfoService;

    @Autowired
    private ReceptionFileService receptionFileService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 保存来访接待计划
     * @param comeReceptionVo
     */
    @Transactional(rollbackFor = Exception.class)
    public ComeReception saveReception(ComeReceptionVo comeReceptionVo,SysLogVo sysLogVo) throws InvocationTargetException, IllegalAccessException {
        ComeReception comeReception;

        if (StringUtils.isEmpty(comeReceptionVo.getId())) {
            comeReception = new ComeReception();
        } else {
            comeReception = this.get(comeReceptionVo.getId());
        }

        new BeanCopyUtil().copyNotNullProperties(comeReceptionVo, comeReception, true);

        String comeInfoId = comeReceptionVo.getComeInfoId();
        ComeInfo comeInfo = comeInfoService.get(comeInfoId);
        comeReception.setComeInfo(comeInfo);


        Date startDate = DateUtil.stringToDate(comeReceptionVo.getStartDateStr(), DateUtil.FORMAT_DAY);
        comeReception.setStartDate(startDate);

        Date endDate = DateUtil.stringToDate(comeReceptionVo.getEndDateStr(), DateUtil.FORMAT_DAY);
        comeReception.setEndDate(endDate);

        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN);
        comeReception.setUpdateTime(updateTime);
        // 设置删除标志，未删除
        comeReception.setDelFlag("0");

        try {
            this.save(comeReception);
            sysLogVo.setTypeName("来访接待计划");
            if(org.apache.commons.lang.StringUtils.isEmpty(comeReceptionVo.getId())){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(comeReception.getReceptionTitle());
            sysLogVo.setEntityId(comeReception.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.error("保存来访接待计划失败" + e.getMessage(), e);
        }

        return comeReception;
    }

    /**
     * 保存接待计划附件信息
     * @param comeReception
     * @param uploadFile
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveReceptionFile(ComeReception comeReception, DicUploadFile uploadFile) {

        Assert.notNull(comeReception, "comeReception must not be null");
        Assert.notNull(uploadFile, "uploadFile must not be null");

        ReceptionFile receptionFile = new ReceptionFile();

        receptionFile.setComeReception(comeReception);
        receptionFile.setDicUploadFile(uploadFile);
        receptionFile.setSeq(0);

        try {
            receptionFileService.save(receptionFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 根据来访信息ID查找接待计划
     */
    public List<ComeReception> findReception(String comeInfoId) {

        Map<String, Object> map = new HashMap<>(1);

        StringBuffer hql = new StringBuffer();
        hql.append(" from ComeReception c where 1=1 and c.delFlag = '0'");
        if (StringUtils.isNotEmpty(comeInfoId)) {
            hql.append(" and c.comeInfo.id = :comeInfoId");
            map.put("comeInfoId", comeInfoId);
        }
        hql.append(" order by c.updateTime asc");

        List<ComeReception> receptionList = find(hql.toString(), map);

        return receptionList;
    }

    /**
     * 分页查询列表
     */
    public void load(Carrier<ComeReception> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from ComeReception t where 1 = 1");

        if (map.containsKey("comeInfoId")) {
            hql.append(" and t.comeInfo.id = :comeInfoId");
        }

        hql.append(" and t.delFlag = '0'");

        findNoPg(carrier, hql.toString(), map);
    }
}
