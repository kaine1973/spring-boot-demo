package rk.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import rk.annotations.RequestPermission;

@Controller
public class IndexController {

    @RequestPermission(aclValue = "0")
    @RequestMapping("/")
    public String index(){
        return "/main";
    }

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("/main")
    public String main(){
        return "main";
    }

}
