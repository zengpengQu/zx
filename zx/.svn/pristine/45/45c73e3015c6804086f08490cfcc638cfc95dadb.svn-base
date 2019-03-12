package com.taiji.frame.service.foreignaffairs.passportRecord;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.AskReturnRecord;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * 证照催还记录
 * Created by yuLei on 2018/8/2.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AskReturnRecordService extends BaseDAO<AskReturnRecord> {

    /**
     * 分页查询列表
     */
    public void load(Carrier<AskReturnRecord> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from AskReturnRecord t where 1 = 1");
        if (map.containsKey("peopleName")) {
            hql.append(" and t.peopleName like :peopleName");
        }
        if (map.containsKey("documentCode")) {
            hql.append(" and t.documentCode like :documentCode");
        }
        if (map.containsKey("startTime") && map.containsKey("endTime")) {
            hql.append(" and to_date(t.askTime, 'YYYY-MM-DD') between to_date(:startTime, 'YYYY-MM-DD') and to_date(:endTime, 'YYYY-MM-DD')");
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");

        find(carrier, hql.toString(), map);
    }

}
