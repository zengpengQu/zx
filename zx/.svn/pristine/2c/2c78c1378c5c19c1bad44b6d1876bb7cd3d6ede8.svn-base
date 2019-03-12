package com.taiji.frame.service.pubinfo.schedule;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkGuide;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkStudy;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkStudyVo;
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
 * 下周局级领导离京和脱产学习情况service
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class WorkStudyService extends BaseDAO<WorkStudy> {


    /**
     * 根据feedbackId查找下周局级领导离京和脱产学习情况
     */
    public List<WorkStudyVo> findWorkStudyByFeedbackId(String feedbackId) {

        Map<String, Object> map = new HashMap<>(1);
        StringBuilder hql = new StringBuilder();
        hql.append(" from WorkStudy w where 1=1 and w.delFlag = 0");

        if (!StringUtils.isEmpty(feedbackId)) {
            hql.append(" and w.workFeedback.id = :feedbackId");
            map.put("feedbackId", feedbackId);
        }
        return createQueryList(hql.toString(),map);
    }

    /**
     * 根据feedbackId查找下周局级领导离京和脱产学习情况
     * */
    public List<WorkStudy> findWordStudyList(String feedbackId) {

        Map<String, Object> map = new HashMap<>(1);
        StringBuilder sql = new StringBuilder();

        sql.append("select * from SCH_DUTY.PU_SCH_WORK_STUDY w where 1=1 and w.DEL_FLAG=0");

        if (null != feedbackId && !"".equals(feedbackId)) {
            sql.append(" and w.FEEDBACK_ID = :feedbackId");
            map.put("feedbackId",feedbackId);
        }
        return createQuerySqlListVo(sql.toString(),map,WorkStudy.class);
    }

    /**
     * 保存下周局级领导离京和脱产学习情况
     * */
    @Transactional
    public WorkStudy saveWorkStudy(WorkStudyVo workStudyVo) {

        WorkStudy workStudy = new WorkStudy();
        BeanUtils.copyProperties(workStudyVo,workStudy);
        Date startDate = DateUtil.stringToDate(workStudyVo.getStartDateStr(),DateUtil.FORMAT_DAY);
        Date endDate = DateUtil.stringToDate(workStudyVo.getEndDateStr(),DateUtil.FORMAT_DAY);
        workStudy.setStartDate(startDate);
        workStudy.setEndDate(endDate);
        workStudy.setDelFlag("0");
        super.save(workStudy);
        return workStudy;
    }


    public List<WorkStudy> getByFeedbackId(String feedbackId) {
        StringBuffer hql = new StringBuffer(" from WorkStudy w where 1=1 and w.delFlag = 0");
        Map<String,Object> map = new HashMap<>(1);
        if (!StringUtils.isEmpty(feedbackId)) {
            hql.append(" and w.workFeedback.id = :feedbackId");
            map.put("feedbackId",feedbackId);
        }
        List<WorkStudy> list = find(hql.toString(),map);
        return list;
    }
}
