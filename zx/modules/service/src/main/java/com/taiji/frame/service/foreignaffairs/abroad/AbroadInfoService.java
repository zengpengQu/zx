package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadInfo;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AbroadInfoService extends BaseDAO<AbroadInfo> {

    /**
     * 分页查询出访活动列表
     */
    public void load(Carrier<AbroadInfo> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from AbroadInfo t where 1 = 1");

        if (map.containsKey("deptId")) {
            hql.append(" and t.org.id = :deptId");
        }
        if (map.containsKey("groupNumber")) {
            hql.append(" and t.groupNumber like :groupNumber");
        }
        if (map.containsKey("groupName")) {
            hql.append(" and t.groupName like :groupName");
        }
        if (map.containsKey("batchNumber")) {
            hql.append(" and t.batchNumber like :batchNumber");
        }
        if (map.containsKey("startTime")){
            hql.append(" and to_char(t.endDate,'yyyy-MM-dd') >= :startTime");
        }
        if (map.containsKey("endTime")){
            hql.append(" and to_char(t.startDate,'yyyy-MM-dd') <= :endTime");
        }

        hql.append(" and t.delFlag = '0'");

        find(carrier, hql.toString(), map);
    }

    public List<AbroadInfo> findWithGiftApp() {

        StringBuffer hql = new StringBuffer();

        hql.append(" select distinct c from AbroadInfo c, GiftApplication g where 1 = 1");
        hql.append(" and c.id = g.abroadinfoId and g.delFlag = '0'");
        hql.append(" and c.delFlag = 0");

        return find(hql.toString());
    }

}
