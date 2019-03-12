package com.taiji.frame.service.pubinfo.contacts;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.contacts.CmmList;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * @author admin
 * 人员通讯录
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ContactsUserService extends BaseDAO<CmmList> {

    /**
     * 分页查询通讯录列表
     */
    public void load(Carrier<CmmList> carrier, Map<String, Object> map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from CmmList t where 1 = 1");
        if (map.containsKey("id")) {
            hql.append(" and t.cmmListDepts.id = :id");
        }
        if (map.containsKey("userId")) {
            hql.append(" and t.id = :userId");
        }
        if (map.containsKey("deptName")) {
            hql.append(" and t.department like '%").append(map.get("deptName")).append("%'");
        }
        if (map.containsKey("location")) {
            hql.append(" and t.location like '%").append(map.get("location")).append("%'");
        }
        if (map.containsKey("name")) {
            hql.append(" and t.name like '%").append(map.get("name")).append("%'");
        }

        hql.append(" and t.delFlag = '0'");
        find(carrier, hql.toString(), map);
    }

}
