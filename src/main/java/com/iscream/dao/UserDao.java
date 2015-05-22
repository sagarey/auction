package com.iscream.dao;

import com.iscream.entity.User;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDao extends BaseDao {

    public User getByName(String name) {
        return (User) sessionFactory.getCurrentSession().createQuery("from User where name = :name").setParameter("name", name).list().get(0);
    }

    public List<User> getAll(String status) {
        return sessionFactory.getCurrentSession().createQuery("from User where status = :status").setParameter("status", status).list();
    }
}
