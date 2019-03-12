package com.taiji.frame.service.pubinfo.schedule;

import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.schedule.WeekWork;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkFeedback;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkGuide;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkStudy;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkFeedbackVo;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkGuideVo;
import com.taiji.frame.model.vo.pubinfo.schedule.WorkStudyVo;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author pengyx
 * 一周工作情况反馈service
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class WorkFeedbackService extends BaseDAO<WorkFeedback> {

    @Autowired
    private WeekWorkService weekWorkService;

    @Autowired
    private DicDeptService dicDeptService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private WorkGuideService workGuideService;

    @Autowired
    private WorkStudyService workStudyService;

    /**
     * 根据一周工作情况id和部门id查看部门反馈信息
     * */
    public WorkFeedback findFeedbackByWorkIdAndDeptId(String workId,String deptId) {

        Map<String,Object> map = new HashMap<>(2);
        StringBuffer hql = new StringBuffer();

        hql.append(" from WorkFeedback w where 1=1 and w.delFlag = 0");

        if (!StringUtils.isEmpty(workId)) {

            hql.append(" and w.weekWork.id = :workId");
            map.put("workId",workId);
        }
        if (!StringUtils.isEmpty(deptId)) {

            hql.append(" and w.dicDept.id = :deptId");
            map.put("deptId",deptId);
        }
        WorkFeedback workFeedback = findUnique(hql.toString(),map);

        return workFeedback;
    }

    /**
     * 根据以后工作情况id查看部门反馈信息
     *
     * */
    public void load(Carrier<WorkFeedback> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();

        hql.append(" from WorkFeedback w where 1 = 1");

        if (map.containsKey("workId")) {
            hql.append(" and w.weekWork.id = :workId");
        }
        if (map.containsKey("deptId")) {
            hql.append(" and w.dicDept.id = :deptId");
        }
        if (map.containsKey("statusList")) {
            hql.append(" and w.status in (:statusList)");
        }

        hql.append(" and w.delFlag = '0'");
        find(carrier, hql.toString(), map);
    }

    /**
     * 保存一周工作情况反馈
     * */
    @Transactional(rollbackFor = Exception.class)
    public WorkFeedback saveFeedback(WorkFeedbackVo workFeedbackVo) {

        WorkFeedback workFeedback = new WorkFeedback();
        BeanUtils.copyProperties(workFeedbackVo,workFeedback);

        //一周工作情况
        WeekWork weekWork = weekWorkService.get(workFeedbackVo.getWeekWork().getId());
        try {
            new BeanCopyUtil().copyNotNullProperties(workFeedback.getWeekWork(),weekWork,true);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
            return null;
        } catch (InvocationTargetException e) {
            e.printStackTrace();
            return null;
        }
        //保存一周工作情况
        weekWorkService.save(weekWork);

        workFeedback.setWeekWork(weekWork);
        //部门
        DicDept dicDept = dicDeptService.get(workFeedbackVo.getDeptId());
        workFeedback.setDicDept(dicDept);
        //上报日期
        Date feedbackDate = DateUtil.stringToDate(workFeedbackVo.getFeedbackDateStr(),DateUtil.FORMAT_DAY);
        workFeedback.setFeedbackDate(feedbackDate);
        //更新时间
        Date sysDate = DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT);
        workFeedback.setUpdateTime(sysDate);
        //删除标志
        workFeedback.setDelFlag("0");
        //状态
        String status = workFeedbackVo.getStatus();
        if (null == status || "".equals(status)) {
            workFeedback.setStatus("0");
        }
        //保存反馈信息
        save(workFeedback);
        //下周局级领导带班情况
        List<WorkGuideVo> workGuideVoList = workFeedbackVo.getWorkGuideList();

        if (workGuideVoList != null && workGuideVoList.size() > 0) {
            for (WorkGuideVo workGuideVo : workGuideVoList) {

                WorkGuide workGuide = new WorkGuide();
                BeanUtils.copyProperties(workGuideVo,workGuide);
                workGuide.setWorkFeedback(workFeedback);
                Date startDate = DateUtil.stringToDate(workGuideVo.getStartDateStr(),DateUtil.FORMAT_DAY);
                Date endDate = DateUtil.stringToDate(workGuideVo.getEndDateStr(),DateUtil.FORMAT_DAY);
                workGuide.setStartDate(startDate);
                workGuide.setEndDate(endDate);

                workGuideService.save(workGuide);
            }
        }
        //下周局级领导离京和脱产学习情况
        List<WorkStudyVo> workStudyVoList = workFeedbackVo.getWorkStudyList();

        if (workStudyVoList != null && workStudyVoList.size() > 0) {

            for (WorkStudyVo workStudyVo : workStudyVoList) {

                WorkStudy workStudy = new WorkStudy();
                BeanUtils.copyProperties(workStudyVo,workStudy);

                workStudy.setWorkFeedback(workFeedback);
                Date startDate = DateUtil.stringToDate(workStudyVo.getStartDateStr(),DateUtil.FORMAT_DAY);
                Date endDate = DateUtil.stringToDate(workStudyVo.getEndDateStr(),DateUtil.FORMAT_DAY);
                workStudy.setStartDate(startDate);
                workStudy.setEndDate(endDate);

                workStudyService.save(workStudy);
            }
        }
        return workFeedback;
    }

    public List<WorkFeedback> getByWorkId(String workId) {
        StringBuffer hql = new StringBuffer(" from WorkFeedback w where 1=1 and w.delFlag = 0");
        Map<String,Object> map = new HashMap<>(1);
        if (!StringUtils.isEmpty(workId)) {
            hql.append(" and w.weekWork.id = :workId");
            map.put("workId",workId);
        }
        List<WorkFeedback> list = find(hql.toString(),map);
        return list;
    }
}
