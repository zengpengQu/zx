package com.taiji.frame.service.systempara;

import com.taiji.frame.model.systempara.SecPopedomView;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by zhangshuai on 2016/2/1.
 * @author pengyx
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true,rollbackFor = Exception.class)
public class SecPopedomViewService extends BaseDAO<SecPopedomView>{

    /**
     *根据组织grade 获取SecPopedomView
     */
    public List<SecPopedomViewService> getListByOrgGrade(String Grade){
        StringBuffer hql = new StringBuffer("from SecPopedomView where id in( select id from roleTypeRes where id =)");
        return null;
    }
}
