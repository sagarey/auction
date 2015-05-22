package com.iscream.dao;

import com.iscream.entity.Bidinfo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BidDao extends BaseDao {

    public List<Bidinfo> getBidByGoods(int goodsId) {
        return sessionFactory.getCurrentSession().createQuery("from Bidinfo where goodsId = :goodsId order by createdAt").setParameter("goodsId", goodsId).list();
    }

    public List<Bidinfo> getBidByUser(int userId) {
        return sessionFactory.getCurrentSession().createQuery("from Bidinfo where userId = :userId order by createdAt").setParameter("userId", userId).list();
    }
}
