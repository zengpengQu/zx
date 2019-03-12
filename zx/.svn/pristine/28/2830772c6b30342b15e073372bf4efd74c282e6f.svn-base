package com.taiji.frame.service.pubinfo.schedule;

import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.schedule.PlanReceipt;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.pubinfo.schedule.PlanReceiptVo;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
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
 * @author admin
 * 领导活动安排service
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class PlanReceiptService extends BaseDAO<PlanReceipt> {

    @Autowired
    private UtilService utilService;

    /**
     * 根据一周工作情况id和部门id查看部门反馈信息
     * */
    public PlanReceipt findReceiptByPlanIdAndDeptId(String planId,String deptId) {

        Map<String,Object> map = new HashMap<>(2);
        StringBuffer hql = new StringBuffer();

        hql.append(" from PlanReceipt p where 1=1 and p.delFlag = 0");

        if (!StringUtils.isEmpty(planId)) {

            hql.append(" and p.activityPlan.id = :planId");
            map.put("planId",planId);
        }
        if (!StringUtils.isEmpty(deptId)) {

            hql.append(" and p.dicDept.id = :deptId");
            map.put("deptId",deptId);
        }
        PlanReceipt planReceipt = findUnique(hql.toString(),map);

        return planReceipt;
    }

    /**
     * 根据一周工作情况id查看部门反馈信息
     *
     * */
    public void load(Carrier<PlanReceipt> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();

        hql.append(" from PlanReceipt p where 1 = 1");

        if (map.containsKey("planId")) {
            hql.append(" and p.activityPlan.id = :planId");
        }
        if (map.containsKey("deptId")) {
            hql.append(" and p.dicDept.id = :deptId");
        }
        if (map.containsKey("statusList")) {
            hql.append(" and p.status in (:statusList)");
        }
        if (map.containsKey("feedbackTime")) {
            hql.append(" and  to_char(p.feedbackTime ,'yyyy-MM-dd HH:mm:ss') >= :feedbackTime");
        }

        hql.append(" and p.delFlag = '0'");
        find(carrier, hql.toString(), map);
    }



    /**
     * 根据一周工作情况id查看部门反馈信息
     *
     * */
    public List<PlanReceipt> loadIndexDate() {

        StringBuffer hql = new StringBuffer();

        hql.append(" from PlanReceipt p where 1 = 1");
        hql.append(" and p.status != '0' ");
        hql.append(" and p.delFlag = '0'");
        hql.append(" order by p.feedbackTime desc");
        return find( hql.toString());
    }











    /**
     * 新增/编辑保存会议回执反馈信息
     * */
    @Transactional(rollbackFor = Exception.class)
    public PlanReceipt editSave(PlanReceiptVo planReceiptVo, DicUser dicUser) throws InvocationTargetException, IllegalAccessException {

        Assert.notNull(planReceiptVo, "planReceiptVo must not be null!");
        Date sysDate = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT);

        PlanReceipt planReceipt = this.get(planReceiptVo.getId());

        Date startDate = DateUtil.stringToDate(planReceiptVo.getStartDateStr(),DateUtil.FORMAT_DAY);
        Date endDate = DateUtil.stringToDate(planReceiptVo.getEndDateStr(),DateUtil.FORMAT_DAY);
        planReceiptVo.setStartDate(startDate);
        planReceiptVo.setEndDate(endDate);
        planReceiptVo.setDicUser(dicUser);

        if (!StringUtils.isEmpty(planReceiptVo.getFeedbackTimeStr())) {

            Date feedbackTime = DateUtil.stringToDate(planReceiptVo.getFeedbackTimeStr(),DateUtil.FORMAT_DAY);
            planReceiptVo.setFeedbackTime(feedbackTime);
        }

        new BeanCopyUtil().copyNotNullProperties(planReceiptVo,planReceipt,true);
        planReceipt.setUpdateTime(sysDate);
        super.save(planReceipt);

        return planReceipt;
    }

    /**
     * 根据一周工作情况ID查找已查收的会议回执信息
     * */
    public List<PlanReceipt> findReceiptByPlanId(String planId) {

        Map<String,Object> map = new HashMap<>(1);
        StringBuffer hql = new StringBuffer();
        hql.append(" from PlanReceipt p where 1 = 1");

        if (null != planId && !"".equals(planId)) {
            hql.append(" and p.activityPlan.id = :planId");
            map.put("planId",planId);
        }
        hql.append(" and p.status = '2' and p.delFlag = '0'");



        return find(hql.toString(),map);
    }
}
