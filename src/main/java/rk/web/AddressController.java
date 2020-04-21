package rk.web;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.model.ResultInfo;
import rk.po.User;
import rk.po.common.Address;
import rk.po.common.Area;
import rk.service.AddressService;
import rk.service.CommonService;
import rk.service.CustomerService;
import rk.util.TemplateParser;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("address")
public class AddressController {

    @Autowired
    private CommonService commonService;

    @Autowired
    private AddressService addressService;

    @Autowired
    public CustomerService customerService;

    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("getAddressPage")
    public ResultInfo getAddressPage(Integer addressId, @SessionAttribute("user") User user){
        Address address = null;
        if(null != addressId){
            address = addressService.queryById(addressId);
        }
        HashMap<String, Object> params = new HashMap<>();
        if(null != address){
            params.put( "address",address );
            List<Area> provinces = commonService.queryAreaByParentId( address.getProvinceId() );
            List<Area> cities = commonService.queryAreaByParentId( address.getCityId() );
            List<Area> districts = commonService.queryAreaByParentId( address.getDistrictId() );
            params.put( "provinces",provinces );
            params.put( "cities",cities );
            params.put( "districts",districts );
        }else{
            List<Area> provinces = commonService.queryAreaByParentId( 1 );
            params.put( "provinces",provinces );
        }
        String s = TemplateParser.parseTemplate( "/customer/addressDetail", params, freeMarkerConfigurer );
        return new ResultInfo( 200,"请求成功",s );
    }

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("showAddressQueryPage")
    public ResultInfo showAddressQueryPage(){
        String s = TemplateParser.parseTemplate( "/selectAddress",null, freeMarkerConfigurer );
        return new ResultInfo( 200,"",s );
    }

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("queryAddressByCustomerId")
    public ResultInfo queryAddressByCustomerId(Integer customerId,@SessionAttribute User user){
        List<Address> addresses = addressService.queryByCustomerId( customerId, user.getId() );
        return new ResultInfo( 200,"",addresses );
    }
}
