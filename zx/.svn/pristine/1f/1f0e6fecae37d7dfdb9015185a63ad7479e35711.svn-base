package com.taiji.frame.service.foreignaffairs.council;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.council.Attendance;
import com.taiji.frame.model.entity.foreignaffairs.council.Congress;
import com.taiji.frame.model.vo.foreignaffairs.council.CongressVo;
import com.taiji.frame.service.foreignaffairs.come.ComeInfoService;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author sy
 * Created by suny on 2018/7/4.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AttendanceService  extends BaseDAO<Attendance> {
    private static final Logger LOG = LoggerFactory.getLogger(ComeInfoService.class);

    /**
     * load 表格数据
     */
    public void Load(Carrier<Attendance> carrier, Map<String, Object> map){
        StringBuffer hql = new StringBuffer();
        hql.append(" from Attendance a where 1 = 1");
        if (map.containsKey("attendName")) {
            hql.append(" and a.attendName like :attendName");
        }
        if (map.containsKey("attendEnce")) {
            hql.append(" and a.attendEnce like :attendEnce");
        }
        if (map.containsKey("meetingTitle")) {
            hql.append(" and a.meetingTitle like :meetingTitle");
        }
        hql.append(" and a.delFlag = 0");
        find(carrier, hql.toString(), map);
    }

    /**
     * 根据会议名字字符串进行添加出勤情况
     * @param str
     */
    public List<Attendance> names (CongressVo congressVo, Congress congress){
        List<Attendance> list = new ArrayList<>();
        String userNames = congressVo.getUserNames();
        String[] list1 = userNames.split(",");
        if(list1!=null){
        //不是空编辑  先删除数据库
            if(StringUtils.isNotEmpty(congressVo.getId())){
                List<Attendance> attendances = find(" from Attendance where meetingId.id = '"+congressVo.getId()+"'");
                for (Attendance att:attendances) {
                    delete(att.getId());
                }
            }
            for(int i=0;i<list1.length;i++){
                Attendance attendance =new Attendance();
                attendance.setAttendName(list1[i]);
                attendance.setMeetingTitle(congressVo.getTitle());
                attendance.setDelFlag("0");
                attendance.setAttendTime(DateUtil.stringToDate(congressVo.getTimeStr(),DateUtil.FORMAT_DAY));
                attendance.setMeetingId(congress);
                list.add(attendance);
            }
        }
        return list;

    }

}
