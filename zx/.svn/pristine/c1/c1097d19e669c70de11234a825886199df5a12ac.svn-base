package com.taiji.frame.service.foreignaffairs.nationCondition;

import com.taiji.frame.model.entity.foreignaffairs.nationCondition.ParliamentIntro;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 重要议会简介
 * Created by yuLei on 2018/8/13.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ParliamentIntroService extends BaseDAO<ParliamentIntro> {

    public List<ParliamentIntro> findParliamentIntroListByNationId(String nationId) {
        StringBuffer hql = new StringBuffer();
        Map<String, Object> params = new HashMap();
        hql.append(" from ParliamentIntro t where 1 = 1");
        if (StringUtils.isNotEmpty(nationId)) {
            hql.append(" and t.nationConditionManagement.id = :nationId");
            params.put("nationId", nationId);
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc");
        List<ParliamentIntro> parliamentIntroList = find(hql.toString(), params);
        return parliamentIntroList;
    }

}
