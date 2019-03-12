package com.taiji.frame.service.foreignaffairs.come;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeGiftRecv;
import com.taiji.frame.util.BaseDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 来访礼品受赠服务
 * @author yx
 * @date 2018/8/17
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ComeGiftRecvService extends BaseDAO<ComeGiftRecv> {
    private static final Logger LOG = LoggerFactory.getLogger(ComeGiftRecvService.class);

    /**
     * 分页查询列表
     */
    public void load(Carrier<ComeGiftRecv> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from ComeGiftRecv t where 1 = 1");

        if (map.containsKey("comeInfoId")) {
            hql.append(" and t.comeInfo.id = :comeInfoId");
        }

        hql.append(" and t.delFlag = '0'");

        findNoPg(carrier, hql.toString(), map);
    }

}
