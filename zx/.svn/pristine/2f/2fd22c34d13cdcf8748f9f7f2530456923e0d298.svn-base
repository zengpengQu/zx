package com.taiji.frame.service.foreignaffairs.council;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.taiji.frame.model.entity.foreignaffairs.council.Congress;

import java.util.List;
import java.util.Map;


/**
 * @author sy
 * Created by suny on 2018/7/4.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class CongressService extends BaseDAO<Congress> {

    /**
     * load grid 表格数据
     */
    public void Load(Carrier<Congress> carrier, Map<String, Object> map){
        StringBuffer hql = new StringBuffer();
        hql.append(" from Congress c where 1 = 1");
        if (map.containsKey("title")) {
            hql.append(" and c.title like :title");
        }
        if (map.containsKey("meetingSite")) {
            hql.append(" and c.meetingSite like :meetingSite");
        }
        if (map.containsKey("time")) {
            hql.append(" and to_char(c.time, 'yyyy-MM-dd') = :time");
        }
        hql.append(" and c.delFlag = 0");
        find(carrier, hql.toString(), map);
    }


/**
 * 会议标题查询
 */

public List<Congress> findByCongressTitle() {
    String hql = "from Congress";
    List<Congress> list =find(hql);
    return list;
}


}
