package rk.service;

import rk.Model.ResultInfo;
import rk.dao.UserDao;
import rk.po.WebUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CachePut;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import rk.util.AssertUtil;
import rk.util.StringUtil;

@Service
public class UserService extends CommonService {

    @Autowired
    private UserDao userDao;


    @Autowired
    private RedisTemplate redisTemplate;


    public WebUser login(String userName, String userPwd){
        AssertUtil.isTrue(StringUtil.isNullorEmpty(userName,userPwd),"缺少必填项!");
        WebUser user = userDao.queryUserByUserName(userName);
        AssertUtil.isTrue(null == user,"用户不存在");
        AssertUtil.isTrue(!user.getUserPwd().equals(StringUtil.encypt(userPwd)),"密码错误");
        user.setUserPwd(null);
        return user;
    }

    public void insertUser(WebUser user){
        AssertUtil.isTrue(StringUtil.isNullorEmpty(user.getUserName(),user.getUserPwd()),"缺少必填项");
        AssertUtil.isTrue(userDao.queryUserByUserName(user.getUserName())!=null,"用户名已存在");
        user.setUserPwd(StringUtil.encypt(user.getUserPwd()));
        AssertUtil.isTrue(userDao.insert(user)!=1,"注册失败");
    }

    public ResultInfo updateUser(WebUser user) {
        return userDao.updateById(user)==1?success("用户信息修改成功",null):failed(300,"用户信息修改失败");
    }

    public ResultInfo updateUserPwd(String pwd, String newPwd, String newPwdRepeat, String id) {
        AssertUtil.isTrue(StringUtil.isNullorEmpty(pwd,newPwd,newPwdRepeat),"缺少必填项");
        AssertUtil.isTrue(newPwd!=newPwdRepeat,"新密码输入不一致");
        return userDao.updateById(new WebUser(Integer.valueOf(id),null,StringUtil.encypt(newPwd)))==1?new ResultInfo(200,"更新成功"):new ResultInfo(300,"更新失败");
    }
}