package com.taiji.frame.service.foreignaffairs.come;

import com.taiji.frame.model.entity.foreignaffairs.come.ComePeopleInfo;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * 来访陪同人员信息Service
 *
 * @author yx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ComePeopleInfoService extends BaseDAO<ComePeopleInfo>{

//    /**
//     * 根据陪同人员
//     */
//    public ComePeopleInfo findByAccompanyId(String accompanyId) {
//        StringBuilder hql = new StringBuilder();
//
//        hql.append("from ComePeopleInfo c where c.id := accompanyId and delFlag=0");
//        Map<String, Object> params = new HashMap<>(1);
//        params.put("comeInfoId", accompanyId);
//
//        return find(hql.toString(), params);
//    }
}
