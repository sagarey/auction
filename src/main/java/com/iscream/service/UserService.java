package com.iscream.service;

import com.iscream.dao.UserDao;
import com.iscream.entity.User;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserService {

    @Resource
    private UserDao userDao;

    public boolean signup(String name, String email, String password, String repassword) {
        if (!name.isEmpty() && !email.isEmpty() && !password.isEmpty() && (password.equals(repassword))) {
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setStatus("normal");
            try {
                userDao.save(user);
                return true;
            } catch (Exception e) {
//                e.printStackTrace();
                return false;
            }
        } else {
            return false;
        }
    }

    public boolean login(String name, String password) {
        try {
            return userDao.getByName(name).getPassword().equals(password);
        } catch (Exception e) {
            return false;
        }
    }

    public int getId(String name) {
        return userDao.getByName(name).getId();
    }

    public User get(int id) {
        return (User)userDao.get(User.class,id);
    }

    public boolean updatePassword(int id, String password) {
        try {
            User user = (User)userDao.get(User.class, id);
            user.setPassword(password);
            userDao.saveOrUpdate(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean updateStatus(int id, String status) {
        try {
            User user = (User)userDao.get(User.class, id);
            user.setStatus(status);
            userDao.saveOrUpdate(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public Object all(String status) {
        return userDao.getAll(status);
    }
}
