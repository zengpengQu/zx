/**
 * Copyright (c) 2005-2010 springside.org.cn
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * 
 * $Id: SimpleHibernateDao.java 1205 2010-09-09 15:12:17Z calvinxiu $
 */
package com.taiji.frame.util;

import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.ReflectionUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author BT4900
 */
@Repository
@Scope("prototype")
@SuppressWarnings("unchecked")
public class BaseDAO<T> {


    private ExecuteDAO executeDAO;

    private final Logger logger = LoggerFactory.getLogger(getClass());

    protected Class<T> entityClass;

    public BaseDAO() {
        this.entityClass = ReflectionUtils.getSuperClassGenricType(getClass());
    }

    /**
     * 保存新增或修改的对象.
     * 保存新增时需要返回保存后的对象 以进行后续操作
     * @return T
     */
    @Transactional
    public void save(final T entity) {
        executeDAO.save(entityClass, entity);
    }

    /**
     * 删除对象.
     *
     * @param entity
     *            对象必须是session中的对象或含id属性的transient对象.
     */
    @Transactional
    public void delete(final T entity) {
        executeDAO.delete(entityClass, entity);
    }

    /**
     * 按id删除对象.
     */
    @Transactional
    public void delete(final Serializable id) {
        executeDAO.delete(entityClass, id);
    }

    /**
     * 按id获取对象.
     */

    public T get(final Serializable id) {
        return (T) executeDAO.get(entityClass, id);
    }

    /**
     * 按id列表获取对象列表.
     */
    public List<T> get(final Collection<Serializable> ids) {
        return executeDAO.get(entityClass, ids);
    }

    /**
     * 获取全部对象.
     */
    public List<T> getAll() {
        return executeDAO.getAll(entityClass);
    }

    /**
     * 获取全部对象, 支持按属性行序.
     */
    public List<T> getAll(String orderByProperty, boolean isAsc) {
        return executeDAO.getAll(entityClass, orderByProperty, isAsc);
    }

    /**
     * 按属性查找对象列表, 匹配方式为相等.
     */
    public List<T> findBy(final String propertyName, final Object value) {
        return executeDAO.findBy(entityClass, propertyName, value);
    }

    /**
     * 按属性查找唯一对象, 匹配方式为相等.
     */
    public T findUniqueBy(final String propertyName, final Object value) {
        return (T) executeDAO.findUniqueBy(entityClass, propertyName, value);
    }

    /**
     * 按SQL查询唯一对象.
     *
     * @param sql
     *            数量可变的Sql.
     */
    public Object findObjectUnique(String sql) {
        return this.executeDAO.findObjectUnique(sql);
    }

    /**
     * 按sql查找map
     * */
    public Map<String,Object> queryForMap(String sql , final Map<String, ?> values) {
        return this.executeDAO.queryForMap(sql,values);
    }

    /**
     * 按SQL查询对象列表.
     *
     * @param sql
     * 返回String类型集合
     */
    public List<String> findObjectList(String sql){
        return this.executeDAO.findObjectList(sql);
    }

    /**
     * 按Criteria查询对象列表.
     *
     * @param criterions
     *            数量可变的Criterion.
     */
    public List<T> find(final Criterion... criterions) {
        return executeDAO.find(entityClass, criterions);
    }

     /**
      * 返回Criteria对象以用Criteria进行单对象复杂查询
      *
      * @param entityClass
      * @param criterions
      * @return Criteria
      */
    public Criteria createCriteria(final Class entityClass, final Criterion... criterions) {
         return executeDAO.createCriteria(entityClass, criterions);
    }

    /**
     * 按Criteria查询对象列表.
     *
     * @param criterions
     *            数量可变的Criterion.
     */
    public  T findUnique(final Criterion... criterions) {
        return (T) executeDAO.findUnique(entityClass, criterions);
    }

    public <X> X findUnique(final String hql, final Map<String, ?> values){
        return (X) executeDAO.createQuery(hql, values).uniqueResult();
    }

    public <X> X findUniqueSql(final String hql, final Map<String, ?> values){
        return (X) executeDAO.createSqlQuery(hql, values).uniqueResult();
    }

    /**
     * 查询 in（）和 param 等多参数hql
     * @param hql
     * @param values
     * @param <X>
     * @return
     */
    public <X> List<X> createQueryList(final String hql, final Map<String, ?> values){
        return executeDAO.createQueryList(hql, values).list();
    }

    /**
     * 查询 in（）和 param 等多参数sql
     * @param sql
     * @param values
     * @param <X>
     * @return
     */
    public <X> List<X> createQuerySqlList(final String sql, final Map<String, ?> values){
        return executeDAO.createSqlQueryList(sql, values).list();
    }

    /**
     * 查询 in（）和 param 等多参数sql并映射到vo实体类上
     * @param sql
     * @param values
     * @param <X>
     * @return
     */
    public <X> List<X> createQuerySqlListVo(final String sql, final Map<String, ?> values,final Class obj){
        return executeDAO.createSqlQueryListVo(sql, values, obj).list();
    }

    /**
     * 按HQL查询对象列表.
     *
     * @param values
     *            命名参数,按名称绑定.
     */
    public <X> List<X> find(final String hql, final Map<String, ?> values) {
        return executeDAO.createQuery(hql, values).list();
    }

    /**
     * 按HQL查询对象列表.
     */
    public <X> List<X> find(final String hql) {
        Map<String, ?> values = new HashMap<String, Object>();
        return executeDAO.createQuery(hql, values).list();
    }

    /**
     * 按HQL分页查询.
     *
     * @param carrier 分页参数. 注意不支持其中的orderBy参数.
     * @param hql hql语句.
     * @param values 命名参数,按名称绑定.
     *
     * @return 分页查询结果, 附带结果列表及所有查询输入参数.
     */
    public void find(final Carrier carrier, String hql, final Map<String, ?> values) {
        executeDAO.find(carrier, hql, values);
    }

    /**
     * 按SQL分页查询。
     *
     * @param xEntityClass 实体类
     * @param carrier      分页参数. 注意不支持其中的orderBy参数.
     * @param sql          sql语句
     * @param params       命名参数,按名称绑定.
     * */
    public void findBySql(Class xEntityClass, final Carrier carrier, String sql, final Map<String, Object> params) {

        executeDAO.findBySql(xEntityClass,carrier,sql,params);
    }

    /**
     * 按SQL（不分页）查询
     * @param xEntityClass 实体类
     * @param sql sql语句
     * @param map values
     *
     * @return list
     * */
    public <X> List<X> findBySql(Class<X> xEntityClass,String sql,Map<String, Object> map) {
        return executeDAO.findBySql(xEntityClass,sql,map);
    }

    /**
     * 按HQL（不分页）查询
     * @param carrier
     * @param hql
     * @param values
     */
    public void findNoPg(final Carrier carrier, String hql, final Map<String, ?> values) {
        executeDAO.findNoPg(carrier, hql, values);
    }

    /**
     * 执行HQL进行批量修改/删除操作.
     *
     * @param values
     *            命名参数,按名称绑定.
     * @return 更新记录数.
     */
    public int batchExecute(final String hql, final Map<String, ?> values) {
        return executeDAO.batchExecute(hql, values);
    }


    /**
     * 执行SQL进行批量修改/删除操作.
     *
     * @param values
     *            命名参数,按名称绑定.
     * @return 更新记录数.
     */
    public int batchSqlExecute(final String hql, final Map<String, ?> values) {
        return executeDAO.batchSqlExecute(hql, values);
    }

    /**
     * 执行查询sql
     * @return int
     * */
    public int executeSql(final String sql, final Map<String, Object> params) {
        return executeDAO.executeSql(sql, params);
    }

    /**
     * 取得对象的主键名.
     */
    public String getIdName() {
        return executeDAO.getIdName(entityClass);
    }

    public void flush() {
        this.executeDAO.flush();
    }

    public List<T> getByNameLike(String nameLike) {
        return executeDAO.getByNameLike(entityClass, nameLike);
    }

    //根据名称，精确查询
    public <X> X getByName(String name) {
        return (X) executeDAO.getByName(entityClass, name);
    }

    /**
     * 判断对象的属性值在数据库内是否唯一.
     *
     * 在修改对象的情景下,如果属性新修改的值(value)等于属性原来的值(orgValue)则不作比较.
     */
    public boolean isPropertyUnique(final String propertyName, final Object newValue, final Object oldValue) {
        return executeDAO.isPropertyUnique(entityClass, propertyName, newValue, oldValue);
    }

    public void clear(){executeDAO.clear();}

    public Class<T> getEntityClass() {
        return entityClass;
    }

    public void setEntityClass(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    @Autowired
    public void setExecuteDAO(ExecuteDAO executeDAO) {
        this.executeDAO = executeDAO;
    }
}