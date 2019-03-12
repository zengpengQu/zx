package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.gift.DicGiftType;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author xialiang
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true,rollbackFor = Exception.class)
public class DicGiftTypeService extends BaseDAO<DicGiftType> {

    /**
     * 分页查询
     */
    public void load(Carrier<DicGiftType> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from DicGiftType t where 1 = 1");
        if (map.containsKey("typeName")) {
            hql.append(" and t.typeName like :typeName");
        }
        if (map.containsKey("typeNumber")) {
            hql.append(" and t.typeNumber like :typeNumber");
        }

        hql.append(" and t.delFlag = '0' order by t.createTime desc ");

        find(carrier, hql.toString(), map);
    }

    public List<DicGiftType> getGiftTypeByDelFlag(String delFlag) {
        StringBuffer hql = new StringBuffer(" from DicGiftType d where d.status='0' and d.delFlag= :delFlag");
        Map<String, Object> params = new HashMap<>(16);
        params.put("delFlag", delFlag);
        List<DicGiftType> giftTypeList = find(hql.toString(), params);
        if(null != giftTypeList && giftTypeList.size() > 0 ){
            return giftTypeList;
        }else {
            return null;
        }
    }

    public List<DicGiftType> getDicGiftTypeByTypeNum(String typeNumber) {
        StringBuffer hql;
        if (StringUtils.isNotEmpty(typeNumber)){
             hql = new StringBuffer(" from DicGiftType d where 1=1 and d.status = '0' and d.delFlag = '0'");
             hql.append(" and d.typeNumber = :typeNumber");
        }else{
             hql = new StringBuffer(" from DicGiftType d where 1=1 and d.status='0' and d.delFlag = '0'");
        }
        Map<String, Object> params = new HashMap<>(16);
        params.put("typeNumber", typeNumber);
        List<DicGiftType> dicGiftTypeList = find(hql.toString(), params);

        return dicGiftTypeList;
    }
}
