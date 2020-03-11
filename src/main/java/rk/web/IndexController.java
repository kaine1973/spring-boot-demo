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

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;

@Controller
public class IndexController {

    @RequestPermission(aclValue = "0")
    @RequestMapping("/")
    public String index(){
        return "/main";
    }

    @RequestMapping("login")
    public String login(){
        return "login";
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("main")
    public String main(){
        return "main";
    }

}
