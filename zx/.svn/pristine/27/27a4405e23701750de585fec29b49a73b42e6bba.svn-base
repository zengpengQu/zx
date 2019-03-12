package com.taiji.frame.service.pubinfo.schedule;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.schedule.DutyFile;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;

/**
 * @author yx
 * 值班日报文件
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DutyFileService extends BaseDAO<DutyFile> {

    /**
     * 分页查询值班日报文件列表
     */
    public void load(Carrier<DutyFile> carrier, HashMap map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from DutyFile t where 1 = 1");
        if (map.containsKey("startTime")) {
            hql.append(" and to_char(t.dutyTime,'yyyy-MM-dd') >= :startTime");
        }
        if (map.containsKey("endTime")) {
            hql.append(" and to_char(t.dutyTime,'yyyy-MM-dd') <= :endTime ");
        }
        if (map.containsKey("dutyNum")) {
            hql.append(" and t.dutyNum = :dutyNum");
        }
        if (map.containsKey("keyword")) {
            hql.append(" and t.content like :keyword");
        }
        hql.append(" and t.delFlag = '0'");

        find(carrier, hql.toString(), map);
    }
}
