package com.iscream.dao;

import com.iscream.entity.Commentinfo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommentDao extends BaseDao{
    public List<Commentinfo> getCommentByGoods(int goodsId) {
        return sessionFactory.getCurrentSession().createQuery("from Commentinfo where goodsId = :goodsId order by createdAt").setParameter("goodsId", goodsId).list();
    }

    public List<Commentinfo> getCommentByUser(int userId) {
        return sessionFactory.getCurrentSession().createQuery("from Commentinfo where userId = :userId order by createdAt").setParameter("userId", userId).list();
    }
}
