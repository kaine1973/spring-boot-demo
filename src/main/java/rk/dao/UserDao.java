package rk.dao;

import rk.po.WebUser;

public interface UserDao extends CommonDao{


    WebUser queryUserByUserName(String userName);


}
