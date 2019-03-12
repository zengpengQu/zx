package com.taiji.frame.dao.pubinfo.schedule;

import com.taiji.frame.model.entity.pubinfo.schedule.Section;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author admin
 * 板块信息
 */
@Repository
public class SectionDao extends BaseDAO<Section> {

    /**
     * 查询所有板块信息
     */
    public List<Section> findSectionList() {

        StringBuffer hql = new StringBuffer();
        hql.append(" from section s where s.delFlag = 0 order by s.level desc");
        List<Section> sectionList = find(hql.toString(), null);
        return sectionList;
    }
}
