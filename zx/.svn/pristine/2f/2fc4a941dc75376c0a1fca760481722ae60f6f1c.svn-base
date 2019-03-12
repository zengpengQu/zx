package com.taiji.frame.service.foreignaffairs.businessPassport;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.businessPassport.BusinessPassport;
import com.taiji.frame.model.vo.passportuser.PassportUserVo;
import com.taiji.frame.util.BaseDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 因公护照管理
 * Created by yuLei on 2018/7/23.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class BusinessPassportService extends BaseDAO<BusinessPassport> {

    /**
     * 分页查询因公护照列表
     */
    public void load(Carrier<BusinessPassport> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from BusinessPassport t where 1 = 1");
        if (map.containsKey("curUserId")) {
            hql.append(" and t.dicUser.id = :curUserId");
        }
        if (map.containsKey("userName")) {
            hql.append(" and t.dicUser.empName like :userName");
        }
        if (map.containsKey("passportNo")) {
            hql.append(" and t.passportNo like :passportNo");
        }
        if (map.containsKey("validDate")) {
            hql.append(" and to_char(t.validDate, 'YYYY-MM-DD') = :validDate");
        }
        if (map.containsKey("batchNumber")) {
            hql.append(" and t.id in (select businessPassport.id from BorrowPassport b where b.batchNumber = :batchNumber)");
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");

        find(carrier, hql.toString(), map);
    }

    public void loadUser(Carrier<PassportUserVo> carrier, Map<String, Object> map) {
        StringBuffer sql = new StringBuffer("SELECT u.ID AS id, (SELECT DEPT_NAME FROM SCH_DUTY.TB_DIC_DEPT where ID = u.DEPT_ID) AS deptName, u.EMP_NAME AS empName,");
        sql.append(" u.SEX AS sex, u.NATION as nation, u.BIRTHDAY AS birthday, u.BIRTHPLACE AS birthplace,");
        sql.append(" u.PHONE AS phone, u.MAIN_DUTY AS mainDuty, (SELECT NAME FROM SCH_DUTY.TB_DIC_PARAM where ID = u.RANK_ID) AS rankName, c.id as transactStatus,");
        sql.append(" u.CREATE_DATE AS createDate");

        sql.append(" from SCH_DUTY.TB_DIC_USER u left join (SELECT ID, USER_ID from SCH_DUTY.BP_BUSINESS_PASSPORT card where card.DEL_FLAG='0') c");
        sql.append(" on u.ID = c.USER_ID");
        sql.append(" where 1=1");

        if (map.containsKey("empName")) {
            sql.append(" and u.EMP_NAME like :empName");
        }
        if (map.containsKey("searchUserId")) {
            sql.append(" and u.USER_ID like :searchUserId");
        }
        if (map.containsKey("stringList")) {
            sql.append(" and u.DEPT_ID.id in (:stringList)");
        }
        if (map.containsKey("rankId")) {
            sql.append(" and u.RANK_ID = :rankId");
        }

        findBySql(PassportUserVo.class, carrier, sql.toString(), map);
    }

    /**
     * 判断是否可以办理
     * @param userId
     */
    public Boolean isCanTransact(String userId) {
        StringBuffer hql = new StringBuffer();
        Map<String, Object> params = new HashMap();
        hql.append(" from BusinessPassport t where t.isCancel = 0 and t.isDestroy = 0 and t.delFlag = 0");
        if (StringUtils.isNotEmpty(userId)) {
            hql.append(" and t.dicUser.id = :userId");
            params.put("userId", userId);
        }
        List<BusinessPassport> businessPassportList = find(hql.toString(), params);
        if (null != businessPassportList && businessPassportList.size() > 0) {
            return false;
        } else {
            return true;
        }
    }

}
