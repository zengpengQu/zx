package com.taiji.frame.service.pubinfo.schedule;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.schedule.DutyDaily;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author admin
 * 值班日报
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DutyDailyService extends BaseDAO<DutyDaily> {


    /**
     * 分页查询值班日报列表,默认只加载当天的日报
     */
    public void load(Carrier<DutyDaily> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from DutyDaily t where 1 = 1");
       /*  孙毅修改 添加到了else下
       if (map.containsKey("stringList")) {
            hql.append(" and t.dicDept.id in (:stringList)");
        }*/
        if (map.containsKey("sectionId")) {
            hql.append(" and t.section.id = :sectionId");
        }
        if (map.containsKey("createTime")) {
            hql.append(" and to_char(t.createTime,'yyyy-MM-dd') = :createTime");
        }
        if (map.containsKey("statusList")) {
            hql.append(" and t.status in (:statusList)");
        }
        //孙毅添加（主页单条 数据查询）
        if (map.containsKey("dutyDailyIndexMainId")) {
            hql.append(" and t.id = :dutyDailyIndexMainId");
        }else {
            if (map.containsKey("stringList")) {
                hql.append(" and t.dicDept.id in (:stringList)");
            }
        }
        hql.append(" and t.delFlag = '0'");

        find(carrier, hql.toString(), map);
    }

    /**孙毅添加 主页数据展示*/
    public List<DutyDaily> dutyListLoadIndexMain(int indexMain, DicUser dicUser,String dutyStrs) {

        HashMap map = new HashMap(16);
        StringBuffer hql = new StringBuffer();

            hql.append(" from DutyDaily t where 1 = 1");
            //1：表示工作动态的显示
            if(indexMain==1) {
                hql.append(" and t.status != '0'");
            }else {
                //待办事项的显示
                if("50_11".equals(dutyStrs)){
                    hql.append(" and t.status = '1'");
                }else {
                    map.put("userId",dicUser.getId());
                    hql.append(" and t.status = '0' and t.dicUser.id = '"+dicUser.getId()+"'");
                }
            }
            hql.append(" and t.delFlag = '0'");
            hql.append(" order by updateTime desc");

            return find(hql.toString(),map);

    }


    /**首页工作动态，数据组装*/
    public List<HashMap<String,String>> loadIndexMainDate(List<DutyDaily> list) {
        List<HashMap<String,String>> list1 = new ArrayList<>();
        for (DutyDaily d:list) {
            String date = DateUtil.dateToString(d.getUpdateTime(), DateUtil.FORMAT);
            HashMap<String,String> str = new HashMap<>(3);
            if("1".equals(d.getStatus())){
                str.put("dateId",d.getId());
                str.put("dateTime",date);
                str.put("count",d.getDicUser().getEmpName()+" 于 "+date+"上报值班日报信息 ");
                list1.add(str);
            }else if("2".equals(d.getStatus())){
                str.put("dateId",d.getId());
                str.put("dateTime",date);
                str.put("count",d.getDicUser().getEmpName()+" 于 "+date+"查收值班日报信息 ");
                list1.add(str);
            }
        }

        return list1;
    }






















    /**
     * 根据 ORG_ID 查询值班日报列表
     */
    public List<DutyDaily> getDutyDailyByOrgAndDate(String deptId, String date) {
        Map<String, Object> params = new HashMap<>(1);

        StringBuffer hql = new StringBuffer(" from DutyDaily d where d.dicDept.id = :deptId");
        hql.append(" and to_char(d.createTime, 'YYYY-MM-DD') = :date and d.delFlag = 0");

        params.put("deptId", deptId);
        params.put("date", date);

        List<DutyDaily> dutyDailyList = find(hql.toString(), params);
        return dutyDailyList;
    }

    /**
     * 根据日期查询当天所有值班日报
     */
    public List<DutyDaily> findDutyDailyByCreateTime(String createTime) {

        Map<String, Object> map = new HashMap<>(1);
        StringBuffer hql = new StringBuffer();
        hql.append(" from DutyDaily d where to_char(d.createTime,'yyyy-MM-dd') = :createTime and d.delFlag = 0");
        map.put("createTime", createTime);
        List<DutyDaily> dutyDailyList = find(hql.toString(), map);

        return dutyDailyList;
    }

    /**
     * 根据部门ID,板块ID,日期查询当天所有值班日报
     */
    public List<DutyDaily> findDutyDailyByParams(String deptId, String sectionId, String createTime, String status) {

        Map<String, Object> map = new HashMap<>(3);
        StringBuffer hql = new StringBuffer();
        hql.append(" from DutyDaily d where 1=1 and d.delFlag = '0'");

        if (null != deptId && !"".equals(deptId)) {
            hql.append(" and d.dicDept.id = :deptId");
            map.put("deptId", deptId);
        }

        if (null != sectionId && !"".equals(sectionId)) {
            hql.append(" and d.section.id = :sectionId");
            map.put("sectionId", sectionId);
        }

        if (null != createTime && !"".equals(createTime)) {
            hql.append(" and to_char(d.createTime,'yyyy-MM-dd') = :createTime");
            map.put("createTime", createTime);
        }

        if (null != status && !"".equals(status)) {
            hql.append(" and d.status = :status");
            map.put("status", status);
        }

        List<DutyDaily> dutyDailyList = find(hql.toString(), map);
        return dutyDailyList;
    }
















}
