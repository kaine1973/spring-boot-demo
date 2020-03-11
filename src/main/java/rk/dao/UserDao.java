package rk.dao;

import rk.po.User;

public interface UserDao{


    User queryUser(String userName);
    User queryUserById(Integer id);

    int insert(User user);

    int updateById(User user);

}
