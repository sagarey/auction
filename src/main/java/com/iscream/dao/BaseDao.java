package com.iscream.dao;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Transactional
public class BaseDao {

    @Resource
    protected SessionFactory sessionFactory;

    public void save(Object object) {
        sessionFactory.getCurrentSession().save(object);
    }

    public void delete(Object object) {
        sessionFactory.getCurrentSession().delete(object);
    }

    public void saveOrUpdate(Object object) {
       sessionFactory.getCurrentSession().saveOrUpdate(object);
    }

    public Object get(Class className, int id) {
        return sessionFactory.getCurrentSession().get(className, id);
    }
}
