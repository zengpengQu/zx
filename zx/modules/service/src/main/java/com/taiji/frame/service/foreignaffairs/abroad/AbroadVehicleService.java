package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadVehicle;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AbroadVehicleService  extends BaseDAO<AbroadVehicle> {

    /**
     * 查询列表
     */
    public void load(Carrier<AbroadVehicle> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from AbroadVehicle t where 1 = 1");

        if (map.containsKey("abroadInfoId")) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
        }

        hql.append(" and t.delFlag = '0' order by t.createTime asc");

        findNoPg(carrier, hql.toString(), map);
    }


    /**
     * 查询乘车信息列表
     * @param abroadInfoId
     * @return
     */
    public List<AbroadVehicle> findVehicle(String abroadInfoId) {
        Map<String, Object> map = new HashMap<>(1);

        StringBuilder hql = new StringBuilder();
        if (StringUtils.isNotEmpty(abroadInfoId)) {
            hql.append(" from AbroadVehicle a where 1=1 and a.delFlag = '0'");
            hql.append(" and a.abroadInfo.id = :abroadInfoId");
            map.put("abroadInfoId", abroadInfoId);
            hql.append(" order by a.updateTime asc");
        }

        return  find(hql.toString(), map);
    }

}
