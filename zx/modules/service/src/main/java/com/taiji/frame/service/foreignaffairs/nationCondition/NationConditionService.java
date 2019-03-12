package com.taiji.frame.service.foreignaffairs.nationCondition;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.nationCondition.NationConditionManagement;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 国家情况管理
 * Created by yuLei on 2018/8/13.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class NationConditionService extends BaseDAO<NationConditionManagement> {

    /**
     * 分页查询国家情况管理
     */
    public void load(Carrier<NationConditionManagement> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from NationConditionManagement t where 1 = 1");
        if (map.containsKey("nationName")) {
            hql.append(" and t.dicNation.nationName like :nationName");
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");
        find(carrier, hql.toString(), map);
    }

}
