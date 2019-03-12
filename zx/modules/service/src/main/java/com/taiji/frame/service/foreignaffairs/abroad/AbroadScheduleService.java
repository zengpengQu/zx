package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadSchedule;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AbroadScheduleService extends BaseDAO<AbroadSchedule> {

    /**
     * 查询列表
     */
    public void load(Carrier<AbroadSchedule> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from AbroadSchedule t where 1 = 1");

        if (map.containsKey("abroadInfoId")) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
        }

        hql.append(" and t.delFlag = '0'");

        findNoPg(carrier, hql.toString(), map);
    }

    public List<AbroadSchedule> findByInfoId(String abroadInfoId) {
        StringBuilder hql = new StringBuilder();
        Map<String, Object> map = new HashMap<>(2);

        if (StringUtils.isNotEmpty(abroadInfoId)) {
            hql.append(" from AbroadSchedule t where 1 = 1");
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
            map.put("abroadInfoId", abroadInfoId);

            hql.append(" and t.delFlag = '0' order by t.day asc");
        }

        return find(hql.toString(), map);
    }



}
