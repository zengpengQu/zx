package com.taiji.frame.service.foreignaffairs.tempForeignAffairs;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.tempForeignAffairs.Chronicle;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/7/18
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true,rollbackFor = Exception.class)
public class ChronicleService extends BaseDAO<Chronicle> {
    private static final Logger log = LoggerFactory.getLogger(ChronicleService.class);

    /**
     * 大事件表格展示
     * @param carrier
     * @param map
     */
    public void load(Carrier<Chronicle> carrier, HashMap map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from Chronicle ch where 1 = 1");
        if(map.containsKey("groupLevel")){
            hql.append(" and ch.dicParam.id = :groupLevel");
        }
        if(map.containsKey("comeInfoId")){
            hql.append(" and ch.comeInfo.id = :comeInfoId");
        }
        if(map.containsKey("beginTime")){
            hql.append(" and to_char(ch.beginTime,'yyyy-MM-dd') >= :beginTime");
        }
        if(map.containsKey("endTime")){
            hql.append(" and to_char(ch.endTime,'yyyy-MM-dd') <= :endTime");
        }
        if(map.containsKey("nationalName")){
            hql.append(" and ch.nationalName like '%"+map.get("nationalName")+"%'");
        }
        hql.append(" and ch.delFlag = '0'");
        find(carrier, hql.toString(), map);
    }

    /**
     * 根据来访信息 Id 查找大事记
     * @param comeInfoId
     * @return
     */
    public List<Chronicle> findByComeInfoId(String comeInfoId) {
        Map<String, Object> params = new HashMap<>(1);

        StringBuffer hql = new StringBuffer();
        hql.append(" from Chronicle c where 1=1 and c.delFlag=0");

        if (StringUtils.isNotEmpty(comeInfoId)) {
            hql.append(" and c.comeInfo.id = :comeInfoId order by c.createTime");
            params.put("comeInfoId", comeInfoId);
        }

        List<Chronicle> chronicleList = createQueryList(hql.toString(), params);

        return chronicleList;
    }

    /**
     * 根据临时外事 Id 查找大事记
     * @param tempAffairsId
     * @return
     */
    public List<Chronicle> findByTempAffairsId(String tempAffairsId) {
        Map<String, Object> params = new HashMap<>(1);

        StringBuffer hql = new StringBuffer();
        hql.append(" from Chronicle c where 1=1 and c.delFlag=0");

        if (StringUtils.isNotEmpty(tempAffairsId)) {
            hql.append(" and c.tempAffairs.id = :tempAffairsId order by c.createTime");
            params.put("tempAffairsId", tempAffairsId);
        }

        List<Chronicle> chronicleList = createQueryList(hql.toString(), params);

        return chronicleList;
    }

}
