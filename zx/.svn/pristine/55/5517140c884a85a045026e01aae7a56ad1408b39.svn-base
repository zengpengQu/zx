package com.taiji.frame.service.foreignaffairs.passportRecord;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.passportRecord.BorrowRecord;
import com.taiji.frame.util.BaseDAO;
import net.sf.json.JSON;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 证件借用流转记录
 * Created by yuLei on 2018/8/1.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class BorrowRecordService extends BaseDAO<BorrowRecord> {

    public Map<String, List<BorrowRecord>> findRecordByPermitId(String permitId) {
        Map<String, List<BorrowRecord>> recordMap = new LinkedHashMap<>();
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from BorrowRecord t where 1 = 1");
        if (StringUtils.isNotEmpty(permitId)) {
            hql.append(" and t.permitId = :permitId");
            params.put("permitId", permitId);
        }
        hql.append(" order by t.createTime desc");
        List<BorrowRecord> borrowRecordList = find(hql.toString(), params);
        for (BorrowRecord record : borrowRecordList) {
            String createTime = DateUtil.dateToString(record.getCreateTime(), DateUtil.FORMAT_DAY);
            if (recordMap.containsKey(createTime)){
                List<BorrowRecord> records = recordMap.get(createTime);
            JSON jsonObject = record.getJsonObject();
                records.add(record);
            }else {
                List<BorrowRecord> records = new ArrayList<>();
                records.add(record);
                recordMap.put(createTime, records);
            }
        }
        return recordMap;
    }

}
