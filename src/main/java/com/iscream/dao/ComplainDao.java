package com.iscream.dao;

import com.iscream.entity.Complaininfo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ComplainDao extends BaseDao{

    public List<Complaininfo> getAll() {
        return sessionFactory.getCurrentSession().createQuery("from Complaininfo").list();
    }

    public List<Complaininfo> getComplainByUser(int userId) {
        return sessionFactory.getCurrentSession().createQuery("from Complaininfo where userId = :userId").setParameter("userId", userId).list();
    }
}
