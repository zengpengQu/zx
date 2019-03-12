package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.model.entity.foreignaffairs.gift.GiftsApplication;
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
public class GiftsApplicationService extends BaseDAO<GiftsApplication> {
    /**
     * 申请礼品清单列表
     */
    public List<GiftsApplication> getGiftsByApplicationId(String applicationId) {
        StringBuffer hql;
        List<GiftsApplication> giftsApplicationList = null;
        Map<String, Object> params = new HashMap<>(16);

        if (StringUtils.isNotEmpty(applicationId)){
            hql = new StringBuffer(" from GiftsApplication d where 1=1 and d.delFlag = '0' and d.giftApplication.id = :applicationId");
            params.put("applicationId", applicationId);
            giftsApplicationList = find(hql.toString(), params);
        }

        return giftsApplicationList;
    }
}
