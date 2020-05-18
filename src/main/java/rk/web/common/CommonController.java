package rk.web.common;

import com.sun.media.sound.RIFFInvalidDataException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import rk.annotations.RequestPermission;
import rk.model.ResultInfo;
import rk.po.common.Area;
import rk.po.common.CustomerPosition;
import rk.service.CommonService;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("common")
public class CommonController {
    @Autowired
    CommonService commonService;

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryAreaByParentId")
    @ResponseBody
    public ResultInfo queryAreaByParentId(Integer parentId){
        List<Area> areas = commonService.queryAreaByParentId( parentId );
        return new ResultInfo( 200,"请求成功",areas );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryAllPosition")
    @ResponseBody
    public ResultInfo queryAllPosition(){
        List<CustomerPosition> positions = commonService.queryCustomerPositions();
        return new ResultInfo(200,"",positions);
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("savePositionOrder")
    @ResponseBody
    public ResultInfo savePositionOrder(@RequestParam(value = "ids[]") List<Integer> ids){
        commonService.savePositionOrder(ids);
        return new ResultInfo(200,"");
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("addCustomerPosition")
    @ResponseBody
    public ResultInfo addCustomerPosition(String positionName){
        commonService.addCustomerPosition(positionName);
        return new ResultInfo(200,"");
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("editCustomerPosition")
    @ResponseBody
    public ResultInfo editCustomerPosition(CustomerPosition customerPosition){
        commonService.editCustomerPosition(customerPosition.getPositionName(),customerPosition.getId());
        return new ResultInfo(200,"");
    }


    @RequestPermission(aclValue = "0")
    @RequestMapping("deleteCustomerPosition")
    @ResponseBody
    public ResultInfo deleteCustomerPosition(Integer id){
        commonService.deleteCustomerPosition(id);
        return new ResultInfo(200,"");
    }
}
