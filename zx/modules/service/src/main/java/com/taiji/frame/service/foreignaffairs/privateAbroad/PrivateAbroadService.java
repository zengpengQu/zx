package com.taiji.frame.service.foreignaffairs.privateAbroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.privateAbroad.PrivateAbroad;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 因私出国(境)
 * Created by yuLei on 2018/7/30.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class PrivateAbroadService extends BaseDAO<PrivateAbroad> {

    /**
     * 分页查询列表
     */
    public void load(Carrier<PrivateAbroad> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from PrivateAbroad t where 1 = 1");
        if (map.containsKey("groupName")) {
            hql.append(" and t.groupName like :groupName");
        }

        if (map.containsKey("startTime")) {
            hql.append(" and t.startTime >= to_date(:startTime, 'YYYY-MM-DD')");
        }

        if (map.containsKey("endTime")) {
            hql.append(" and t.endTime <= to_date(:endTime, 'YYYY-MM-DD')");
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");

        find(carrier, hql.toString(), map);
    }

    public List<PrivateAbroad> findPeivateAbroadForExcel(String groupName, String startTime, String endTime) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer();
        hql.append(" from PrivateAbroad t where 1 = 1");
        if (StringUtils.isNotEmpty(groupName)) {
            hql.append(" and t.groupName like :groupName");
            params.put("groupName", "%" + groupName.trim() + "%");
        }
        if (StringUtils.isNotEmpty(startTime) && StringUtils.isNotEmpty(endTime)) {
            hql.append(" and t.startTime between to_date(:startTime, 'YYYY-MM-DD') and to_date(:endTime, 'YYYY-MM-DD')");
            hql.append(" and t.endTime between to_date(:startTime, 'YYYY-MM-DD') and to_date(:endTime, 'YYYY-MM-DD')");
            params.put("startTime", startTime);
            params.put("endTime", endTime);
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");
        List<PrivateAbroad> privateAbroadList = find(hql.toString(), params);
        return privateAbroadList;
    }


    public List<PrivateAbroad> findAll() {
        return find("from PrivateAbroad t where 1 = 1 and t.delFlag = '0' order by t.dicUser.id desc ");
    }


}
