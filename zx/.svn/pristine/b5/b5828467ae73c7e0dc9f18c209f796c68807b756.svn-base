package com.taiji.frame.service.foreignaffairs.taiwan;

import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanPartyFile;
import com.taiji.frame.util.BaseDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/08/09
 * 台湾社团文件服务
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class TaiWanPartyFileService extends BaseDAO<TaiWanPartyFile> {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanPartyFileService.class);

    @Transactional(rollbackFor = Exception.class)
    public TaiWanPartyFile findByFileId(String fileId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from TaiWanPartyFile t where 1 = 1 and t.fileId = :fileId");
        params.put("fileId", fileId);
        TaiWanPartyFile taiWanPartyFile = findUnique(hql.toString(),params);
        return taiWanPartyFile;
    }
}
