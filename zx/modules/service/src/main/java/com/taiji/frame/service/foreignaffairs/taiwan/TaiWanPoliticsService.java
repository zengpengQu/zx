package com.taiji.frame.service.foreignaffairs.taiwan;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanParty;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanPolitics;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/08/07
 * 台湾主要人士服务
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class TaiWanPoliticsService extends BaseDAO<TaiWanPolitics> {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanPoliticsService.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private TaiWanPartyService taiWanPartyService;

    @Autowired
    private SysLogService sysLogService;

    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<TaiWanPolitics> carrier, Map<String,Object> map) {
        StringBuilder hql = new StringBuilder(" from TaiWanPolitics tp where 1 = 1");
        if (map.containsKey("mainName")){
            hql.append(" and tp.mainName like :mainName");
        }
        hql.append(" and tp.delFlag = '0'");
        find(carrier,hql.toString(),map);
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> saveOrUpdate(String partyId, TaiWanPolitics taiWanPolitics, String birthdayStr, SysLogVo sysLogVo) {
        Map<String, Object> map = new HashMap<String, Object>(2);
        String id = taiWanPolitics.getId();
        try {
            if (StringUtils.isNotEmpty(id)){
                //编辑
                setData(partyId,taiWanPolitics,birthdayStr);
                //保存
                this.save(taiWanPolitics);
                map.put("taiWanPolitics", taiWanPolitics);
                map.put("result", true);
            }else {
                //新增
                taiWanPolitics.setCreateTime(new Date());
                setData(partyId,taiWanPolitics,birthdayStr);
                //保存
                this.save(taiWanPolitics);
                map.put("taiWanPolitics", taiWanPolitics);
                map.put("result", true);
            }
            sysLogVo.setTypeName("台湾主要人士");
            if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(taiWanPolitics.getMainName());
            sysLogVo.setEntityId(taiWanPolitics.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(),e);
            map.put("result",false);
            return map;
        }
        return map;
    }

    private void setData(String partyId,TaiWanPolitics taiWanPolitics,String birthdayStr) {
//        TaiWanParty taiWanParty = new TaiWanParty();
//        taiWanParty.setId(partyId);
//        taiWanPolitics.setTaiWanParty(taiWanParty);
        taiWanPolitics.setBirthday(DateUtil.stringToDate(birthdayStr, DateUtil.FORMAT_DAY));
        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN);
        taiWanPolitics.setUpdateTime(updateTime);
        taiWanPolitics.setDelFlag("0");
    }

    @Transactional(rollbackFor = Exception.class)
    public void viewLoad(Carrier<TaiWanPolitics> carrier, Map<String,Object> map) {
        StringBuilder hql = new StringBuilder(" from TaiWanPolitics tp where 1 = 1");
        if (map.containsKey("partyId")){
            hql.append(" and tp.taiWanParty.id = :partyId");
        }
        hql.append(" and tp.delFlag = '0'");
        find(carrier,hql.toString(),map);
    }

    @Transactional(rollbackFor = Exception.class)
    public List<TaiWanPolitics> findByCardId(Map<String,Object> params) {
        StringBuffer hql = new StringBuffer(" from TaiWanPolitics t where 1 = 1");
        List<TaiWanPolitics> list = null;
        if (params.containsKey("id")){
            hql.append(" and t.taiWanParty.id = :id");
        }
        hql.append(" and t.delFlag = '0'");
        list = find(hql.toString(),params);
        return list;
    }


}
