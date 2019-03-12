package com.taiji.frame.service.systempara;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.ExecuteDAO;
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
 * @author wd
 * @date 2016/4/8
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DicDeptService extends BaseDAO<DicDept> {
    private static final Logger log = LoggerFactory.getLogger(DicDeptService.class);


//    public List<DicDept> getAllByStatus(Integer status){
//        StringBuffer hql = new StringBuffer(" from DicDept d where d.status="+status+"");
//        List<DicDept> deptList = find(hql.toString());
//        return  deptList;
//    }

    /*public List<DicDept> getDeptByOrgId(String orgId){
       StringBuffer hql = new StringBuffer(" from DicDept d where d.dicOrganization.id =:orgId and d.status=0");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("orgId", orgId);
        List<DicDept> deptList = find(hql.toString(),params);
        return  deptList;
    }*/

    /*public void loadDept(Carrier<DicDept> carrier,String orgId){
        Map<String, Object> params = new HashMap<String, Object>();
        StringBuffer hql = new StringBuffer(" ");
        if(!"".equals(orgId) && null!=orgId){
            hql.append("from DicDept t where t.status=0");
            hql.append(" and t.dicOrganization.id = :orgId");
        }else{
            hql.append("from DicDept t where t.id='-10'");
        }
        params.put("orgId",orgId);
        find(carrier, hql.toString(), params);
    }*/

    /*@Transactional(rollbackFor = Exception.class)
    public void deleteDept(String id, Date date,String updName){
        DicDept dicDept = get(id);
        dicDept.setStatus(0);
        dicDept.setUpdEmp(updName);
        dicDept.setUpdDate(date);
        save(dicDept);
    }*/

    /*public List<DicDept> getDeptByLevel(Long groupLevel) {

        Map<String,Object> params = new HashMap<>();

        StringBuffer hql = new StringBuffer();
        hql.append(" from DicDept t where t.status = 1");
        if (null != groupLevel) {
            hql.append(" and t.groupLevel = :groupLevel");
            params.put("groupLevel",groupLevel);

        }
        return find(hql.toString(),params);
    }*/

    /**
     * 根据部门ID查询一个部门下所有的子部门
     * */
    /*public List<DicDept> getBelongDept(String deptCode) {

        Map<String,Object> params = new HashMap<>();
        StringBuffer sql = new StringBuffer();

        sql.append("select * from SCH_DUTY.TB_DIC_DEPT t start with t.dept_code=:deptCode");
        sql.append(" connect by prior t.dept_code=t.parent_code and t.status=1");

        params.put("deptCode",deptCode);

        return createQuerySqlListVo(sql.toString(),params,DicDept.class);
    }*/

    /**
     * 根据部门编码查询一个部门下所有的子部门
     *
     * @param deptCode 部门编码
     */
    public List<DicDept> getBelongDept(String deptCode) {

        Map<String, Object> params = new HashMap<>();
        StringBuffer sql = new StringBuffer();

        sql.append("select * from SCH_DUTY.TB_DIC_DEPT t start with t.dept_code=:deptCode");
        sql.append(" connect by prior t.dept_code=t.parent_code and t.status=1 order by t.seq");
        params.put("deptCode", deptCode);

        return createQuerySqlListVo(sql.toString(), params, DicDept.class);
    }

    /**
     * 根据部门编码查询一个部门下所有的子部门根据Id排序
     *
     * @param deptCode 部门编码
     */
    public List<DicDept> getBelongDeptOrederById(String deptCode) {

        Map<String, Object> params = new HashMap<>();
        StringBuffer sql = new StringBuffer();

        sql.append("select * from SCH_DUTY.TB_DIC_DEPT t start with t.dept_code=:deptCode");
        sql.append(" connect by prior t.dept_code=t.parent_code and t.status=1 order by t.id desc");
        params.put("deptCode", deptCode);

        return createQuerySqlListVo(sql.toString(), params, DicDept.class);
    }



    /**
     * 根据部门编码查询部门名称路径检索
     */
    public Map<String,Object> getDeptNamePath(String deptCode) {

        Map<String, Object> params = new HashMap<>(1);
        StringBuffer sql = new StringBuffer();

        sql.append(" select REPLACE(wmsys.wm_concat(t.DEPT_NAME),',','/') from ");
        sql.append(" (select o.* from SCH_DUTY.TB_DIC_DEPT o start with o.DEPT_CODE = :deptCode ");
        sql.append(" connect by prior o.PARENT_CODE = o.DEPT_CODE order by o.DEPT_CODE) t ");

        params.put("deptCode", deptCode);
        return queryForMap(sql.toString(),params);
    }

    /**
     *根据部门编码查询部门ID路径检索
     * */
    public Map<String,Object> getDeptIdPath(String deptCode) {

        Map<String,Object> params = new HashMap<>(1);
        StringBuffer sql = new StringBuffer();

        sql.append(" select REPLACE(wmsys.wm_concat(t.DEPT_CODE),',','/')  as absCode from ");
        sql.append(" (select o.* from SCH_DUTY.TB_DIC_DEPT o start with o.DEPT_CODE = :deptCode ");
        sql.append(" connect by prior o.PARENT_CODE = o.DEPT_CODE order by o.DEPT_CODE) t ");

        params.put("deptCode",deptCode);
        return queryForMap(sql.toString(),params);
    }


    public DicDept getByDeptName(String deptName) {
        StringBuffer hql = new StringBuffer(" from DicDept d where d.deptName=:deptName and d.status=1");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("deptName", deptName);
        DicDept deptList = findUnique(hql.toString(), params);
        return deptList;
    }

    public List<DicDept> getDeptByRangeAndLevel(String startId, String endId, Long groupLevel) {

        Map<String, Object> params = new HashMap<>(3);

        StringBuffer hql = new StringBuffer();
        hql.append(" from DicDept t where t.status = 1");
        if (StringUtils.isNotEmpty(startId) && StringUtils.isNotEmpty(endId) && null != groupLevel) {
            hql.append(" and t.id >= :startId and t.id <= :endId and t.groupLevel = :groupLevel");
            params.put("startId", startId);
            params.put("endId", endId);
            params.put("groupLevel", groupLevel);
        }

        return find(hql.toString(), params);
    }

    public List<DicDept> getDeptByParentCode(String parentCode) {
        Map<String, Object> params = new HashMap<>(1);
        StringBuffer hql = new StringBuffer("from DicDept t where t.status = '1'");
        if (StringUtils.isNotEmpty(parentCode)) {
            hql.append(" and t.parentCode = :parentCode");
            params.put("parentCode", parentCode);
        }
        List<DicDept> deptList = find(hql.toString(), params);
        return deptList;
    }

    public DicDept getDeptByDeptCode(String deptCode) {
        StringBuffer hql = new StringBuffer(" from DicDept d where d.deptCode=:deptCode and d.status = '1'");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("deptCode", deptCode);
        DicDept dept = findUnique(hql.toString(), params);
        return dept;
    }

    /**
     * 查询最大的部门seq
     * */
    public DicDept getMaxSeqDept() {

        StringBuffer hql = new StringBuffer();
        hql.append("from DicDept t where t.seq = (select max(seq) from DicDept)");
        return findUnique(hql.toString(),null);
    }

}