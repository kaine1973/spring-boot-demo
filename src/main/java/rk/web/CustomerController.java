package rk.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.model.ResultInfo;
import rk.po.Customer;
import rk.po.common.Area;
import rk.po.User;
import rk.po.common.CustomerLevel;
import rk.po.common.CustomerPosition;
import rk.service.CommonService;
import rk.service.CustomerService;
import rk.util.TemplateParser;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("customer")
public class CustomerController {

    @Autowired
    private FreeMarkerConfigurer configurer;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private CommonService commonService;

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("detail")
    public ResultInfo customerDetail(){
        HashMap<String, Object> params = new HashMap<>();
        List<Area> province = commonService.queryAreaByParentId( 1 );
        List<CustomerLevel> customerLevels = commonService.queryCustomerLevelById( null );
        List<CustomerPosition> customerPositions = commonService.queryCustomerPositionById( null );
        params.put( "provinces",province );
        params.put( "levels",customerLevels );
        params.put( "positions",customerPositions );
        return new ResultInfo( 200,"请求成功", TemplateParser.parseTemplate( "/customer/detail",params,configurer ) );
    }

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("uploadCustomerDetail")
    public ResultInfo addCustomer(Customer customer,@SessionAttribute("user")User user){
        customer.setUserId( user.getId() );
        customerService.saveUpdate( customer,customer.getId() );
        return new ResultInfo( 200,"请求成功");
    }

}
