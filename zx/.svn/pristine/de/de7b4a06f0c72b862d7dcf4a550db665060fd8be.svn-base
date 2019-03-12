package com.taiji.frame.service.systempara;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.SecRole;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by CHX on 2016/4/11.
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class SecRoleService extends BaseDAO<SecRole> {

    public void load(Carrier<SecRole> carrier,Map<String,Object> map){
        StringBuffer hql = new StringBuffer( "from SecRole t where 1=1 ");
        if(map.containsKey("roleName")){
            hql.append(" and t.roleName like:roleName");
        }
        find(carrier,hql.toString(),map);
    }

    public List<SecRole> getListByOrgId(String orgId){
        StringBuffer hql = new StringBuffer( "from SecRole t where t.dicOrganization.id=:orgId and isactive <>0");
        Map<String,Object> map = new HashMap<>();
        map.put("orgId",orgId);
        return find(hql.toString(),map);
    }

    public List<SecRole> getAllByIsactive(Integer isactive){
        StringBuffer hql = new StringBuffer(" from SecRole d where d.isactive=:isactive");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("isactive", isactive);
        List<SecRole> secRoleList = find(hql.toString(),params);
        return  secRoleList;
    }

    /**
     * 根据角色删除用户权限
     * @param roleType
     */
    public void deleteRoleWithUser(String roleType){
        String sql = "delete from TB_SEC_POP_ASS" +
                " where role_id in (select id from TB_SEC_ROLE where ROLE_TYPE =:roleType)" +
                " and POPE_ID not in (select POPE_ID from TB_SEC_ROLETYPE_RES where ROLE_TYPE =:roleType)";
        Map<String,Object> map = new HashMap<>();
        map.put("roleType", roleType);
        String sql2 ="delete from TB_SEC_POP_ASS_DEF" +
                " where role_id in (select id from TB_SEC_ROLE_DEF where ROLE_TYPE = :roleType)" +
                " and POPE_ID not in (select POPE_ID from TB_SEC_ROLETYPE_RES where ROLE_TYPE =:roleType)";
        batchSqlExecute(sql,map);
        batchSqlExecute(sql2,map);
    }
}
