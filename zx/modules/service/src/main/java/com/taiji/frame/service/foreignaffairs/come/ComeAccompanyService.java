package com.taiji.frame.service.foreignaffairs.come;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeAccompany;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeAccompanyVo;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 来访同人员Service
 *
 * @author yx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ComeAccompanyService extends BaseDAO<ComeAccompany> {

    private static final Logger LOG = LoggerFactory.getLogger(ComeAccompanyService.class);

    /**
     * 根据 comeInfoId 查找陪同人员
     */
    public List<ComeAccompanyVo> findAccompanyByComeInfoId(String comeInfoId) {

        Map<String, Object> params = new HashMap<>(1);

        StringBuilder hql = new StringBuilder();
        hql.append(" from ComeAccompany c where 1=1 and c.delFlag='0'");

        if (StringUtils.isNotEmpty(comeInfoId)) {
            hql.append(" and c.comeInfo.id = :comeInfoId order by c.dicParam.id asc, c.seq asc");
            params.put("comeInfoId", comeInfoId);
        }

        List<ComeAccompanyVo> accompanyList = createQueryList(hql.toString(), params);

        return accompanyList;
    }

    /**
     * 分页查询列表
     */
    public void load(Carrier<ComeAccompany> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from ComeAccompany t where 1 = 1");

        if (map.containsKey("comeInfoId")) {
            hql.append(" and t.comeInfo.id = :comeInfoId");
        }

        hql.append(" and t.delFlag = '0' order by t.dicParam.id asc, t.seq asc");

        findNoPg(carrier, hql.toString(), map);
    }

}
