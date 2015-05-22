package com.iscream.dao;

import com.iscream.entity.Announcement;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AnnouncementDao extends BaseDao{

    public List<Announcement> getAll(){
        return sessionFactory.getCurrentSession().createQuery("from Announcement order by createdAt desc").list();
    }
}
