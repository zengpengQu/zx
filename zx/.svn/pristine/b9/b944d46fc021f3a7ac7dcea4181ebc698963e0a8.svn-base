package com.taiji.frame.service.foreignaffairs.nationCondition;

import com.taiji.frame.model.entity.foreignaffairs.nationCondition.VipPersonIntro;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 重要人物简介
 * Created by yuLei on 2018/8/13.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class VipPersonIntroService extends BaseDAO<VipPersonIntro> {

    public List<VipPersonIntro> findVipPersonIntroListByNationId(String nationId) {
        StringBuffer hql = new StringBuffer();
        Map<String, Object> params = new HashMap();
        hql.append(" from VipPersonIntro t where 1 = 1");
        if (StringUtils.isNotEmpty(nationId)) {
            hql.append(" and t.nationConditionManagement.id = :nationId");
            params.put("nationId", nationId);
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc");
        List<VipPersonIntro> vipPersonIntroList = find(hql.toString(), params);
        return vipPersonIntroList;
    }

}
