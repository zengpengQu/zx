package com.taiji.frame.service.foreignaffairs.taiwanCard;

import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanCardFile;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *赴台通行证文件关联服务
 * @author qzp
 * @date 2018/07/26
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class TaiWanCardFileService extends BaseDAO<TaiWanCardFile> {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanCardFileService.class);

    @Transactional(rollbackFor = Exception.class)
    public Boolean findByFileIdAndCardId(String fileId, String taiwanCardId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from TaiWanCardFile t where 1 = 1");
        if (StringUtils.isNotEmpty(taiwanCardId)) {
            hql.append(" and t.taiWanCard.id = :taiwanCardId");
            params.put("taiwanCardId", taiwanCardId);
        }
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and t.fileId = :fileId");
            params.put("fileId", fileId);
        }
        List<TaiWanCardFile> list = find(hql.toString(), params);
        if (null != list && list.size() > 0){
            return true;
        }else {
            return false;
        }
    }

//    @Transactional(rollbackFor = Exception.class)
    public TaiWanCardFile findByCardId(String taiwanCardId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from TaiWanCardFile t where 1 = 1");
        if (StringUtils.isNotEmpty(taiwanCardId)) {
            hql.append(" and t.taiWanCard.id  = :taiwanCardId");
            params.put("taiwanCardId", taiwanCardId);
        }
        TaiWanCardFile taiWanCardFile = findUnique(hql.toString(), params);
        return taiWanCardFile;
    }
}
