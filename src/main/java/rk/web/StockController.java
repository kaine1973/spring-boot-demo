package rk.web;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.configuration.enuma.OperationStatus;
import rk.configuration.enuma.StockOperationType;
import rk.model.ResultInfo;
import rk.po.StockOperation;
import rk.po.User;
import rk.query.StockQuery;
import rk.service.*;
import rk.util.AssertUtil;
import rk.util.TemplateParser;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("stock")
public class StockController {

    @Autowired
    private StockService stockService;

    @Autowired
    private UserService userService;

    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;

    @RequestPermission(aclValue = "0")
    @RequestMapping("insertStockOperation")
    @ResponseBody
    public ResultInfo insertStockOperation(String stockOperations, @SessionAttribute User user) {
        stockService.stockOperationParser(stockOperations, user.getId());
        return new ResultInfo( 200,"操作成功" );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("deleteStockOperation")
    @ResponseBody
    public ResultInfo deleteStockOperation(Integer operationId,@SessionAttribute User user){
        AssertUtil.isTrue( stockService.delete( operationId,user.getId() )==0,OperationStatus.processFailed );
        return new ResultInfo( 200,OperationStatus.success.OPS_MSG );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("getOutStockDetailPage")
    @ResponseBody
    public ResultInfo getOutStockDetailPage(Integer operationId,@SessionAttribute User user){
        StockOperation stockOperation = null;
        if(operationId != 0){
            stockOperation = stockService.queryByIdAndUserId( operationId,user.getId() );
        }
        HashMap<String, Object> params = new HashMap<>();
        params.put( "stockOperation",stockOperation );
        return new ResultInfo( 200,"",TemplateParser.parseTemplate( "/product/outStockDetail",params,freeMarkerConfigurer ) );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("updateStockOperation")
    @ResponseBody
    public ResultInfo updateStockOperation(StockOperation operation,@SessionAttribute User user){
        operation.setUserId( user.getId() );
        stockService.update( operation );
        return new ResultInfo( 200,"success" );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryUnconfirmedStockOperationOf{type}")
    @ResponseBody
    public ResultInfo queryAllStockOperationUnconfirmed(@PathVariable("type")String type,@SessionAttribute User user){
        List<StockOperation> stockOperations = stockService.queryUnconfirmedStockOperation( user.getId(), StockOperationType.valueOf( type ),"0" );
        return new ResultInfo( 200,"success",stockOperations );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("getStockHistoryPageOf{type}")
    @ResponseBody
    public ModelAndView getStockHistoryPage(@PathVariable String type){

        PageInfo<StockOperation> stockOperationPageInfo = stockService.queryByParams( new StockQuery(type) );
        List<StockOperation> stockOperations = stockOperationPageInfo.getList();
        List<User> users = userService.queryAllUsers();
        HashMap<String,Object> params = new HashMap<>();
        params.put( "stockOperations",stockOperations );
        params.put( "type",type );
        params.put( "users",users );
        String content = TemplateParser.parseTemplate( "/stockHistory", params, freeMarkerConfigurer );
        return new ModelAndView("main").addObject( "content",content ).addObject( "page_active",type.toLowerCase()+"_history" );

    }


    @RequestPermission(aclValue = "0")
    @RequestMapping("queryStockOf{type}")
    @ResponseBody
    public ResultInfo queryByParams(StockQuery stockQuery,@PathVariable String type){
        stockQuery.setType( type );
        PageInfo<StockOperation> pageInfo = stockService.queryByParams( stockQuery );
        return new ResultInfo( 200,"success",pageInfo );
    }
}
