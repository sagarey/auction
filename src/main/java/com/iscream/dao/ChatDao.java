package com.iscream.dao;

import com.iscream.entity.Chatinfo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ChatDao extends BaseDao{

    public List<Chatinfo> getAll(){
        return sessionFactory.getCurrentSession().createQuery("from Chatinfo order by createdAt").list();
    }
}
