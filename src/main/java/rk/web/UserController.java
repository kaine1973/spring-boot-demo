package rk.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;
import rk.Model.ResultInfo;
import rk.po.WebUser;
import rk.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import rk.util.AssertUtil;
import rk.util.StringUtil;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "user")
public class UserController{

    @Autowired
    private UserService userService;


    @RequestMapping(value = "login",method = RequestMethod.POST)
    public ModelAndView login(String userName, String userPwd, HttpSession session){
        WebUser user = userService.login(userName, userPwd);
        session.setAttribute("userId",user.getId());
        return new ModelAndView("main").addObject("user",user);
    }

    @RequestMapping("updatePwd")
    @ResponseBody
    private ResultInfo updatePwd(String pwd, String newPwd, String newPwdRepeat, @CookieValue(value="userId",required=true) String id){
        return userService.updateUserPwd(pwd,newPwd,newPwdRepeat,id);
    }

    @RequestMapping("regist")
    public ModelAndView regist(String userName,String userPwd){
        userService.insertUser(new WebUser(0,userName,userPwd));
        return new ModelAndView("login");
    }

}
