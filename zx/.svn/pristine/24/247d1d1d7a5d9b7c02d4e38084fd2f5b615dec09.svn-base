package com.taiji.frame.service.pubinfo.batch;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.util.BaseDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author wsh
 * @date 2018/9/18
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true,rollbackFor = Exception.class)
public class DicReasonService extends BaseDAO<DicReason>{
    private static final Logger log = LoggerFactory.getLogger(DicReasonService.class);

    public List<DicReason> getAllByStatus(Integer status){
        StringBuffer hql = new StringBuffer(" from DicReason d where d.status=:status");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("status", status);
        List<DicReason> deptList = find(hql.toString(),params);
        return  deptList;
    }


}