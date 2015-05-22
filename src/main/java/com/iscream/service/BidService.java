package com.iscream.service;

import com.iscream.dao.BidDao;
import com.iscream.entity.Bid;
import com.iscream.entity.Bidinfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class BidService {

    @Resource
    private BidDao bidDao;

    public boolean bid(int userId, int goodsId, int offer) {
        Bid bid = new Bid();
        bid.setUserId(userId);
        bid.setGoodsId(goodsId);
        bid.setOffer(offer);
        try {
            bidDao.save(bid);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Bidinfo> getBidByGoods(int goodsId) {
        return bidDao.getBidByGoods(goodsId);
    }

    public List<Bidinfo> getBidByUser(int userId) {
        return bidDao.getBidByUser(userId);
    }
}
