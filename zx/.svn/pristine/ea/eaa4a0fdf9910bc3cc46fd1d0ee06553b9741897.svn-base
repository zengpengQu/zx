package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.Chronicle;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AbroadChronicleService extends BaseDAO<Chronicle> {

    /**
     * 查询大事记列表
     */
    public void load(Carrier<Chronicle> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from Chronicle t where 1 = 1");

        if (map.containsKey("abroadInfoId")) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
        }

        hql.append(" and t.delFlag = '0' order by t.updateTime desc");

        findNoPg(carrier, hql.toString(), map);
    }



}
