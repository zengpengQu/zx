package com.taiji.frame.service.foreignaffairs.hkmacao;

import com.taiji.frame.model.entity.foreignaffairs.hkmacao.HkMaCaoFile;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * 港澳通行证附件服务
 * @author qzp
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class HkMaCaoFileService extends BaseDAO<HkMaCaoFile> {

    @Transactional(rollbackFor = Exception.class)
    public HkMaCaoFile getHkMacao(String id) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from HkMaCaoFile bf where 1 = 1");
        if (!StringUtils.isEmpty(id)){
            hql.append(" and bf.hkMaCao.id = :id");
            params.put("id",id);
        }
        HkMaCaoFile hkMaCaoFile = findUnique(hql.toString(), params);
        return hkMaCaoFile;
    }
}
