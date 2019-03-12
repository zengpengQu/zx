package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadHousing;
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
public class AbroadHousingService extends BaseDAO<AbroadHousing> {

    /**
     * 查询列表
     */
    public void load(Carrier<AbroadHousing> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from AbroadHousing t where 1 = 1");

        if (map.containsKey("abroadInfoId")) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
        }

        hql.append(" and t.delFlag = '0' order by t.updateTime desc");

        findNoPg(carrier, hql.toString(), map);
    }

    /**
     * 查询住房信息列表
     *
     * @param abroadInfoId
     * @return
     */
    public List<AbroadHousing> findHousing(String abroadInfoId) {
        Map<String, Object> map = new HashMap<>(1);

        StringBuilder hql = new StringBuilder();
        if (StringUtils.isNotEmpty(abroadInfoId)) {
            hql.append(" from AbroadHousing a where 1=1 and a.delFlag = '0'");
            hql.append(" and a.abroadInfo.id = :abroadInfoId");
            map.put("abroadInfoId", abroadInfoId);
            hql.append(" order by a.checkinDate asc");
        }

        return  find(hql.toString(), map);
    }



}
