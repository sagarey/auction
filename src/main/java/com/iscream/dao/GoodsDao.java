package com.iscream.dao;

import com.iscream.entity.Goods;
import com.iscream.entity.Goodsinfo;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Repository
public class GoodsDao extends BaseDao{

    public List<Goodsinfo> getAll(){
        return sessionFactory.getCurrentSession().createQuery("from Goodsinfo").list();
    }

    public List<Goodsinfo> getUserAll(int userId){
        return sessionFactory.getCurrentSession().createQuery("from Goodsinfo where userId = :userId").setParameter("userId", userId).list();
    }

    public List<Goodsinfo> getAllByUserId(int userId){
        Date date = new Date();
        Timestamp now = new Timestamp(date.getTime());
        return sessionFactory.getCurrentSession().createQuery("from Goodsinfo where status = :status and userId = :userId and userStatus = :userStatus and deadline > :now").setParameter("status", "normal").setParameter("userId", userId).setParameter("userStatus", "normal").setParameter("now", now).list();
    }

    public List<Goodsinfo> getAll(String status) {
        Date date = new Date();
        Timestamp now = new Timestamp(date.getTime());
        return sessionFactory.getCurrentSession().createQuery("from Goodsinfo where status = :status and userStatus = :userStatus and deadline > :now").setParameter("status", status).setParameter("userStatus", "normal").setParameter("now", now).list();
    }

    public List<Goodsinfo> queryByTitle(String keyword) {
        Date date = new Date();
        Timestamp now = new Timestamp(date.getTime());
        return sessionFactory.getCurrentSession().createQuery("from Goodsinfo where title like :keyword and status = :status and userStatus = :userStatus and deadline > :now").setParameter("status", "normal").setParameter("userStatus", "normal").setParameter("now", now).setParameter("keyword", "%" + keyword + "%").list();
    }
}
