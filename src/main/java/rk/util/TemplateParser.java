package rk.util;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateNotFoundException;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.exceptions.ParamRequestException;

import java.io.IOException;
import java.util.Map;

public class TemplateParser {

    public static String parseTemplate(String requestPage, Map<String,Object> params,FreeMarkerConfigurer configurer){
        String output = null;
        try {
            Template template = configurer.getConfiguration().getTemplate( requestPage+".ftl" );
            output = FreeMarkerTemplateUtils.processTemplateIntoString(template, params);
        } catch (TemplateNotFoundException e) {
            throw new ParamRequestException(404,"页面未找到");
        } catch (TemplateException | IOException e) {
            e.printStackTrace();
        }
        return output;
    }

}
