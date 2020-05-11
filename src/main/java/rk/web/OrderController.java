package rk.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.configuration.enuma.StockOperationType;
import rk.model.ResultInfo;
import rk.po.Order;
import rk.po.Product;
import rk.po.StockOperation;
import rk.po.User;
import rk.po.common.Address;
import rk.po.common.Area;
import rk.query.OrderQuery;
import rk.query.ProductQuery;
import rk.service.*;
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

    @Autowired
    private OrderService orderService;

    @Autowired
    private AddressService addressService;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private UserService userService;

    @RequestPermission(aclValue = "0")
    @ResponseBody
    @RequestMapping("insertOrUpdate")
    public ResultInfo insertOrder(Order order,String operationIds,@SessionAttribute User user) throws JsonProcessingException {

        order.checkRequired();
        order.setUserId(user.getId());
        List<Integer> ids = objectMapper.readValue( operationIds, new TypeReference<List<Integer>>() {} );
        orderService.confirmStockOut(order,ids);
        return new ResultInfo(200,"保存成功",order);
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
        String orderPage = TemplateParser.parseTemplate("order/order", params, configurer);
        return new ResultInfo( 200,"操作成功",orderPage );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("printOrderTicket")
    @ResponseBody
    public ModelAndView printOrderTicket(Integer orderId, @ModelAttribute ModelMap model){
        AssertUtil.isTrue( orderId == null,"u should provid an Id" );
        Order order = orderService.queryById(orderId);
        AssertUtil.isTrue( order == null,"we don't have this order" );
        Address senderAddress = addressService.queryById( order.getSenderAddressId());
        Address receiverAddress = addressService.queryById( order.getReceiverAddressId());
        model.addAttribute( "senderAddress",senderAddress );
        model.addAttribute( "receiverAddress",receiverAddress );
        model.addAttribute( "order",order );
        return new ModelAndView("order/ticket").addAllObjects( model );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("getHistoryPage")
    @ResponseBody
    public ResultInfo getHistoryPage(){
        PageInfo<Order> orderPageInfo = orderService.queryByParams( new OrderQuery() );
        HashMap<String, Object> params = new HashMap<>();
        params.put( "orders",orderPageInfo.getList() );
        params.put( "users",userService.queryAllUsers());
        String s = TemplateParser.parseTemplate( "/order/history", params, configurer );
        return new ResultInfo(200,"",s);
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryByParams")
    @ResponseBody
    public ResultInfo queryByParams(OrderQuery orderQuery){
        PageInfo<Order> orderPageInfo = orderService.queryByParams( orderQuery );
        return new ResultInfo(200,"",orderPageInfo);
    }

}
