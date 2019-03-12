package com.taiji.frame.service.systempara;

import com.taiji.frame.model.systempara.DicNation;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 系统国家信息
 * Created by yuLei on 2018/8/16.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true)
public class DicNationService extends BaseDAO<DicNation> {

    public List<DicNation> findDicNationList() {
        String hql = "from DicNation t ";
        List<DicNation> dicNationList = find(hql);
        return dicNationList;
    }

}
