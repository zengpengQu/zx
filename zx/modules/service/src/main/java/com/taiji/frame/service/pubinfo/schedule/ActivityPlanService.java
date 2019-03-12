package com.taiji.frame.service.pubinfo.schedule;

import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.schedule.ActivityPlan;
import com.taiji.frame.model.entity.pubinfo.schedule.PlanReceipt;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import java.lang.reflect.InvocationTargetException;
import java.util.*;

/**
 * @author admin
 * 领导活动安排service
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ActivityPlanService extends BaseDAO<ActivityPlan> {

    @Autowired
    private UtilService utilService;

    /**
     * 分页查询领导活动安排信息
     */
    public void load(Carrier<ActivityPlan> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from ActivityPlan a where 1 = 1");
        if (map.containsKey("startDate")) {
            hql.append(" and to_char(a.createTime,'yyyy-MM-dd') >= :startDate");
        }
        if (map.containsKey("endDate")) {
            hql.append(" and to_char(a.createTime,'yyyy-MM-dd') <= :endDate");
        }
        if (map.containsKey("statusList")) {
            hql.append(" and a.status in (:statusList)");
        }
        //孙毅添加(主页单条查询)
        if (map.containsKey("activityPlanIndexMain")) {
            hql.append(" and a.id = :activityPlanIndexMain");
        }
        hql.append(" and a.delFlag = '0'");

        find(carrier, hql.toString(), map);
    }


    /**
     * 孙毅添加（主页数据查询 ）(值班员 发布员 暂未设权限)
     * indexIsCharge 1:展示已下发需要开会内容
     *               0:待办事项
     */
    public List<ActivityPlan> loadIndexMain(int indexIsCharge,DicUser dicUser,String activitys) {
        //反馈权限
        StringBuffer hql = new StringBuffer();
        hql.append(" from ActivityPlan a where 1 = 1");
        if(indexIsCharge==1) {
                hql.append(" and a.status != '0' ");
        }else {
            if("53_14".equals(activitys)){
                //值班员权限，发起工作情况
                hql.append(" and a.status = '0' and a.dicUser.id = '"+dicUser.getId()+"'");
            }else {
                //普通用户，显示已下发，待反馈状态
                hql.append(" and a.status = '1' ");
            }
        }
        hql.append(" and a.delFlag = '0'");
        hql.append(" order by a.sendTime desc");
        return find(hql.toString());
    }


    public List<HashMap<String,String>>  loadIndexMainDate(List<ActivityPlan> list, List<PlanReceipt> planReceipts) {
        List<HashMap<String,String>> list1 = new ArrayList<>();
        for (ActivityPlan a:list) {
            String date = DateUtil.dateToString(a.getSendTime(), DateUtil.FORMAT);
            if("1".equals(a.getStatus())){
                HashMap<String,String> str = new HashMap<>(3);
                str.put("count",a.getDicUser().getEmpName()+" 于 "+date+" 下发领导活动安排");
                str.put("dateId",a.getId());
                str.put("dateTime",date);
                list1.add(str);
            }
        }

        for(PlanReceipt p:planReceipts){
            String date = DateUtil.dateToString(p.getFeedbackTime(), DateUtil.FORMAT);
            if("1".equals(p.getStatus())) {
                HashMap<String, String> str = new HashMap<>(3);
                str.put("dateId", p.getId());
                str.put("dateTime", date);
                str.put("count", p.getDicUser().getEmpName() + " 于 " + date + " 对领导活动安排进行反馈");
                list1.add(str);
            }
        }

        return list1;
    }

    /**
     * 新增/编辑保存
     */
    @Transactional(rollbackFor = Exception.class)
    public ActivityPlan editSave(ActivityPlan activityPlan, DicUser dicUser) throws InvocationTargetException, IllegalAccessException {

        Assert.notNull(activityPlan, "activityPlan must not be null!");
        Date sysDate = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT);

        if (null == activityPlan.getId()) {

            if ("1".equals(activityPlan.getStatus())) {
                activityPlan.setSendTime(sysDate);
            }

            activityPlan.setCreateTime(sysDate);
            activityPlan.setUpdateTime(sysDate);
            activityPlan.setDicUser(dicUser);
            activityPlan.setTel(dicUser.getPhone());

            super.save(activityPlan);

        } else {

            ActivityPlan temp = this.get(activityPlan.getId());
            new BeanCopyUtil().copyNotNullProperties(activityPlan, temp, true);

            super.save(temp);
        }
        return activityPlan;
    }

    /**
     * 根据部门ID和planId查找部门反馈信息
     */
    public PlanReceipt findReceiptByPlanIdAndDeptId(String planId, String deptId) {

        Map<String, Object> map = new HashMap<>(2);
        StringBuffer hql = new StringBuffer();

        hql.append(" from PlanReceipt p where 1=1 and p.delFlag = 0");

        if (!StringUtils.isEmpty(planId)) {
            hql.append(" and p.activityPlan.id = :planId");
            map.put("planId", planId);
        }
        if (!StringUtils.isEmpty(deptId)) {
            hql.append(" and p.dicDept.id = :deptId");
            map.put("deptId", deptId);
        }
        PlanReceipt planReceipt = findUnique(hql.toString(), map);

        return planReceipt;

    }


}
