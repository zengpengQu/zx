package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadNation;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AbroadNationService extends BaseDAO<AbroadNation> {

    /**
     * 查询列表
     */
    public void load(Carrier<AbroadNation> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from AbroadNation t where 1 = 1");

        if (map.containsKey("abroadInfoId")) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
        }

        hql.append(" and t.delFlag = '0' order by t.updateTime desc");

        findNoPg(carrier, hql.toString(), map);
    }

    public List<AbroadNation> findAbroadNationList(String abroadInfoId) {
        Map<String, Object> map = new HashMap<>(1);
        StringBuffer hql = new StringBuffer();
        map.put("abroadInfoId", abroadInfoId);
        hql.append(" from AbroadNation t where t.abroadInfo.id = :abroadInfoId and t.delFlag = '0'");
        List<AbroadNation> abroadNationList = find(hql.toString(), map);
        return  abroadNationList;
    }


    public List<String> findStopoverNationList(String abroadInfoId) {
        Map<String, Object> map = new HashMap<>(1);
        StringBuffer hql = new StringBuffer();
        map.put("abroadInfoId", abroadInfoId);
        hql.append(" select t.trsCountry from AbroadNation t where t.abroadInfo.id = :abroadInfoId and t.delFlag = '0'");
        List<String> trsCountryList = find(hql.toString(), map);
        return  trsCountryList;
    }



}
