package rk.dao;

import org.apache.ibatis.annotations.Param;
import rk.po.User;

public interface UserDao{


    User queryUser(String userName);
    User queryUserById(Integer id);

    int insert(User user);

    int updateById(User user);

}
