package com.taiji.frame.service.pubinfo.schedule;

import com.taiji.frame.dao.pubinfo.schedule.SectionDao;
import com.taiji.frame.model.entity.pubinfo.schedule.Section;
import com.taiji.frame.util.BaseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author admin
 * 板块信息
 * */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class SectionService extends BaseDAO<Section>{

    /**
     * 查找板块信息
     * */
    public List<Section> findSectionList() {

        StringBuffer hql = new StringBuffer();
        hql.append(" from Section s where s.delFlag = 0 order by s.level asc");
        List<Section> sectionList = find(hql.toString(), null);
        return sectionList;
    }

}
