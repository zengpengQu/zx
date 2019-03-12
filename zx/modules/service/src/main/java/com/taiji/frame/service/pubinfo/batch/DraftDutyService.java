package com.taiji.frame.service.pubinfo.batch;

import com.taiji.frame.model.entity.pubinfo.batch.DicDuty;
import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
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
 * @author wsh
 * @date 2018/9/18
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true,rollbackFor = Exception.class)
public class DraftDutyService extends BaseDAO<DicDuty>{
    private static final Logger log = LoggerFactory.getLogger(DraftDutyService.class);

    public List<DicDuty> getAllDuty(){
        StringBuffer hql = new StringBuffer(" from DicDuty w where 1=1");
        hql.append(" and w.delFlag = '0'");
        List<DicDuty> dutyList = find(hql.toString());
        return  dutyList;
    }
}
