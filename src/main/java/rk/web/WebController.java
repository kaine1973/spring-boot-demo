package rk.web;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.exceptions.ParamRequestException;
import rk.model.ResultInfo;
import rk.util.TemplateParser;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;

@Controller
public class WebController {

    @Autowired
    FreeMarkerConfigurer configurer;

    @RequestPermission(aclValue = "0")
    @RequestMapping("/staticWeb")
    @ResponseBody
    public ResultInfo staticWebController(String requestPage) {
        return new ResultInfo(200,"页面请求成功", TemplateParser.parseTemplate(requestPage,null,configurer));
    }

}
