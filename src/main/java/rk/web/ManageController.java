package rk.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.po.User;
import rk.util.TemplateParser;

@Controller
@RequestMapping("/manage")
public class ManageController {

    @Autowired
    private FreeMarkerConfigurer configurer;

    @RequestPermission(aclValue = "0")
    @RequestMapping("userAddress")
    @ResponseBody
    public ModelAndView userAddress(@SessionAttribute User user){
        String content = TemplateParser.parseTemplate( "/manage/userAddress", null, configurer );
        return new ModelAndView("main").addObject( "content",content );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("productCategory")
    @ResponseBody
    public ModelAndView productCategory(@SessionAttribute User user){
        String content = TemplateParser.parseTemplate( "/manage/productCategory", null, configurer );
        return new ModelAndView("main").addObject( "content",content );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("customerLevel")
    @ResponseBody
    public ModelAndView customerLevel(@SessionAttribute User user){
        String content = TemplateParser.parseTemplate( "/manage/customerLevel", null, configurer );
        return new ModelAndView("main").addObject( "content",content );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("customerPosition")
    @ResponseBody
    public ModelAndView customerPosition(@SessionAttribute User user){
        String content = TemplateParser.parseTemplate( "/manage/customerPosition", null, configurer );
        return new ModelAndView("main").addObject( "content",content );
    }

}
