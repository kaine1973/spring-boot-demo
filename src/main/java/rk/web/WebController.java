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

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
public class WebController {

    @Autowired
    FreeMarkerConfigurer configurer;

    @RequestPermission(aclValue = "0")
    @RequestMapping("/staticWeb")
    @ResponseBody
    public ResultInfo staticWebController(HttpServletRequest request, String requestPage) {
        String s = null;
        try {
            Template template = configurer.getConfiguration().getTemplate( requestPage+".ftl" );
            s = FreeMarkerTemplateUtils.processTemplateIntoString(template, request);
        } catch (TemplateNotFoundException e) {
            throw new ParamRequestException(404,"页面未找到");
        } catch (TemplateException | IOException e) {
            e.printStackTrace();
        }
        return new ResultInfo(200,"页面请求成功",s);
    }

}
