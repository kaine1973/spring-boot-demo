package rk.dao;

import org.springframework.stereotype.Component;
import rk.base.BaseDao;
import rk.po.User;
import rk.po.common.Address;

import java.util.List;

@Component
public interface UserDao extends BaseDao<User> {


    User queryUser(String userName);
    User queryUserById(Integer id);

    int insert(User user);

    int updateById(User user);

    List<User> queryAllUsers();
}
