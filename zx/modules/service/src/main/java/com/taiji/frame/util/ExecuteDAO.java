/**
 * Copyright (c) 2005-2010 springside.org.cn
 * <p/>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * <p/>
 * $Id: SimpleHibernateDao.java 1205 2010-09-09 15:12:17Z calvinxiu $
 */
package com.taiji.frame.util;

import com.google.common.base.CaseFormat;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.hibernate.*;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hibernate.metadata.ClassMetadata;
import org.hibernate.transform.ResultTransformer;
import org.hibernate.transform.Transformers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.sql.DataSource;
import java.io.Serializable;
import java.util.*;
import java.util.concurrent.TransferQueue;

/**
 * @author BT4900
 */
@Repository
@SuppressWarnings("unchecked")
public class  ExecuteDAO {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    protected SessionFactory sessionFactory;

    protected NamedParameterJdbcTemplate namedTemplate;

    protected DataSource dataSource;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        this.namedTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    public ExecuteDAO() {
    }

    /**
     * 取得当前Session.
     */
    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * 保存新增或修改的对象.
     * 保存新增时需要返回保存后的对象 以进行后续操作
     *
     * @return Object
     */
    public void save(final Class entityClass, final Object entity) {
        Assert.notNull(entity, "entity不能为空");
        logger.debug("save entity: " + entityClass.getSimpleName());
        getSession().saveOrUpdate(entity);
    }

    /**
     * 将对象从持久态转换为游离态
     *
     * @author ZS
     */
    public void objectToEvict(final Object entity) {
        getSession().evict(entity);
    }


    /**
     * 删除对象.
     *
     * @param entity 对象必须是session中的对象或含id属性的transient对象.
     */
    public void delete(final Class entityClass, final Object entity) {
        Assert.notNull(entity, "entity不能为空");
        getSession().delete(entity);
        logger.debug("delete entity: " + entityClass.getSimpleName());
    }

    /**
     * 按id删除对象.
     */
    public void delete(final Class entityClass, final Serializable id) {
        Assert.notNull(id, "id不能为空");
        delete(entityClass, get(entityClass, id));
        logger.debug("delete entity " + entityClass.getSimpleName() + "," + "id is " + id);
    }

    /**
     * 按id获取对象.
     */
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true)
    public <X> X get(final Class entityClass, final Serializable id) {
        Assert.notNull(id, "id不能为空");
        return (X) getSession().get(entityClass, id);
    }

    /**
     * 按id获取对象(查库取出).
     */
    @SuppressWarnings("unused")
    public <X> X getWithStatelessSession(final Class entityClass, final Serializable id) {
        Assert.notNull(id, "id不能为空");
        StringBuilder hql = new StringBuilder();
        hql.append("from ").append(entityClass.getName()).append(" where id=:id");
        Query query = this.getSessionFactory().openStatelessSession().createQuery(hql.toString());
        query.setEntity("id", id);
        List<X> list = query.list();
        if (list == null || list.size() == 0) {
            return null;
        } else {
            return list.get(0);
        }
    }

    /**
     * 按id列表获取对象列表.
     */
    public List get(final Class entityClass, final Collection<Serializable> ids) {
        return find(entityClass, Restrictions.in(getIdName(entityClass), ids));
    }

    /**
     * 获取全部对象.
     */
    public List getAll(final Class entityClass) {
        String hql   = "from " + entityClass.getSimpleName();
        Query  query = this.getSession().createQuery(hql);
        return query.list();
    }

    /**
     * 获取全部对象, 支持按属性行序.
     */
    public List getAll(final Class entityClass, String orderByProperty, boolean isAsc) {
        Criteria c = createCriteria(entityClass);
        if (isAsc) {
            c.addOrder(Order.asc(orderByProperty));
        } else {
            c.addOrder(Order.desc(orderByProperty));
        }
        return c.list();
    }

    /**
     * 按属性查找对象列表, 匹配方式为相等.
     */
    public List findBy(final Class entityClass, final String propertyName, final Object value) {
        Assert.hasText(propertyName, "propertyName不能为空");
        Criterion criterion = Restrictions.eq(propertyName, value);
        return find(entityClass, criterion);
    }

    /**
     * 按属性查找唯一对象, 匹配方式为相等.
     */
    public Object findUniqueBy(final Class entityClass, final String propertyName, final Object value) {
        Assert.hasText(propertyName, "propertyName不能为空");
        Criterion criterion = Restrictions.eq(propertyName, value);
        return createCriteria(entityClass, criterion).uniqueResult();
    }

    /**
     * 按SQL查询唯一对象.
     *
     * @param sql 数量可变的Sql.
     */
    public Object findObjectUnique(String sql) {
        return this.getSession().createSQLQuery(sql).uniqueResult();
    }

    /**
     * 按SQL查询列表.
     *
     * @param sql 数量可变的Sql.
     *            返回String类型集合
     */
    public List<String> findObjectList(String sql) {
        return this.getSession().createSQLQuery(sql).list();
    }


    /**
     * 按HQL查询对象列表.
     *
     * @param values 命名参数,按名称绑定.
     */
    public <X> List<X> find(final String hql, final Map<String, ?> values) {
        return createQuery(hql, values).list();
    }

    /**
     * 按HQL查询唯一对象.
     *
     * @param values 命名参数,按名称绑定.
     */
    public <X> X findUnique(final String hql, final Map<String, ?> values) {
        return (X) createQuery(hql, values).uniqueResult();
    }

    /**
     * 按SQL查询唯一对象.
     *
     * @param values 命名参数,按名称绑定.
     */
    public <X> X findUniqueSql(final String sql, final Map<String, ?> values) {
        return (X) createSqlQuery(sql, values).uniqueResult();
    }

    /**
     * 执行HQL进行批量修改/删除操作.
     *
     * @param values 命名参数,按名称绑定.
     * @return 更新记录数.
     */
    public int batchExecute(final String hql, final Map<String, ?> values) {
        return createQuery(hql, values).executeUpdate();
    }


    /**
     * 根据查询HQL与参数列表创建Query对象. 与find()函数可进行更加灵活的操作.
     *
     * @param values 命名参数,按名称绑定.
     */
    public Query createQuery(final String queryString, final Map<String, ?> values) {
        Assert.hasText(queryString, "queryString不能为空");
        Query query = getSession().createQuery(queryString);
        if (values != null) {
            query.setProperties(values);
        }
        return query;
    }

    /**
     * 根据查询 in（）和 param 等多参数hql
     * @param queryString
     * @param values
     * @return
     */
    public Query createQueryList(final String queryString,final Map<String, ?> values){
        Assert.hasText(queryString, "queryString不能为空");
        Query query = getSession().createQuery(queryString);
        if(values != null){
            Set<String> set = values.keySet();
            for(String str :set){
                 Object value = values.get(str);
                if(value instanceof  Collection)
                {
                    query.setParameterList(str,(Collection)value);
                }
                else
                {
                    query.setParameter(str,value);
                }
            }
        }
        return query;
    }

    /**
     * 根据查询 in（）和 param 等多参数sql
     * @param queryString
     * @param values
     * @return
     */
    public Query createSqlQueryList(final String queryString,final Map<String, ?> values){
        Assert.hasText(queryString, "queryString不能为空");
        Query query = getSession().createSQLQuery(queryString);
        if(values != null){
            Set<String> set = values.keySet();
            for(String str :set){
                Object value = values.get(str);
                if(value instanceof  Collection)
                {
                    query.setParameterList(str,(Collection)value);
                }
                else
                {
                    query.setParameter(str,value);
                }
            }
        }
        return query;
    }


    /**
     * 根据查询 in（）和 param 等多参数sql 到vo实体类
     * @param queryString
     * @param values
     * @return
     */
    public Query createSqlQueryListVo(final String queryString,final Map<String, ?> values,final Class obj){
        Assert.hasText(queryString, "queryString不能为空");
        Query query = getSession().createSQLQuery(queryString).addEntity(obj);
        if(values != null){
            Set<String> set = values.keySet();
            for(String str :set){
                Object value = values.get(str);
                if(value instanceof  Collection)
                {
                    query.setParameterList(str,(Collection)value);
                }
                else
                {
                    query.setParameter(str,value);
                }
            }
        }
        return query;
    }

    /**
     * 执行SQL进行批量修改/删除操作.
     *
     * @param values 数量可变的参数,按顺序绑定.
     * @return 更新记录数.
     */
    public int batchSqlExecute(final String sql, final Map<String, ?> values) {
        return createSqlQuery(sql, values).executeUpdate();
    }

    //按sql查找
    public Query createSqlQuery(final String queryString, final Map<String, ?> values) {
        Assert.hasText(queryString, "queryString不能为空");
        SQLQuery query = getSession().createSQLQuery(queryString);
        if (values != null) {
            query.setProperties(values);
        }
        return query;
    }

    /**
     * 按Criteria查询对象列表.
     *
     * @param criterions 数量可变的Criterion.
     */
    public List find(final Class entityClass, final Criterion... criterions) {
        return createCriteria(entityClass, criterions).list();
    }

    /**
     * 按Criteria查询唯一对象.
     *
     * @param criterions 数量可变的Criterion.
     */
    public Object findUnique(final Class entityClass, final Criterion... criterions) {
        return createCriteria(entityClass, criterions).uniqueResult();
    }

    /**
     * 根据Criterion条件创建Criteria. 与find()函数可进行更加灵活的操作.
     *
     * @param criterions 数量可变的Criterion.
     */
    public Criteria createCriteria(final Class entityClass, final Criterion... criterions) {
        Criteria criteria = getSession().createCriteria(entityClass);
        for (Criterion c : criterions) {
            criteria.add(c);
        }
        return criteria;
    }

    /**
     * 初始化对象. 使用load()方法得到的仅是对象Proxy, 在传到View层前需要进行初始化. 如果传入entity,
     * 则只初始化entity的直接属性,但不会初始化延迟加载的关联集合和属性. 如需初始化关联属性,需执行:
     * Hibernate.initialize(user.getRoles())，初始化User的直接属性和关联集合.
     * Hibernate.initialize
     * (user.getDescription())，初始化User的直接属性和延迟加载的Description属性.
     */
    public void initProxyObject(Object proxy) {
        Hibernate.initialize(proxy);
    }

    /**
     * Flush当前Session.
     */
    public void flush() {
        getSession().flush();
    }

    /**
     * 为Query添加distinct transformer. 预加载关联对象的HQL会引起主对象重复, 需要进行distinct处理.
     */
    public Query distinct(Query query) {
        query.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        return query;
    }

    /**
     * 为Criteria添加distinct transformer. 预加载关联对象的HQL会引起主对象重复, 需要进行distinct处理.
     */
    public Criteria distinct(Criteria criteria) {
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        return criteria;
    }

    /**
     * 取得对象的主键名.
     */
    public String getIdName(final Class entityClass) {
        ClassMetadata meta = getSessionFactory().getClassMetadata(entityClass);
        return meta.getIdentifierPropertyName();
    }

    /**
     * 判断对象的属性值在数据库内是否唯一.
     * <p/>
     * 在修改对象的情景下,如果属性新修改的值(value)等于属性原来的值(orgValue)则不作比较.
     */
    public boolean isPropertyUnique(final Class entityClass, final String propertyName, final Object newValue,
                                    final Object oldValue) {
        if (newValue == null || newValue.equals(oldValue)) {
            return true;
        }
        Object object = findUniqueBy(entityClass, propertyName, newValue);
        return (object == null);
    }

    //-- 分页查询函数 --//

    /**
     * 分页获取全部对象.
     */
    public void find(final Class entityClass, final Carrier carrier) {
        String hql = "from " + entityClass.getSimpleName();

        hql = setPageParameterToHqlPro(hql, carrier, entityClass);
        Query query = this.getSession().createQuery(hql);
        if (carrier.isAutoCount()) {
            Map<String, Object> map = new HashMap<String, Object>();
            long totalCount = countHqlResult(hql, map);
            carrier.setTotalSize(totalCount);
        }
        setPageParameterToQuery(query, carrier);

        List result = query.list();
        carrier.setResult(result);
    }

    public <X> X findUniqueBySql(Class<X> xEntityClass,String sql, Map<String, Object> params) {
        return namedTemplate.queryForObject(sql, params,BeanPropertyRowMapper.newInstance(xEntityClass));
    }

    public <X> List<X> findAllBySql(Class<X> xEntityClass,String tableName) {
        String sql = "SELECT *  FROM " + tableName ;
        List<X>  list     = namedTemplate.query(sql, BeanPropertyRowMapper.newInstance(xEntityClass));
        return list;
    }

    public <X> List<X> findBySql(Class<X> xEntityClass,String sql,Map<String, Object> map) {
        List<X>  list     = namedTemplate.query(sql, map, BeanPropertyRowMapper.newInstance(xEntityClass));
        return list;
    }

    public <X> List<X> findBaseObjectBySql(Class<X> xEntityClass,String sql,Map<String, Object> map) {
        List<X>  list = namedTemplate.queryForList(sql,map,xEntityClass);
        return list;
    }

    public void findBySql(Class xEntityClass, Carrier carrier, String sql) {
        this.findBySql(xEntityClass, carrier, sql);
    }

    public int executeSql(String sql,final Map<String, Object> params) {
        return namedTemplate.queryForInt(sql,params);
    }

    public Map<String,Object> queryForMap(String sql,final Map<String, ?> params) {

        return namedTemplate.queryForMap(sql,params);
    }

    public void findBySql(Class xEntityClass, final Carrier carrier, String sql, final Map<String, Object> params) {
        Assert.notNull(carrier, "carrier不能为空");
        sql = setPageParameterToSql(sql, carrier);

        if (carrier.isAutoCount()) {
            long totalCount = countSqlResult(sql, params);
            carrier.setTotalSize(totalCount);
        }

        sql = getPageSql(sql,carrier);

        List result = namedTemplate.query(sql, params, BeanPropertyRowMapper.newInstance(xEntityClass));
        carrier.setResult(result);
    }

    private String setPageParameterToSql(String sql, final Carrier carrier) {
        String sidx = carrier.getSidx();
        String sord = carrier.getSord();
        if (carrier.getFilters() != null) {
            JSONObject filterObj = JSONObject.fromObject(carrier.getFilters());
            if (filterObj != null) {
                if (sql.lastIndexOf("where") > 0) {
                    sql += " and ";
                } else {
                    sql += " where ";
                }
                JSONArray array = filterObj.getJSONArray("rules");
                for (Object object : array) {
                    JSONObject paramObj = (JSONObject) object;
                    sql += paramObj.getString("field") + " like '%" + paramObj.getString("data") + "%' and ";
                }
                sql = sql.substring(0, sql.length() - 5);
            }
        }
        if (sidx != null && !sidx.equals("")) {
            if (sidx.indexOf("_") == -1) {
                sql += " order by " + sidx;
            } else {
                sql += " order by " + sidx.replace("_", "_");
            }
            if (carrier.getSord() != null && !carrier.getSord().equals("")) {
                sql += " " + sord;
            } else {
                sql += " asc";
            }
        }
        return sql;
    }

    protected Long countSqlResult(final String sql, final Map<String, Object> params) {
        String countSql = getCountSql(sql);
        Long   count    = countBySql(countSql, params);
        return count;
    }

    public Long countBySql(final String sql, final Map<String, Object> params){
        return namedTemplate.queryForObject(sql, params,Long.class);
    }

    public String getCountSql(String orgSql) {
        String fromSql = orgSql;
        //select子句与order by子句会影响count查询,进行简单的排除.
        fromSql = StringUtils.substringBefore(fromSql, "order by");

        StringBuffer sbCount = new StringBuffer();
        sbCount.append("select count(0) from (").append(fromSql).append(")");
        return sbCount.toString();
    }

    public String getPageSql(String sql,Carrier carrier) {
        StringBuffer pageSql = new StringBuffer();

        pageSql.append("select * from ( select temp.*, rownum row_id from ( ");
        pageSql.append(sql);
        pageSql.append(" ) temp where rownum <= ").append(carrier.getFirstResult() + carrier.getPageSize());
        pageSql.append(") where row_id > ").append(carrier.getFirstResult());
        return pageSql.toString();
    }

    public <X> List<X> getByNameLike(final Class entityClass, final String nameLike) {
        return this.createCriteria(entityClass).add(Restrictions.ilike("name", "%" + nameLike + "%")).list();
    }

    //根据名称，精确查询
    public <X> X getByName(final Class entityClass, final String name) {
        String              hql = "from " + entityClass.getSimpleName() + " c where c.name =:name";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", name);
        return (X) this.findUnique(hql, map);
    }

    /**
     * 一次性删除多个对象
     */
    public void delete(final Class entityClass, final Carrier carrier) throws Exception {
        JSONArray array = JSONArray.fromObject(carrier.getDelIds());
        for (Object id : array) {
            delete(entityClass, id.toString());
        }
    }

    /**
     * 按HQL分页查询.
     *
     * @param carrier 分页参数. 注意不支持其中的orderBy参数.
     * @param hql     hql语句.
     * @param values  命名参数,按名称绑定.
     */
    public void find(final Carrier carrier, String hql, final Map<String, ?> values) {
        Assert.notNull(carrier, "carrier不能为空");
        try {
            hql = setPageParameterToHql(hql, carrier);
            Query q = createQuery(hql, values);
            if (carrier.isAutoCount()) {
                long totalCount = countHqlResult(hql, values);
                carrier.setTotalSize(totalCount);
            }
            setPageParameterToQuery(q, carrier);

            List result = q.list();
            carrier.setResult(result);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 按HQL（不分页）查询
     * @param carrier
     * @param hql
     * @param values
     */
    public void findNoPg(final Carrier carrier, String hql, final Map<String, ?> values) {
        Assert.notNull(carrier, "carrier不能为空");
        try {
            hql = setPageParameterToHql(hql, carrier);
            Query q = createQuery(hql, values);
            if (carrier.isAutoCount()) {
                long totalCount = countHqlResult(hql, values);
                carrier.setTotalSize(totalCount);
            }
            List result = q.list();
            carrier.setResult(result);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 设置分页参数到Query对象,辅助函数.
     */
    protected Query setPageParameterToQuery(final Query q, final Carrier carrier) {

        Assert.isTrue(carrier.getPageSize() > 0, "Page Size must larger than zero");

        //hibernate的firstResult的序号从0开始
        q.setFirstResult(carrier.getFirstResult());
        q.setMaxResults(carrier.getPageSize());
        return q;
    }

    /**
     * 设置分页参数到hql字符串,辅助函数.
     */
    private String setPageParameterToHql(String hql, final Carrier carrier) {

        String filters = carrier.getFilters();
        String sidexm  = carrier.getSidxm();
        if (sidexm != null && sidexm.contains(carrier.getSidx())) {
            carrier.setSidx(null);
            carrier.setSord(null);
        }
        String sidx = carrier.getSidx();
        String sord = carrier.getSord();
        hql = handleFilter(hql, filters);
//        if (filters != null && !filters.equals("")) {
//            if (hql.lastIndexOf("where") > 0) {
//                hql += " and " + filters;
//            } else {
//                hql += " where " + filters;
//            }
//        }
        if (sidexm != null && !sidexm.equals("")) {
            if (hql.lastIndexOf("order by") > 0) {
                hql += "," + sidexm;
            } else {

                hql += " order by " + sidexm;
            }

        }

        if (sidx != null && !sidx.equals("")) {
            if (hql.lastIndexOf("order by") > 0) {

                if (sidx.indexOf("_") == -1) {
                    hql += "," + sidx;
                } else {
                    hql += "," + sidx.replace("_", ".");
                }

            } else {

                if (sidx.indexOf("_") == -1) {
                    hql += " order by " + sidx;
                } else {
                    hql += " order by " + sidx.replace("_", ".");
                }
            }
            if (carrier.getSord() != null && !carrier.getSord().equals("")) {
                hql += " " + sord;
            } else {
                hql += " asc";
            }
        }
        return hql;
    }

    /**
     * 设置分页参数到hql字符串,辅助函数.
     */
    private String setPageParameterToHqlPro(String hql, final Carrier carrier, Class entityClass) {
        String sidx    = carrier.getSidx();
        String sord    = carrier.getSord();
        String filters = carrier.getFilters();
        hql = handleFilterPro(hql, filters, entityClass);
        if (sidx != null && !sidx.equals("")) {
            if (sidx.indexOf("_") == -1) {
                hql += " order by " + sidx;
            } else {
                hql += " order by " + sidx.replace("_", ".");
            }
            if (carrier.getSord() != null && !carrier.getSord().equals("")) {
                hql += " " + sord;
            } else {
                hql += " asc";
            }
        }
        return hql;
    }

    private String handleFilter(String hql, String filters) {
        if (filters != null && !"".equals(filters)) {
            JSONArray array = JSONObject.fromObject(filters).getJSONArray("rules");
            if (array != null && array.size() != 0) {
                if (hql.indexOf("where") != -1) {
                    hql += " and ";
                } else {
                    hql += " where ";
                }
                for (int i = 0; i < array.size(); i++) {
                    JSONObject eachFilter = (JSONObject) array.get(0);
                    if (i == 0) {
                        hql += " " + eachFilter.getString("field") + " like '%" + eachFilter.getString("data") + "%'";
                    }
                    if (i != array.size() - 1) {
                        hql += " and ";
                    }
                }
            }
        }
        return hql;
    }

    private String handleFilterPro(String hql, String filters, Class entityClass) {
        if (null != filters && !"".equals(filters)) {
            JSONArray array = JSONObject.fromObject(filters).getJSONArray("rules");
            if (array != null && array.size() != 0) {
                if (hql.indexOf("where") != -1) {
                    hql += " and ";
                } else {
                    hql += " where ";
                }
                for (int i = 0; i < array.size(); i++) {
                    JSONObject eachFilter = (JSONObject) array.get(i);
                    String field = eachFilter.getString("field");
                    if (field.toLowerCase().indexOf("date") != -1 || field.toLowerCase().indexOf("time") != -1) {//如果有可能有日期类型的数据
                        try {
                            if (entityClass.getDeclaredField(field) != null && entityClass.getDeclaredField(field).getType() == Date.class) {
                                Date curDate = getSysTime();
                                String dateType = eachFilter.getString("data");
                                if (dateType.equals("本月")) {
                                    Date firstDayOfMonth = DateUtil.getFirstDayOfMonth(curDate);
                                    Date firstDayOfNextMonth = DateUtil.getFirstDayOfMonth(DateUtil.addMonth(curDate, 1));
                                    hql += " " + field + ">=to_date('" + DateUtil.getDateStr(firstDayOfMonth) + "','yyyy-MM-dd') and " + field + "<to_date('" + DateUtil.getDateStr(firstDayOfNextMonth) + "','yyyy-MM-dd')";
                                    if (i != array.size() - 1) {
                                        hql += " and ";
                                    }
                                } else if (dateType.equals("本年")) {
                                    Date firstDayOfYear = DateUtil.getFirstDayOfYear(Integer.parseInt(DateUtil.dateToString(curDate, "yyyy")));
                                    Date firstDayOfNextYear = DateUtil.getFirstDayOfYear(Integer.parseInt(DateUtil.dateToString(DateUtil.addYear(curDate, 1), "yyyy")));
                                    hql += " " + field + ">=to_date('" + DateUtil.getDateStr(firstDayOfYear) + "','yyyy-MM-dd') and " + field + "<to_date('" + DateUtil.getDateStr(firstDayOfNextYear) + "','yyyy-MM-dd')";
                                    if (i != array.size() - 1) {
                                        hql += " and ";
                                    }
                                } else if (dateType.indexOf("至") != -1) {
                                    String startDate = dateType.substring(0, dateType.indexOf("至")).trim();
                                    String endDate = dateType.substring(dateType.indexOf("至") + 1).trim();
                                    if (!startDate.equals("")) {
                                        hql += " " + field + ">=to_date('" + startDate + "','yyyy-MM-dd')";
                                        if (!endDate.equals("")) {
                                            hql += " and " + field + "<to_date('" + DateUtil.getDateStr(DateUtil.addDay(DateUtil.createDate(endDate), 1)) + "','yyyy-MM-dd')";
                                        }
                                    } else {
                                        hql += " " + field + "<to_date('" + DateUtil.getDateStr(DateUtil.addDay(DateUtil.createDate(endDate), 1)) + "','yyyy-MM-dd')";
                                    }
                                    if (i != array.size() - 1) {
                                        hql += " and ";
                                    }
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } else {//如果是普通类型
                        hql += " " + eachFilter.getString("field") + " like '%" + eachFilter.getString("data") + "%'";
                        if (i != array.size() - 1) {
                            hql += " and ";
                        }
                    }
                }
            }
        }
        return hql;
    }

    /**
     * 执行count查询获得本次Hql查询所能获得的对象总数.
     * <p/>
     * 本函数只能自动处理简单的hql语句,复杂的hql查询请另行编写count语句查询.
     */
    protected long countHqlResult(final String hql, final Map<String, ?> values) {
        String countHql = prepareCountHql(hql);

        try {
            Long count = findUnique(countHql, values);
            return count;
        } catch (Exception e) {
            throw new RuntimeException("hql can't be auto count, hql is:" + countHql, e);
        }
    }

    private String prepareCountHql(String orgHql) {
        String fromHql = orgHql;
        //select子句与order by子句会影响count查询,进行简单的排除.
        fromHql = "from " + StringUtils.substringAfter(fromHql, "from");
        fromHql = StringUtils.substringBefore(fromHql, "order by");

        String countHql = "select count(*) " + fromHql;
        return countHql;
    }

    /**
     * 根据查询SQL与参数列表创建Query对象.
     *按照Map格式查询出对象，并转换key从大写转换为小写
     * @param values
     *            数量可变的参数,按顺序绑定.
     */
    public Query createSqlQueryWithMapTransformer(final String queryString, final Map<String, ?> values) {
        Assert.hasText(queryString, "queryString不能为空");
        SQLQuery query = getSession().createSQLQuery(queryString);
        if (values != null) {
            query.setProperties(values);
        }
        query.setResultTransformer( new ResultTransformer() {
            @Override
            public Object transformTuple(final Object[] tuple, final String[] aliases) {
                HashMap result = new HashMap(tuple.length);

                for(int i = 0; i < tuple.length; ++i) {
                    String alias = aliases[i];
                    if(alias != null) {
                        alias = CaseFormat.UPPER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, alias);
                        result.put(alias, tuple[i]);
                    }
                }

                return result;
            }

            @Override
            public List transformList(final List list) {
                return list;
            }
        });
        return query;
    }
    /**
     * sql server select getdate()
     * @return
     */
    public Date getSysTime() {
        return (Date) getSession().createSQLQuery("select sysdate  from dual").uniqueResult();
    }

    public void clear() {
        getSession().clear();
    }

    /**
     * 取得sessionFactory.
     */
    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    /**
     * 采用@Autowired按类型注入SessionFactory, 当有多个SesionFactory的时候在子类重载本函数.
     */
    @Autowired
    public void setSessionFactory(final SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }



}