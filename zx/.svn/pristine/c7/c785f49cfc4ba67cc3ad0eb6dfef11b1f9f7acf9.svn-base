package com.taiji.frame.service.pubinfo.batch;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.pubinfo.batch.DicReason;
import com.taiji.frame.model.entity.pubinfo.batch.DraftBatch;
import com.taiji.frame.model.entity.pubinfo.batch.LeaderManage;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author wsh
 * @date 2018/9/18
 * 报送领导管理
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class LeaderManageService extends BaseDAO<LeaderManage>{
    /**
     * 分页查询报送领导列表,默认加载所有的
     */
    public void load(Carrier<LeaderManage> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from LeaderManage w where 1 = 1");

        if(map.containsKey("leaName")){
            hql.append(" and w.leaName like '%"+map.get("leaName")+"%'");
        }
        if (map.containsKey("tel")) {
            hql.append(" and w.tel like '%"+map.get("tel")+"%'");
        }
        hql.append(" and w.delFlag = '0'");
        find(carrier, hql.toString(), map);
    }

    /**
     * 返回一个领导姓名给领导批示模块使用
     * @param status
     * @return
     */
    public List<LeaderManage> getAllByStatus(String status){
        StringBuffer hql = new StringBuffer(" from LeaderManage d where d.delFlag=:status");
        hql.append(" order by seq asc");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("status", status);
        List<LeaderManage> LeaderManageList = find(hql.toString(),params);
        return  LeaderManageList;
    }

    /**
     * 上下调整顺序使用
     * @param seq
     * @return
     */
    public LeaderManage getBySeq(Integer seq){
        StringBuffer hql = new StringBuffer(" from LeaderManage d where d.seq=:seq");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("seq", seq);
        LeaderManage leaderManage = findUnique(hql.toString(),params);
        return leaderManage;
    }

    /**
     * 用于返排序字段的最值
     * @return
     */
    public Integer findSeq(){
        String sql = "select max(SEQ) as seq from SCH_DUTY.PU_LEADER_MANAGE";
        return executeSql(sql,null);
    }



}
