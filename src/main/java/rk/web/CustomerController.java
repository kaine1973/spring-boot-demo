package rk.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.configuration.enuma.OperationStatus;
import rk.model.ResultInfo;
import rk.po.Customer;
import rk.po.common.Address;
import rk.po.common.Area;
import rk.po.User;
import rk.po.common.CustomerLevel;
import rk.po.common.CustomerPosition;
import rk.query.CustomerQuery;
import rk.service.AddressService;
import rk.service.CommonService;
import rk.service.CustomerService;
import rk.util.AssertUtil;
import rk.util.TemplateParser;

import java.util.ArrayList;
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

    @Autowired
    private ObjectMapper objectMapper;

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
    public ResultInfo addCustomer(Customer customer,String addressesString,@SessionAttribute("user")User user) throws JsonProcessingException {
        customer.setUserId( user.getId() );
        customer.setAddresses( addressMapping( addressesString,user.getId() ) );
        customer.checkNecessaryProperty();
        customerService.saveCustomer( customer,customer.getId() );
        return new ResultInfo( 200,"请求成功");
    }

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("queryByParams")
    public ResultInfo queryAllCustomer(CustomerQuery customerQuery, @SessionAttribute("user")User user){
        customerQuery.setUserId( user.getId() );
        PageInfo<Customer> customerPageInfo = customerService.queryByParams( customerQuery );
        List<Customer> customers = customerPageInfo.getList();
        HashMap<String, Object> params = new HashMap<>();
        params.put( "pageNum",customerPageInfo.getPageNum() );
        params.put( "rows",customers );
        return new ResultInfo( 200,"请求成功",params);
    }

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("customerManager")
    public ResultInfo customerManager(){
        List<CustomerLevel> customerLevels = commonService.queryCustomerLevelById( null );
        HashMap<String, Object> params = new HashMap<>();
        params.put( "levels",customerLevels );
        String page = TemplateParser.parseTemplate( "customer/manage", params, configurer );
        return new ResultInfo( 200,"请求成功",page);
    }


    private ArrayList<Address> addressMapping(String addressJsonString,Integer userId) throws JsonProcessingException {
        ArrayList<Address> addresses = objectMapper.readValue( addressJsonString, new TypeReference<ArrayList<Address>>() {
        } );
        AssertUtil.isTrue( addresses==null||addresses.size()==0, OperationStatus.paramNotAvailable );
        for(Address address:addresses){
            address.setUserId( userId );
        }
        return addresses;
    }

}
