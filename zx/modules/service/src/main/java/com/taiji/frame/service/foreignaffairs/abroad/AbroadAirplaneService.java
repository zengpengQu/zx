package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadAirplane;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AbroadAirplaneService extends BaseDAO<AbroadAirplane> {

    /**
     * 查询列表
     */
    public void load(Carrier<AbroadAirplane> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from AbroadAirplane t where 1 = 1");

        if (map.containsKey("abroadInfoId")) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
        }

        hql.append(" and t.delFlag = '0' order by t.updateTime desc");

        findNoPg(carrier, hql.toString(), map);
    }


}
