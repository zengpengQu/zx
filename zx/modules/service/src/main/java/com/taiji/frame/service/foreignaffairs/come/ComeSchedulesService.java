package com.taiji.frame.service.foreignaffairs.come;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeSchedule;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeScheduleListVo;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeScheduleVo;
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

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 来访日程管理服务
 *
 * @author yx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ComeSchedulesService extends BaseDAO<ComeSchedule>{

    private static final Logger LOG = LoggerFactory.getLogger(ComeSchedulesService.class);

    @Autowired
    ComeInfoService comeInfoService;

    @Autowired
    UtilService utilService;
    @Autowired
    private SysLogService sysLogService;
    /**
     * 分页查询列表
     */
    public void load(Carrier<ComeSchedule> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from ComeSchedule t where 1 = 1");

        if (map.containsKey("comeInfoId")) {
            hql.append(" and t.comeInfo.id = :comeInfoId");
        }

        hql.append(" and t.delFlag = '0'");

        findNoPg(carrier, hql.toString(), map);
    }


    public List<ComeSchedule> findSchedulesByComeInfoId(String comeInfoId) {

        Map<String, Object> params = new HashMap<>(1);

        StringBuffer hql = new StringBuffer();
        hql.append("from ComeSchedule c where 1=1 and c.delFlag='0'");

        if (StringUtils.isNotEmpty(comeInfoId)) {
            hql.append(" and c.comeInfo.id = :comeInfoId order by c.activityTime asc");
            params.put("comeInfoId", comeInfoId);
        }

        List<ComeSchedule> comeScheduleList = createQueryList(hql.toString(), params);

        return comeScheduleList;
    }

    /**
     * 保存日程信息
     * @param scheduleListVo
     * @param comeInfoId
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveSchedules(ComeScheduleListVo scheduleListVo, String comeInfoId, SysLogVo sysLogVo) {
        ComeSchedule comeSchedule;
        ComeInfo comeInfo = comeInfoService.get(comeInfoId);

        List<ComeScheduleVo> scheduleList = scheduleListVo.scheduleList;
        if (scheduleList.size() > 0) {

            for (ComeScheduleVo schedulesVo : scheduleList) {
                String id = schedulesVo.getId();
                if (StringUtils.isNotEmpty(id)) {
                    comeSchedule = this.get(id);
                } else {
                    comeSchedule = new ComeSchedule();
                }

                comeSchedule.setComeInfo(comeInfo);

                String activityDateStr = schedulesVo.getActivityDateStr();
                Date activityDate = DateUtil.stringToDate(activityDateStr, DateUtil.FORMAT_DAY);
                comeSchedule.setActivityDate(activityDate);

                String timeStr = schedulesVo.getActivityTimeStr();
                String activityTimeStr = activityDateStr + " " + timeStr;

                // 输入的时间没有秒数，则添加秒
                if (timeStr.length() < 8) {
                    activityTimeStr += ":00";
                }

                Date activityTime = DateUtil.stringToDate(activityTimeStr, DateUtil.FORMAT_DAYTIME);

                comeSchedule.setActivityTime(activityTime);
                comeSchedule.setActivity(schedulesVo.getActivity());
                comeSchedule.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN));
                comeSchedule.setDelFlag("0");

                try {
                    this.save(comeSchedule);
                    sysLogVo.setTypeName("日程信息");
                        sysLogVo.setRecordType(0);
                    sysLogVo.setEntityName(comeSchedule.getComeInfo().getGroupName());
                    sysLogVo.setEntityId(comeSchedule.getId());
                    sysLogVo.setResult("true");
                    sysLogService.record(sysLogVo);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
