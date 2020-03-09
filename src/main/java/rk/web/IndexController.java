package rk.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import rk.annotations.RequestPermission;
import rk.constants.CrmConstant;
import rk.model.ResultInfo;
import rk.model.UserInfo;
import rk.po.User;
import rk.service.UserService;
import rk.util.StringUtil;
import rk.util.UserIDBase64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;

@Controller
public class IndexController {

    @RequestMapping("index")
    public String index(){
        return "/index";
    }

    @RequestMapping("login")
    public String login(){
        return "login";
    }

    @Autowired
    private UserService userService;


    @ResponseBody
    @RequestMapping(value = "/user/login",method = RequestMethod.POST)
    public ResultInfo login(User user, String remember, HttpSession session){
        User login = userService.queryUserByName(user);
        session.setAttribute("user",login);
        session.setAttribute(CrmConstant.USER_PERMISSIONS, new ArrayList<>(Arrays.asList("0")));
        ResultInfo resultInfo = new ResultInfo(200, "登录成功");
        if ("true".equals(remember)) {
            resultInfo.setResult(new UserInfo(UserIDBase64.encoderUserID(login.getId()),StringUtil.encypt(UserIDBase64.encoderUserID(login.getId())+login.getSalt())));
        }
        return resultInfo;
    }
    @RequestPermission(aclValue = "0")
    @RequestMapping("main")
    public String main(){
        return "main";
    }

}
