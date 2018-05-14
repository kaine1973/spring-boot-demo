package rk.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import rk.po.WebUser;

public interface UserDao{


    @Select("select u.* from web_user u where userName = #{userName }")
    WebUser queryUserByUserName(@Param("userName") String userName);

    int insert(WebUser user);

    int updateById(WebUser user);
}
