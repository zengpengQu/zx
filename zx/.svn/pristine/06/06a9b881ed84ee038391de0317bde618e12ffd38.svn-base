package com.taiji.frame.service.pubinfo.contacts;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.contacts.CmmListt;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @author admin
 * 单位通讯录
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ContactsDepService extends BaseDAO<CmmListt> {

    /**
     * 分页查询通讯录列表
     */
    public void load(Carrier<CmmListt> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from CmmListt t where 1 = 1");
        if (map.containsKey("deptId")) {
            hql.append(" and t.dicDept.id = :deptId");
        }
        if (map.containsKey("teamId")) {
            hql.append(" and t.addressTeam.id = :teamId");
        }
        if (map.containsKey("deptName")) {
            hql.append(" and t.dicDept.deptName like '%").append(map.get("deptName")).append("%'");
        }
        if (map.containsKey("location")) {
            hql.append(" and t.location like '%").append(map.get("location")).append("%'");
        }
        if (map.containsKey("dicId")) {
            hql.append(" and t.dicDept.id = :dicId");
        }

        hql.append(" and t.delFlag = '0'");
        find(carrier, hql.toString(), map);
    }

    public List<CmmListt> loadGetAll(String orderBy,String id) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from CmmListt t where 1 = 1");
        if(StringUtils.isNotEmpty(id)){
            hql.append(" and t.addressTeam.id = '"+id+"' ");
        }
        hql.append(" and t.delFlag = '0'");
        hql.append(" order by ");
        hql.append(orderBy);

        return find(hql.toString());
    }
}
