package com.taiji.frame.service.foreignaffairs.businessPassport;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.businessPassport.BorrowReturnRecord;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 因公护照操作记录
 * Created by yuLei on 2018/7/27.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class BorrowReturnRecordService extends BaseDAO<BorrowReturnRecord> {

    public Map<String, List<BorrowReturnRecord>> findRecordByBPId(String BPId) {
        Map<String, List<BorrowReturnRecord>> recordMap = new LinkedHashMap<>();
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from BorrowReturnRecord t where 1 = 1");
        if (StringUtils.isNotEmpty(BPId)) {
            hql.append(" and t.businessPassport.id = :BPId");
            params.put("BPId", BPId);
        }
        hql.append(" order by t.createTime desc");
        List<BorrowReturnRecord> borrowReturnRecordList = find(hql.toString(), params);
        for (BorrowReturnRecord record : borrowReturnRecordList) {
            String createTime = DateUtil.dateToString(record.getCreateTime(), DateUtil.FORMAT_DAY);
            if (recordMap.containsKey(createTime)){
                List<BorrowReturnRecord> records = recordMap.get(createTime);
                records.add(record);
            }else {
                List<BorrowReturnRecord> records = new ArrayList<>();
                records.add(record);
                recordMap.put(createTime, records);
            }
        }
        return recordMap;
    }

}
