package rk.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.model.ResultInfo;
import rk.po.statistics.CustomerContributionMonthly;
import rk.service.StatisticsService;
import rk.util.TemplateParser;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/statistics")
public class StatisticsController {

    @Autowired
    private StatisticsService statisticService;

    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;

    @ResponseBody
    @RequestPermission(aclValue = "0")
    @RequestMapping("customerContribution")
    public ModelAndView getCustomerContributionPage(){
        List<CustomerContributionMonthly> contributions = statisticService.queryCustomerContributionByYear(new SimpleDateFormat("yyyy").format( new Date() ));
        HashMap<String,Object> params = new HashMap<>();
        params.put( "contributions",contributions );
        String content = TemplateParser.parseTemplate( "customerContribution", params, freeMarkerConfigurer );
        return new ModelAndView("main").addObject( "content",content ).addObject( "page_active","statistics_contribution" );

    }



}
