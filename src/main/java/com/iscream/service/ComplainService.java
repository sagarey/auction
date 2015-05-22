package com.iscream.service;

import com.iscream.dao.ComplainDao;
import com.iscream.entity.Complain;
import com.iscream.entity.Complaininfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ComplainService {

    @Resource
    private ComplainDao complainDao;

    public boolean complain(Integer userId, String type, int complainId, String content) {
        Complain complain = new Complain();
        complain.setUserId(userId);
        complain.setType(type);
        complain.setComplainId(complainId);
        complain.setContent(content);
        try {
            complainDao.save(complain);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Complaininfo> all(){
        return complainDao.getAll();
    }


    public boolean delete(int id) {
        try {
            complainDao.delete(complainDao.get(Complain.class, id));
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Complaininfo> getComplainByUser(int userId) {
        return complainDao.getComplainByUser(userId);
    }
}
