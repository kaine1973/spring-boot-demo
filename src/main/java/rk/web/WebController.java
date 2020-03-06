package rk.web;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.freemarker.FreeMarkerAutoConfiguration;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@RestController
public class WebController {

    @Autowired
    FreeMarkerConfigurer configurer;

    @RequestMapping("dashboard")
    public String dashboard(HttpServletRequest request) throws IOException, TemplateException {
        Template template = configurer.getConfiguration().getTemplate( "/dashboard.ftl" );
        String s = FreeMarkerTemplateUtils.processTemplateIntoString( template, request );
        return s;
    }
    @RequestMapping("chartChartjs")
    public String chartChartjs(HttpServletRequest request) throws IOException, TemplateException {

        Template template = configurer.getConfiguration().getTemplate( "/chart-chartjs.ftl" );
        String s = FreeMarkerTemplateUtils.processTemplateIntoString( template, request );
        return s;
    }
}
