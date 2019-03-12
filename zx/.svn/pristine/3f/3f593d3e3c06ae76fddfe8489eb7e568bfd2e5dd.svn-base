package com.taiji.frame.service.foreignaffairs.privateAbroad;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.foreignaffairs.privateAbroad.PrivatePassport;
import com.taiji.frame.model.systempara.DicUser;
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
 * 因私护照管理
 * Created by yuLei on 2018/7/31.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class PrivatePassportService extends BaseDAO<PrivatePassport> {

    /**
     * 分页查询列表
     */
    public void load(Carrier<PrivatePassport> carrier, Map<String, Object> map) {

        StringBuffer hql = new StringBuffer();
        hql.append(" from PrivatePassport t where 1 = 1");
        if (map.containsKey("curUserId")) {
            hql.append(" and t.dicUser.id = :curUserId");
        }
        if (map.containsKey("empName")) {
            hql.append(" and t.dicUser.empName like :empName");
        }
        if (map.containsKey("cardNumber")) {
            hql.append(" and t.dicUser.cardNumber like :cardNumber");
        }
        if (map.containsKey("signDate") && map.containsKey("validDate")) {
            hql.append(" and t.signDate between to_date(:signDate, 'YYYY-MM-DD') and to_date(:validDate, 'YYYY-MM-DD')");
            hql.append(" and t.validDate between to_date(:signDate, 'YYYY-MM-DD') and to_date(:validDate, 'YYYY-MM-DD')");
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");

        find(carrier, hql.toString(), map);
    }

    public void loadUser(Carrier<PassportUserVo> carrier, Map<String, Object> map) {
        StringBuffer sql = new StringBuffer("SELECT u.ID AS id, (SELECT DEPT_NAME FROM SCH_DUTY.TB_DIC_DEPT where ID = u.DEPT_ID) AS deptName, u.EMP_NAME AS empName,");
        sql.append(" u.SEX AS sex, u.NATION as nation, u.BIRTHDAY AS birthday, u.BIRTHPLACE AS birthplace,");
        sql.append(" u.PHONE AS phone, u.MAIN_DUTY AS mainDuty, (SELECT NAME FROM SCH_DUTY.TB_DIC_PARAM where ID = u.RANK_ID) AS rankName, c.id as transactStatus,");
        sql.append(" u.CREATE_DATE AS createDate");

        sql.append(" from SCH_DUTY.TB_DIC_USER u left join (SELECT ID, PEOPLE_ID from SCH_DUTY.DM_PPM_PASSPORT card where card.DEL_FLAG='0') c");
        sql.append(" on u.ID = c.PEOPLE_ID");
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
        Map<String, Object> params = new HashMap<>(1);
        hql.append(" from PrivatePassport t where t.delFlag = 0");
        if (StringUtils.isNotEmpty(userId)) {
            hql.append(" and t.dicUser.id = :userId");
            params.put("userId", userId);
        }
        List<PrivatePassport> privatePassports = find(hql.toString(), params);

        return (null == privatePassports || 0 == privatePassports.size());
    }

    public List<PrivatePassport> findPrivatePassportForExcel(String empName, String cardNumber, String signDate, String validDate) {
        Map<String, Object> params = new HashMap<>(1);
        StringBuffer hql = new StringBuffer();
        hql.append(" from PrivatePassport t where 1 = 1");
        if (StringUtils.isNotEmpty(empName)) {
            hql.append(" and t.dicUser.empName like :empName");
            params.put("empName", "%" + empName.trim() + "%");
        }
        if (StringUtils.isNotEmpty(cardNumber)) {
            hql.append(" and t.dicUser.cardNumber like :cardNumber");
            params.put("cardNumber", "%" + cardNumber.trim() + "%");
        }
        if (StringUtils.isNotEmpty(signDate) && StringUtils.isNotEmpty(validDate)) {
            hql.append(" and t.signDate between to_date(:signDate, 'YYYY-MM-DD') and to_date(:validDate, 'YYYY-MM-DD')");
            hql.append(" and t.validDate between to_date(:signDate, 'YYYY-MM-DD') and to_date(:validDate, 'YYYY-MM-DD')");
            params.put("signDate", signDate);
            params.put("validDate", validDate);
        }
        hql.append(" and t.delFlag = '0' order by t.updateTime desc ");
        List<PrivatePassport> privatePassportList = find(hql.toString(), params);
        return privatePassportList;
    }

}
