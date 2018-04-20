package rk.web;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IndexController {

    @RequestMapping("index")
    public String index(){
        return "index";
    }
    @RequestMapping("login")
    public String login(){
        return "login";
    }
    @RequestMapping("main")
    public String main(){
        return "main";
    }
    @RequestMapping("info")
    public String info(){
        return "info";
    }
    @RequestMapping("register")
    public String register(){
        return "register";
    }

    @RequestMapping("/article/new")
    public String newArticle(){
        return "article/new";
    }



}
