package rk.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.configuration.enuma.OperationStatus;
import rk.configuration.enuma.StockOperationType;
import rk.model.ResultInfo;
import rk.po.Order;
import rk.po.StockOperation;
import rk.po.User;
import rk.po.common.Area;
import rk.service.CommonService;
import rk.service.StockService;
import rk.util.AssertUtil;
import rk.util.TemplateParser;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    private StockService stockService;

    @Autowired
    private CommonService commonService;

    @Autowired
    private FreeMarkerConfigurer configurer;

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("insert")
    public ResultInfo insertOrder(Order order){
        return null;
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("showOrderPage")
    @ResponseBody
    public ResultInfo showOrderPage(String stockOperations, @SessionAttribute User user) {
        List<StockOperation> operations = null;
        if(null == stockOperations){
            operations = stockService.queryUnconfirmedStockOperation(user.getId(), StockOperationType.STOCK_OUT);
            AssertUtil.isTrue( operations.size()==0,"购物车是空的" );
        }else{
            operations = stockService.stockOperationParser(stockOperations, user.getId());
        }
        List<Area> province = commonService.queryAreaByParentId( 1 );
        HashMap<String, Object> params = new HashMap<>();
        params.put( "provinces",province );
        params.put("stockOperations",operations);
        params.put( "user",user );
        String orderPage = TemplateParser.parseTemplate("product/order", params, configurer);
        return new ResultInfo( 200,"操作成功",orderPage );

    }


}
