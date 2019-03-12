package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadGroup;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeAccompany;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AbroadGroupUserService extends BaseDAO<DicUser> {

    /**
     * 分页查询列表
     */
    public void load(Carrier<DicUser> carrier, Map<String, Object> map) {
        StringBuffer hql;

        List<String> strList = new ArrayList<>();
        if (map.containsKey("abroadInfoId")) {
            hql  = new StringBuffer();
            hql.append(" from AbroadGroup t where 1 = 1");
            if (map.containsKey("abroadInfoId")) {
                hql.append(" and t.abroadInfo.id = :abroadInfoId");
            }
            hql.append(" and t.delFlag = '0'");
            List<AbroadGroup> list = find(hql.toString(), map);

            if (null != list && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    AbroadGroup abroadGroup = list.get(i);
                    if (abroadGroup.getDicUser() != null) {
                        strList.add(abroadGroup.getDicUser().getId());
                    }
                }
            }
        } else if (map.containsKey("comeInfoId")) {
            hql = new StringBuffer();
            hql.append(" from ComeAccompany t where 1 = 1");
            hql.append(" and t.comeInfo.id = :comeInfoId");
            hql.append(" and t.delFlag = '0'");

            List<ComeAccompany> list = find(hql.toString(), map);

            if (null != list && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    ComeAccompany comeAccompany = list.get(i);
                    if (comeAccompany.getDicUser() != null) {
                        strList.add(comeAccompany.getDicUser().getId());
                    }
                }
            }
        }

        hql = new StringBuffer();
        hql.append(" from DicUser t where 1 = 1");
        if(strList.size()>0) {
            map.put("stringList", strList);
            hql.append(" and t.id not in (:stringList)");
        }
        if (map.containsKey("userName")) {
            hql.append(" and t.empName like :userName");
        }
        if (map.containsKey("deptIds")) {
            hql.append(" and t.dicDept.id in (:deptIds)");
        }
        find(carrier, hql.toString(), map);

    }



}
