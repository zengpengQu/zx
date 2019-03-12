package com.taiji.frame.service.foreignaffairs.abroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.abroad.AbroadGroup;
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
public class AbroadGroupService extends BaseDAO<AbroadGroup> {

    /**
     * 查询列表
     */
    public void load(Carrier<AbroadGroup> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from AbroadGroup t where 1 = 1");

        if (map.containsKey("abroadInfoId")) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
        }

        if (map.containsKey("flag")) {
            if (map.get("flag").equals("in")) {
                hql.append(" and t.dicUser.id is not null");
            } else if (map.get("flag").equals("out")) {
                hql.append(" and t.dicUser.id is null");
            }
        }

        hql.append(" and t.delFlag = '0' order by t.role.id asc, t.sorting asc");

        findNoPg(carrier, hql.toString(), map);
    }

    public List<AbroadGroup> findAbroadGroupByParams(String abroadInfoId, String flag) {
        Map<String, Object> map = new HashMap<>(1);
        StringBuffer hql = new StringBuffer();

        hql.append(" from AbroadGroup t where 1=1");

        if (StringUtils.isNotEmpty(abroadInfoId)) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
            map.put("abroadInfoId", abroadInfoId);
        }

        if (StringUtils.isNotEmpty(flag)) {
            if ("in".equals(flag)) {
                hql.append(" and t.dicUser.id is not null");
            } else if ("out".equals(flag)) {
                hql.append(" and t.dicUser.id is null");
            }
        }

        hql.append(" and t.delFlag = '0' order by t.role.id asc, t.sorting asc");

        List<AbroadGroup> abroadGroupList = find(hql.toString(), map);
        return abroadGroupList;
    }


    public AbroadGroup findAbroadGroupByUserId(String abroadInfoId, String userId) {
        Map<String, Object> map = new HashMap<>(1);
        StringBuffer hql = new StringBuffer();

        hql.append(" from AbroadGroup t where 1=1");

        if (StringUtils.isNotEmpty(abroadInfoId)) {
            hql.append(" and t.abroadInfo.id = :abroadInfoId");
            map.put("abroadInfoId", abroadInfoId);
        }

        if (StringUtils.isNotEmpty(userId)) {
            hql.append(" and t.dicUser.id = :userId");
            map.put("userId", userId);
        }

        hql.append(" and t.delFlag = '0'");

        AbroadGroup abroadGroup = findUnique(hql.toString(), map);
        return abroadGroup;

    }

}
