package com.taiji.frame.service.foreignaffairs.come;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.come.ComeInfo;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicParam;
import com.taiji.frame.model.vo.foreignaffairs.come.ComeInfoVo;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicParamService;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class ComeInfoService extends BaseDAO<ComeInfo> {

    private static final Logger LOG = LoggerFactory.getLogger(ComeInfoService.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private DicParamService dicParamService;

    @Autowired
    private DicDeptService dicDeptService;

    /**
     * 分页查询来访信息列表
     */
    public void load(Carrier<ComeInfo> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from ComeInfo c where 1 = 1");
        if (map.containsKey("groupName")) {
            hql.append(" and c.groupName like :groupName");
        }
        if (map.containsKey("cnName")) {
            hql.append(" and c.cnName like :cnName");
        }
        if (map.containsKey("foreignName")) {
            hql.append(" and c.foreignName like :foreignName");
        }
        if (map.containsKey("startDate")) {
            hql.append(" and to_char(c.startDate, 'yyyy-MM-dd') >= :startDate");
        }
        if (map.containsKey("endDate")) {
            hql.append(" and to_char(c.endDate, 'yyyy-MM-dd') <= :endDate");
        }

        hql.append(" and c.delFlag = 0");

        findNoPg(carrier, hql.toString(), map);
    }

    /**
     * 保存来访信息
     */
    @Transactional(rollbackFor = Exception.class)
    public void saveInfo(ComeInfoVo comeInfoVo) {

        ComeInfo comeInfo;
        if (comeInfoVo.getId() == null) {
            comeInfo = new ComeInfo();
        } else {
            comeInfo = this.get(comeInfoVo.getId());
        }

        // 设置团组编号
        String groupNumber = comeInfoVo.getGroupNumber();
        comeInfo.setGroupNumber(groupNumber);

        // 设置团组名称
        String groupName = comeInfoVo.getGroupName();
        comeInfo.setGroupName(groupName);

        // 设置邀请名义
        DicParam invitation = dicParamService.get(comeInfoVo.getInvitationId());
        comeInfo.setInvitation(invitation);

        // 设置团组级别
        DicParam groupLevel = dicParamService.get(comeInfoVo.getGroupLevelId());
        comeInfo.setGroupLevel(groupLevel);

        // 设置主办单位
        DicDept sponsor = dicDeptService.get(comeInfoVo.getSponsorId());
        comeInfo.setDicDept(sponsor);

        // 设置来访国家
        String countryId = comeInfoVo.getCountryId();
        comeInfo.setCountryId(countryId);

        // 设置来访团人数
        String peopleNum = comeInfoVo.getPeopleNum();
        comeInfo.setPeopleNum(peopleNum);

        // 设置团长中文名
        String cnName = comeInfoVo.getCnName();
        comeInfo.setCnName(cnName);

        // 设置外文名
        String foreignName = comeInfoVo.getForeignName();
        comeInfo.setForeignName(foreignName);

        // 设置来访开始日期
        Date startDate = DateUtil.stringToDate(comeInfoVo.getStartDateStr(), DateUtil.FORMAT_DAY);
        comeInfo.setStartDate(startDate);

        // 设置来访结束日期
        Date endDate = DateUtil.stringToDate(comeInfoVo.getEndDateStr(), DateUtil.FORMAT_DAY);
        comeInfo.setEndDate(endDate);

        String taskDscr = comeInfoVo.getTaskDscr().trim();
        comeInfo.setTaskDscr(taskDscr);

        // 设置更新时间
        comeInfo.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN));
        // 设置删除标志，未删除
        comeInfo.setDelFlag("0");

        try {
            this.save(comeInfo);
        } catch (Exception e) {
            LOG.error("保存来访信息失败" + e.getMessage(), e);
        }
    }

    public List<ComeInfo> findWithGiftApp() {

        StringBuffer hql = new StringBuffer();

        hql.append(" select distinct c from ComeInfo c, GiftApplication g where 1 = 1");
        hql.append(" and c.id = g.comeInfoId and g.delFlag = '0'");
        hql.append(" and c.delFlag = 0");

        return find(hql.toString());
    }
}
