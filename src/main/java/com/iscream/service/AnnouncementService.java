package com.iscream.service;

import com.iscream.dao.AnnouncementDao;
import com.iscream.entity.Announcement;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AnnouncementService {

    @Resource
    private AnnouncementDao announcementDao;


    public boolean announcement(String title, String content) {
        Announcement announcement = new Announcement();
        announcement.setTitle(title);
        announcement.setContent(content);
        try {
            announcementDao.save(announcement);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean delete(int id) {
        try {
            announcementDao.delete(announcementDao.get(Announcement.class, id));
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Announcement> getAll(){
        return announcementDao.getAll();
    }
}
