package com.taiji.frame.service.pubinfo.schedule;


import com.taiji.frame.common.util.BeanCopyUtil;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.schedule.WeekWork;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.pubinfo.schedule.WeekWorkVo;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.springframework.beans.BeanUtils;
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
 * 一周工作安排
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class WeekWorkService extends BaseDAO<WeekWork> {

    @Autowired
    private UtilService utilService;


    /**
     * 分页查询工作安排列表,默认只加载当天的工作安排
     */
    public void load(Carrier<WeekWork> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from WeekWork w where 1 = 1");
        if (map.containsKey("startDate")) {
            hql.append(" and to_char(w.createTime,'yyyy-MM-dd') >= :startDate");
        }
        if(map.containsKey("endDate")){
            hql.append(" and to_char(w.createTime,'yyyy-MM-dd') <= :endDate");
        }
        if (map.containsKey("statusList")) {
            hql.append(" and w.status in (:statusList)");
        }
        //孙毅添加
        if (map.containsKey("weekWorkIndexMain")) {
            hql.append(" and w.id = :weekWorkIndexMain)");
        }

        hql.append(" and w.delFlag = '0'");

        find(carrier, hql.toString(), map);
    }


    /**
     * 孙毅添加
     * indexIsCharge: 1：只显示已下发的，已反馈的；
     *                0：判断权限
     */
    public List<WeekWork> loadIndexMain(int indexIsCharge,DicUser dicUser,String wekWorks) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from WeekWork w where 1 = 1");
        if(indexIsCharge ==1) {
                hql.append(" and w.status = '1'");
        }else {
            if("51_13".equals(wekWorks)){
                //值班员新增，缺少创建人信息，无法确认是谁添加
                hql.append(" and w.status = '0' ");
            }else {
                //普通用户
                hql.append(" and w.status = '1' and w.dicDept.id = '"+dicUser.getDicDept().getId()+"'");

            }
        }
        hql.append(" and w.delFlag = '0'");
        hql.append(" order by sendDate desc");
        return find(hql.toString());
    }


    public List<HashMap<String,String>>  loadIndexMainDate(List<WeekWork> weekWorks) {
        List<HashMap<String,String>> list1 = new ArrayList<>();
        for (WeekWork w:weekWorks) {
            if("1".equals(w.getStatus())) {
                String date = DateUtil.dateToString(w.getCreateTime(), DateUtil.FORMAT);
                HashMap<String,String> str = new HashMap<>(3);
                str.put("dateId",w.getId());
                str.put("dateTime",date);
                str.put("count",w.getCreateName()+" 于 "+date+" 发起一周工作情况");
                list1.add(str);
            }

        }
        return list1;
    }

















    /**
     * 新增/编辑保存
     * */
    @Transactional(rollbackFor = Exception.class)
    public WeekWork editSave(WeekWorkVo weekWorkVo) {

        Assert.notNull(weekWorkVo, "weekWorkVo must not be null!");

        Date sysDate = DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT);
        Date startDate = DateUtil.stringToDate(weekWorkVo.getStartDateStr(),DateUtil.FORMAT_DAY);
        Date endDate = DateUtil.stringToDate(weekWorkVo.getEndDateStr(),DateUtil.FORMAT_DAY);

        WeekWork weekWork = new WeekWork();
        BeanUtils.copyProperties(weekWorkVo,weekWork);

        weekWork.setStartDate(startDate);
        weekWork.setEndDate(endDate);
        weekWork.setUpdateTime(sysDate);

        if (weekWorkVo.getId() == null) {
            weekWork.setCreateTime(sysDate);
            weekWork.setDelFlag("0");
        }

        if (!StringUtils.isEmpty(weekWorkVo.getSendDateStr())) {
            Date sendDate = DateUtil.stringToDate(weekWorkVo.getSendDateStr(),DateUtil.FORMAT);
            weekWork.setSendDate(sendDate);

        }

        if (StringUtils.isEmpty(weekWorkVo.getStatus())) {
            weekWork.setStatus("0");
        }

        try {
            save(weekWork);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return weekWork;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void save(WeekWork weekWork) {

        Assert.notNull(weekWork, "weekWork must not be null!");

        if (weekWork.getId() == null) {
            super.save(weekWork);
        } else {
            WeekWork temp = this.get(weekWork.getId());
            try {
                new BeanCopyUtil().copyNotNullProperties(weekWork,temp,true);
                super.save(temp);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }
    }
//
//
//    /**
//     * 根据 ORG_ID 查询部门工作安排列表
//     */
//    public List<WeekWork> getDutyDailyByOrgId(String deptId) {
//        StringBuffer hql = new StringBuffer(" from WeekWork w where w.dicDept.id = :deptId and w.delFlag=0");
//        Map<String, Object> params = new HashMap<>(1);
//        params.put("deptId", deptId);
//        List<WeekWork> weekWorkList = find(hql.toString(), params);
//        return weekWorkList;
//    }
}

