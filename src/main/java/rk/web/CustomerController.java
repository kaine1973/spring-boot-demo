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
import org.springframework.web.servlet.ModelAndView;
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

    @Autowired
    private AddressService addressService;

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("detail")
    public ModelAndView customerDetail(Integer customerId,@SessionAttribute User user){
        HashMap<String, Object> params = new HashMap<>();
        if(null != customerId){
            Customer customer = customerService.queryByIdAndUserId( customerId,user.getId() );
            List<Address> addresses = addressService.queryByCustomerId( customer.getId(), user.getId() );
            AssertUtil.isTrue( addresses.size()<1,"数据库错误，客户地址个数为0" );
            customer.setAddresses( addresses );
            params.put( "customer",customer );
            Address primaryAddress = null;
            for(Address address:addresses){
                if(address.getPrimary() == 1){
                    primaryAddress = address;
                }
            }
            if(primaryAddress == null){
                primaryAddress = addresses.get( 0 );
            }
            params.put( "cities",commonService.queryAreaByParentId( primaryAddress.getProvinceId() ) );
            params.put( "districts",commonService.queryAreaByParentId( primaryAddress.getCityId() ) );
            params.put( "primaryAddress",primaryAddress );
        }
        List<Area> province = commonService.queryAreaByParentId( 1 );
        params.put( "provinces",province );


        List<CustomerLevel> customerLevels = commonService.queryCustomerLevelById( null );
        List<CustomerPosition> customerPositions = commonService.queryCustomerPositionById( null );
        params.put( "levels",customerLevels );
        params.put( "positions",customerPositions );
        String content = TemplateParser.parseTemplate( "/customer/detail", params, configurer );
        return new ModelAndView("main").addObject( "content",content ).addObject( "page_active","customer_detail" );
    }

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("uploadCustomerDetail")
    public ResultInfo addCustomer(Customer customer,String addressesString,@SessionAttribute("user")User user) throws JsonProcessingException {

        customer.checkNecessaryProperty();
        customer.setUserId( user.getId() );
        ArrayList<Address> addresses = addressMapping( addressesString, user.getId() );
        customer.setAddresses( addresses );
        customerService.saveCustomer( customer,customer.getId() );
        return new ResultInfo( 200,"请求成功");
    }

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("queryByParams")
    public ResultInfo queryAllCustomer(CustomerQuery customerQuery, @SessionAttribute("user")User user){
        customerQuery.setUserId( user.getId() );
        PageInfo<Customer> customerPageInfo = customerService.queryByParams( customerQuery );
        return new ResultInfo( 200,"请求成功",customerPageInfo);
    }

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("customerManager")
    public ModelAndView customerManager(){
        List<CustomerLevel> customerLevels = commonService.queryCustomerLevelById( null );
        HashMap<String, Object> params = new HashMap<>();
        params.put( "levels",customerLevels );
        String content = TemplateParser.parseTemplate( "customer/manage", params, configurer );
        return new ModelAndView("main").addObject( "content",content ).addObject( "page_active","customer_manage" );
    }


    private ArrayList<Address> addressMapping(String addressJsonString,Integer userId) throws JsonProcessingException {
        ArrayList<Address> addresses = objectMapper.readValue( addressJsonString, new TypeReference<ArrayList<Address>>() {
        } );
        AssertUtil.isTrue( addresses==null||addresses.size()==0, OperationStatus.paramNotAvailable );
        for(Address address:addresses){
            if(address.getIsValid()!=null && address.getIsValid() != 0){
                address.checkRequired();
            }
            address.setUserId( userId );
        }
        return addresses;
    }

}
