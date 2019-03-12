package com.taiji.frame.service.systempara;

import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.util.BaseDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author yx
 * 2018/6/28
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DicParamService extends BaseDAO<DicParam>{

    private static final Logger LOG = LoggerFactory.getLogger(DicParamService.class);

    public List<DicParam> getParamByGroupId(Integer groupId) {
        StringBuffer hql = new StringBuffer(" from DicParam d where d.groupId = :groupId");
        Map<String, Object> params = new HashMap<>(16);
        params.put("groupId", groupId);
        List<DicParam> paramList = find(hql.toString(), params);

        return paramList;
    }
}
