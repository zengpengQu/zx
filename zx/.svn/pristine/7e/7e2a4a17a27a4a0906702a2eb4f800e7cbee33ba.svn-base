package com.taiji.frame.service.pubinfo.schedule;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkFeedback;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkGuide;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkGuideVo;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author pengyx
 * 下周局级领导带班情况service
 *
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class WorkGuideService extends BaseDAO<WorkGuide> {

    /**
     * 根据feedbackId查找下周局级领导带班情况
     * */
    public List<WorkGuideVo> findWorkGuideByFeedbackId(String feedbackId) {

        Map<String, Object> map = new HashMap<>(1);
        StringBuffer hql = new StringBuffer();
        hql.append(" from WorkGuide w where 1=1 and w.delFlag = 0");

        if (!StringUtils.isEmpty(feedbackId)) {

            hql.append(" and w.workFeedback.id = :feedbackId");
            map.put("feedbackId",feedbackId);
        }
        return createQueryList(hql.toString(),map);
    }

    /**
     * 根据feedbackId查找下周局级领导带班情况
     * */
    public List<WorkGuide> findWordGuideList(String feedbackId) {

        Map<String, Object> map = new HashMap<>(1);
        StringBuffer sql = new StringBuffer();

        sql.append("select * from SCH_DUTY.PU_SCH_WORK_GUIDE w where 1=1 and w.DEL_FLAG=0");

        if (null != feedbackId && !"".equals(feedbackId)) {
            sql.append(" and w.FEEDBACK_ID = :feedbackId");
            map.put("feedbackId",feedbackId);
        }

        return createQuerySqlListVo(sql.toString(),map,WorkGuide.class);
    }

    /**
     * 保存法定节假日局级领导带班情况
     * */
    @Transactional
    public WorkGuide saveWorkGuide(WorkGuideVo workGuideVo) {

        WorkGuide workGuide = new WorkGuide();
        BeanUtils.copyProperties(workGuideVo,workGuide);
        Date startDate = DateUtil.stringToDate(workGuideVo.getStartDateStr(),DateUtil.FORMAT_DAY);
        Date endDate = DateUtil.stringToDate(workGuideVo.getEndDateStr(),DateUtil.FORMAT_DAY);
        workGuide.setStartDate(startDate);
        workGuide.setEndDate(endDate);
        workGuide.setDelFlag("0");
        super.save(workGuide);
        return workGuide;
    }

    public List<WorkGuide> getByFeedbackId(String feedbackId) {
        StringBuffer hql = new StringBuffer(" from WorkGuide w where 1=1 and w.delFlag = 0");
        Map<String,Object> map = new HashMap<>(1);
        if (!StringUtils.isEmpty(feedbackId)) {
            hql.append(" and w.workFeedback.id = :feedbackId");
            map.put("feedbackId",feedbackId);
        }
        List<WorkGuide> list = find(hql.toString(),map);
        return list;
    }
}
