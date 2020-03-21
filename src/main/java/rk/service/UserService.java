package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import rk.model.ResultInfo;
import rk.dao.UserDao;
import rk.po.User;
import org.springframework.stereotype.Service;
import rk.util.AssertUtil;
import rk.util.StringUtil;

@Service
public class UserService{

    @Autowired
    private UserDao userDao;

    public User queryUserByName(User user){
        AssertUtil.isTrue(StringUtil.isNullorEmpty(user.getUserPwd(),user.getUserName()),"缺少必填项!");
        User has_user = userDao.queryUser(user.getUserName());
        AssertUtil.isTrue(null == has_user,"用户名或密码错误");
        AssertUtil.isTrue(!has_user.getUserPwd().equals(StringUtil.encypt(user.getUserPwd())),"用户名密码错误");
        return has_user;
    }

//    public void insertUser(User user){
//        AssertUtil.isTrue(StringUtil.isNullorEmpty(user.getUserName(),user.getUserPwd()),"缺少必填项");
//        AssertUtil.isTrue(userDao.queryUser(user.getUserName())!=null,"用户名已存在");
//        user.setUserPwd(StringUtil.encypt(user.getUserPwd()));
//        AssertUtil.isTrue(userDao.insert(user)!=1,"注册失败");
//    }

    public ResultInfo updateUserPwd(String pwd, String newPwd, String newPwdRepeat, String id) {
        AssertUtil.isTrue(StringUtil.isNullorEmpty(pwd,newPwd,newPwdRepeat),"缺少必填项");
        AssertUtil.isTrue(newPwd!=newPwdRepeat,"新密码输入不一致");
        return userDao.updateById(new User(Integer.valueOf(id),null,StringUtil.encypt(newPwd)))==1?new ResultInfo(200,"更新成功"):new ResultInfo(300,"更新失败");
    }

    public User queryUserById(Integer id) {
        return userDao.queryUserById(id);
    }
}