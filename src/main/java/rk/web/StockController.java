package rk.web;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.configuration.enuma.OperationStatus;
import rk.configuration.enuma.StockOperationType;
import rk.exceptions.ParamRequestException;
import rk.model.ResultInfo;
import rk.po.Product;
import rk.po.ProductSpecification;
import rk.po.StockOperation;
import rk.po.User;
import rk.service.ProductService;
import rk.service.StockService;
import rk.util.AssertUtil;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("stock")
public class StockController {

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private ProductService productService;

    @Autowired
    private StockService stockService;

    @Autowired
    private FreeMarkerConfigurer freeMarkerConfigurer;

    @RequestPermission(aclValue = "0")
    @RequestMapping("insertStockOperation")
    @ResponseBody
    public ResultInfo insertStockOperation(String stockOperations, @SessionAttribute User user) {
        List<StockOperation> operations = stockOperationParser(stockOperations, user.getId());
        AssertUtil.isTrue(stockService.saveBatch(operations) != operations.size(),OperationStatus.processFailed);
        return new ResultInfo( 200,"操作成功" );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryUnconfirmedStockOperationOf{type}")
    @ResponseBody
    public ResultInfo queryAllStockOutUnconfirmed(@PathVariable("type")String type,@SessionAttribute User user){
        List<StockOperation> stockOperations = stockService.queryUnconfirmedStockOperation( user.getId(), StockOperationType.valueOf( type ) );
        return new ResultInfo( 200,"success",stockOperations );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("showOrderPage")
    @ResponseBody
    public ResultInfo showOrderPage(String stockOperations, @SessionAttribute User user) {
        List<StockOperation> operations = null;
        if(null == stockOperations){
            operations = stockService.queryUnconfirmedStockOperation(user.getId(), StockOperationType.STOCK_OUT);
        }else{
            operations = stockOperationParser(stockOperations, user.getId());
            AssertUtil.isTrue(stockService.saveBatch(operations) != operations.size(),OperationStatus.processFailed);
        }
        HashMap<String, Object> params = new HashMap<>();
        params.put("operations",operations);
//        String orderPage = TemplateParser.parseTemplate("orderPage", params, freeMarkerConfigurer);
        String orderPage = operations.toString();
        return new ResultInfo( 200,"操作成功",orderPage );

    }

    public List<StockOperation> stockOperationParser(String stockOperations,Integer userId){
        List<StockOperation> oprations = null;
        AssertUtil.isTrue(stockOperations == null,"参数不正确，没有获取到需要的参数");
        try {
            oprations = objectMapper.readValue( stockOperations, new TypeReference<List<StockOperation>>() {
            } );
        }catch (JsonProcessingException e){
            throw new ParamRequestException( OperationStatus.paramNotAvailable );
        }
        AssertUtil.isTrue(oprations.size()<1,"没有选择规格");
        for(StockOperation stockOperation:oprations){
            AssertUtil.isTrue(stockOperation.checkProperties(),OperationStatus.paramNotAvailable);

            Product product = productService.queryProductById( stockOperation.getProductId(), userId );
            AssertUtil.isTrue( product==null,String.format( "产品%s不存在",stockOperation.getProductName() ));
            boolean specificationDoesntExists = true;
            for(ProductSpecification specification:product.getProductSpecifications()){
                if(specification.getId() == stockOperation.getSpecificationId()){
                    specificationDoesntExists = false;
                }
            }
            AssertUtil.isTrue( specificationDoesntExists,String.format( "产品%s不存在对应的规格:%s",product.getProductName(),stockOperation.getSpecificationName() ) );
            stockOperation.setUserId(userId);
            stockOperation.setOperation(StockOperationType.STOCK_OUT);
        }
        return oprations;
    }

}
