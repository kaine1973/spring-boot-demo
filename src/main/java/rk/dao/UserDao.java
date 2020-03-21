package rk.dao;

import org.springframework.stereotype.Component;
import rk.po.User;

@Component
public interface UserDao{


    User queryUser(String userName);
    User queryUserById(Integer id);

    int insert(User user);

    int updateById(User user);

}
