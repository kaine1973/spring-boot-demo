package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import rk.base.BaseService;
import rk.dao.CommonDao;
import rk.model.ResultInfo;
import rk.dao.UserDao;
import rk.po.User;
import org.springframework.stereotype.Service;
import rk.util.AssertUtil;
import rk.util.RedisUtil;
import rk.util.StringUtil;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService extends BaseService<User> {

    @Autowired
    private UserDao userDao;

    @Autowired
    private CommonDao commonDao;

    @Autowired
    private RedisUtil redisUtil;

    public ArrayList<String> getUserPermission(User user) {
//        ArrayList<String> permissions = (ArrayList<String>)redisUtil.get( "permission_" + user.getId() );
//        if(null == permissions){
        ArrayList<String> permissions = commonDao.queryPermissionByRoleId(user.getRoleId());
//            redisUtil.set( "permission_" + user.getId(),permissions );
//        }
        return permissions;
    }

    public User queryUserByName(User user){
        AssertUtil.isTrue(StringUtil.isNullorEmpty(user.getUserPwd(),user.getUserName()),"缺少必填项!");
        User has_user = userDao.queryUser(user.getUserName());
        AssertUtil.isTrue(null == has_user,"用户名或密码错误");
        AssertUtil.isTrue(!has_user.getUserPwd().equals(StringUtil.encypt(user.getUserPwd())),"用户名密码错误");
//        redisUtil.set( "pass_"+user.getId(),has_user.getUserPwd() );
        return has_user;
    }

    public ResultInfo updateUserPwd(String pwd, String newPwd, String newPwdRepeat, String id) {
        AssertUtil.isTrue(StringUtil.isNullorEmpty(pwd,newPwd,newPwdRepeat),"缺少必填项");
        AssertUtil.isTrue(newPwd!=newPwdRepeat,"新密码输入不一致");
        return userDao.updateById(new User(Integer.valueOf(id),null,StringUtil.encypt(newPwd)))==1?new ResultInfo(200,"更新成功"):new ResultInfo(300,"更新失败");
    }

    public User queryUserById(Integer id) {
        return userDao.queryUserById(id);
    }

    public List<User> queryAllUsers() {
        return userDao.queryAllUsers();
    }
}