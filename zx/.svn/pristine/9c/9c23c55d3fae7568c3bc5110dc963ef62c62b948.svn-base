package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadGroup;
import com.taiji.frame.model.entity.foreignaffairs.businessPassport.BusinessPassport;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AbroadPassportService extends BaseDAO<BusinessPassport> {

    /**
     * 查询护照列表
     */
    public void load(Carrier<BusinessPassport> carrier, Map<String, Object> map) {
        StringBuffer sql = new StringBuffer();
        sql.append(" from AbroadGroup t where t.delFlag = '0'");
        if (map.containsKey("abroadInfoId")) {
            sql.append(" and t.abroadInfo.id = :abroadInfoId");
        }
        List<AbroadGroup> groupList = find(sql.toString(), map);

        List<String> strList = new ArrayList<>();
        if (null!=groupList && groupList.size()>0) {
            for(int i=0; i<groupList.size(); i++) {
                AbroadGroup abroadGroup = groupList.get(i);
                if (abroadGroup.getDicUser() != null) {
                    strList.add(abroadGroup.getDicUser().getId());
                }
            }
        }

        HashMap hashMap = new HashMap(16);
        if(strList.size()>0) {
            hashMap.put("strList", strList);
        }
        StringBuffer hql = new StringBuffer();
        hql.append(" from BusinessPassport t where t.delFlag = '0'");
        if (hashMap.containsKey("strList")) {
            hql.append(" and t.dicUser.id in (:strList)");
        }
        findNoPg(carrier, hql.toString(), hashMap);
    }



}
