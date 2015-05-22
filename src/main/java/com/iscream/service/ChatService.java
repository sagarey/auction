package com.iscream.service;

import com.iscream.dao.ChatDao;
import com.iscream.dao.UserDao;
import com.iscream.entity.Chat;
import com.iscream.entity.Chatinfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service
public class ChatService {

    @Resource
    private ChatDao chatDao;

    @Resource
    private UserDao userDao;

    public boolean chat(String currentUser, String content) {
        if (currentUser != null && !content.isEmpty()) {
            Chat chat = new Chat();
            chat.setContent(content);
            try {
                chat.setUserId(userDao.getByName(currentUser).getId());
                chatDao.save(chat);
                return true;
            } catch (Exception e) {
                return false;
            }
        } else {
            return false;
        }
    }

    public List<Chatinfo> getAll(){
        return chatDao.getAll();
    }
}
