package com.iscream.service;

import com.iscream.dao.GoodsDao;
import com.iscream.dao.UserDao;
import com.iscream.entity.Goods;
import com.iscream.entity.Goodsinfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.List;

@Service
public class GoodsService {

    @Resource
    private GoodsDao goodsDao;

    @Resource
    private UserDao userDao;

    public boolean create(String currentUser, String title, String content, int price, Timestamp deadline, String pic) {
        if (currentUser != null && !title.isEmpty() && !content.isEmpty() && !pic.isEmpty()){
            Goods goods = new Goods();
            goods.setTitle(title);
            goods.setContent(content);
            goods.setPrice(price);
            goods.setDeadline(deadline);
            goods.setPic(pic);
            goods.setStatus("check");
            try {
                goods.setUserId(userDao.getByName(currentUser).getId());
                goodsDao.save(goods);
                return true;
            }catch (Exception e){
                return false;
            }
        }
        return false;
    }

    public List<Goodsinfo> all(){
        return goodsDao.getAll();
    }

    public List<Goodsinfo> getUserAll(int userId){
        return goodsDao.getUserAll(userId);
    }

    public List<Goodsinfo> allByUserId(int userId){
        return goodsDao.getAllByUserId(userId);
    }

    public Goodsinfo get(int id){
        return (Goodsinfo)goodsDao.get(Goodsinfo.class, id);
    }

    public List<Goodsinfo> all(String status) {
        return goodsDao.getAll(status);
    }

    public boolean updateStatus(int id, String status) {
        try {
            Goods goods = (Goods)goodsDao.get(Goods.class, id);
            goods.setStatus(status);
            goodsDao.saveOrUpdate(goods);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean delete(int id) {
        try {
            goodsDao.delete(goodsDao.get(Goods.class, id));
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Goodsinfo> search(String keyword) {
        return goodsDao.queryByTitle(keyword);
    }
}
