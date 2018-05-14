package rk.service;

import rk.Model.ResultInfo;
import rk.dao.UserDao;
import rk.po.WebUser;
import org.springframework.stereotype.Service;
import rk.util.AssertUtil;
import rk.util.StringUtil;

import javax.annotation.Resource;

@Service
public class UserService extends CommonService {

    @Resource
    private UserDao userDao;

    public WebUser login(WebUser user){
        AssertUtil.isTrue(StringUtil.isNullorEmpty(user.getUserPwd(),user.getUserName()),"缺少必填项!");
        WebUser has_user = userDao.queryUserByUserName(user.getUserName());
        AssertUtil.isTrue(null == has_user,"用户不存在");
        AssertUtil.isTrue(!has_user.getUserPwd().equals(StringUtil.encypt(user.getUserPwd())),"密码错误");
        has_user.setUserPwd(null);
        return has_user;
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