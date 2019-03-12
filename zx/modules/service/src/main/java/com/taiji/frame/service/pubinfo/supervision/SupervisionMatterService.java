package com.taiji.frame.service.pubinfo.supervision;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionMatter;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.vo.pubinfo.supervision.SupervisionMatterVo;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.omg.PortableInterceptor.SUCCESSFUL;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/08/23
 * 督查事项服务
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class SupervisionMatterService extends BaseDAO<SupervisionMatter> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SupervisionMatterService.class);

    @Autowired
    private UtilService utilService;

    /**
     * jqgrid 表格数据
     * @param carrier
     * @param map
     */
    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<SupervisionMatter> carrier, Map<String,Object> map) {
        StringBuffer hql = new StringBuffer(" from SupervisionMatter sm where 1 = 1");
        if (map.containsKey("hostUnitId") && map.containsKey("hostUnitId")){
            if (map.containsKey("viewOthers")) {
                hql.append(" and (sm.hostUnit.id = :hostUnitId and sm.cooperative.id = :cooperativeId)");
            } else {
                hql.append(" and (sm.hostUnit.id = :hostUnitId or sm.cooperative.id = :cooperativeId)");
            }
        } else if (map.containsKey("hostUnitId")){
            hql.append(" and sm.hostUnit.id = :hostUnitId");
        } else if (map.containsKey("cooperativeId")){
            hql.append(" and sm.cooperative.id = :cooperativeId");
        }
        if (map.containsKey("supMatter")){
            hql.append(" and sm.supMatter like :supMatter");
        }
        if (map.containsKey("beginTime") && map.containsKey("endTime")){
            hql.append(" and sm.issuedDate between to_date(:beginTime, 'YYYY-MM-DD') and to_date(:endTime, 'YYYY-MM-DD')");
        }
        if (map.containsKey("serialNumber")){
            hql.append(" and sm.serialNumber like :serialNumber");
        }
        if (map.containsKey("statusList")){
            hql.append(" and sm.status in (:statusList)");
        }
        hql.append(" and sm.delFlag = '0'");
        find(carrier, hql.toString(), map);
    }

    /**
     * 新增/编辑----保存、下发
     * @param supervisionMatterVo
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> saveOrUpdate(SupervisionMatterVo supervisionMatterVo) {
        Map<String, Object> map = new HashMap<String, Object>(3);
        SupervisionMatter matter = new SupervisionMatter();
        try {
            if (StringUtils.isEmpty(supervisionMatterVo.getStatus())) {
                matter.setStatus("0");
            }else {
                matter.setStatus(supervisionMatterVo.getStatus());
            }
            if (StringUtils.isNotEmpty(supervisionMatterVo.getId())){
                matter.setId(supervisionMatterVo.getId());
            }
            this.setData(supervisionMatterVo,matter);
            this.save(matter);
            map.put("matterLog",matter);
            map.put("result", true);
        }catch (Exception e){
            LOGGER.debug(e.getMessage(),e);
            map.put("result", false);
        }
        return map;
    }


    public void setData(SupervisionMatterVo supervisionMatterVo, SupervisionMatter matter) {
        String hostUnitId = supervisionMatterVo.getHostUnitId();
        DicDept dicDept = new DicDept();
        dicDept.setId(hostUnitId);
        matter.setHostUnit(dicDept);

        String cooperativeId = supervisionMatterVo.getDeptId();
        DicDept dept = new DicDept();
        dept.setId(cooperativeId);
        matter.setCooperative(dept);

        String supMatter = supervisionMatterVo.getSupMatter();
        matter.setSupMatter(supMatter);

        String requirements = supervisionMatterVo.getRequirements();
        matter.setRequirements(requirements);

        String serialNumber = supervisionMatterVo.getSerialNumber();
        matter.setSerialNumber(serialNumber);

        String issuedDateStr = supervisionMatterVo.getIssuedDateStr();
        matter.setIssuedDate(DateUtil.stringToDate(issuedDateStr,DateUtil.FORMAT_DAY));

        matter.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT_DAYTIME));
        matter.setDelFlag("0");
    }


}
