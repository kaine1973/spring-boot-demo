package rk.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import rk.annotations.RequestPermission;

@Controller
public class IndexController {

    @RequestMapping("/")
    @ResponseBody
    public ModelAndView index(){
        return new ModelAndView( "main" );
    }

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("/main")
    @ResponseBody
    public ModelAndView main(String page){
        return new ModelAndView( "main" ).addObject( "content",page );
    }

}
