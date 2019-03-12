package com.taiji.frame.service.pubinfo.batch;

import com.taiji.frame.model.entity.pubinfo.batch.CountersignUnit;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.vo.pubinfo.batch.CountersignUnitVo;
import com.taiji.frame.model.vo.pubinfo.batch.RegisterBatchVo;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class CountersignUnitService extends BaseDAO<CountersignUnit> {

    /**
     * 历史流转记录跟踪使用
     * @param map
     * @return
     */
    public List<CountersignUnit> CountersignSearch(Map<String,Object> map){
        StringBuffer hql = new StringBuffer();

        hql.append(" from CountersignUnit c where 1=1");
        if (map.containsKey("id")) {
            hql.append(" and c.draftBatch.id = :id");
            hql.append(" or c.draftBatchOut.id = :id");
        }
        hql.append(" order by updateTime asc");
        List<CountersignUnit> list =find(hql.toString(),map);
        return list;
    }
}
