package com.iscream.service;

import com.iscream.dao.CommentDao;
import com.iscream.entity.Comment;
import com.iscream.entity.Commentinfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentService {

    @Resource
    private CommentDao commentDao;

    public boolean comment(Integer userId, int goodsId, String content) {
        Comment comment = new Comment();
        comment.setUserId(userId);
        comment.setGoodsId(goodsId);
        comment.setContent(content);
        try {
            commentDao.save(comment);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Commentinfo> getCommentByGoods(int goodsId) {
        return commentDao.getCommentByGoods(goodsId);
    }

    public List<Commentinfo> getCommentByUser(int userId) {
        return commentDao.getCommentByUser(userId);
    }
}
