package com.taiji.frame.service.inspection.census;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.inspection.place.Place;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;


/**
 * @author sy
 * 活动安排管理
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class CensusService extends BaseDAO<Place> {

    /**
     * 各种查询考察考勤调研活动安排
     */
    public List<Place> load(Carrier<Place> carrier) {
        HashMap map = new HashMap(1);
        StringBuffer hql = new StringBuffer();
        hql.append(" from Place p where 1 = 1");
        //为上报与未删除
        hql.append(" and p.reportState != '0'");
        hql.append(" and p.delFlag = '0'");
        if(carrier==null){
           return find(hql.toString());
        }else {
            find(carrier, hql.toString(), map);
            return carrier.getResult();
        }
    }


}
