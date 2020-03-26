package rk.web;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import jdk.nashorn.internal.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.model.ResultInfo;
import rk.po.Product;
import rk.po.ProductSpecification;
import rk.po.User;
import rk.query.ProductQuery;
import rk.service.ProductService;
import rk.util.AssertUtil;
import rk.util.TemplateParser;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("product")
public class ProductController {

    @Autowired
    private FreeMarkerConfigurer configurer;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private ProductService productService;

    @RequestPermission(aclValue = "0")
    @RequestMapping("getProductPage")
    @ResponseBody
    public ResultInfo productDetail(Integer productId,HttpSession session) {
        User user = (User)session.getAttribute( "user" );
        HashMap<String, Object> params = new HashMap<>();
        params.put( "categories",productService.queryCategoryOfLevel( 0 ));
        if (productId != null){
            params.put( "product", productService.queryProductById(productId,user.getId()));
        }
        String page = TemplateParser.parseTemplate( "product/detail", params,configurer );
        return new ResultInfo( 200,"请求成功",page );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("insertOrUpdate")
    @ResponseBody
    public ResultInfo insertOrUpdateProduct(Product product,String specifications,@SessionAttribute User user) throws JsonProcessingException {
        product.setUserId( user.getId() );
        AssertUtil.isTrue( "".equals( product.getProductName() ),"产品名称不能为空" );
        List<ProductSpecification> productSpecifications = objectMapper.readValue( specifications, new TypeReference<List<ProductSpecification>>() {} );
        if(productSpecifications.size()>0) {
            product.setProductSpecifications( productSpecifications );
        }else{
            return new ResultInfo( 300,"需要至少一个产品规格" );
        }
        productService.insertOrUpdateProduct(product);
        return new ResultInfo( 200,"保存成功" );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryCategoryOfLevel")
    @ResponseBody
    public ResultInfo queryCategoryOfLevel(Integer parentId){
//        int pid = 0;
//        try{
//            pid = Integer.parseInt( parentId );
//        }catch (NumberFormatException e){
//            return new ResultInfo( 300,"获取产品分类失败，parentId不正确" );
//        }
        return new ResultInfo( 200,"",productService.queryCategoryOfLevel( parentId ) );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("manage")
    @ResponseBody
    public ResultInfo productManage(ProductQuery productQuery, @SessionAttribute("user") User user){
        productQuery.setUserId( user.getId() );
        productQuery.setPageNum( 0 );
        productQuery.setPageSize( 10 );
        PageInfo<Product> productPageInfo = productService.queryByParams( productQuery );
        HashMap<String, Object> results = new HashMap<>();
        results.put( "rows", productPageInfo.getList());
        results.put( "categories",productService.queryCategoryOfLevel( 0 ) );
        return new ResultInfo(200,"请求成功",TemplateParser.parseTemplate( "/product/manage", results, configurer ));
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryByParams")
    @ResponseBody
    public ResultInfo queryByParams(ProductQuery productQuery, @SessionAttribute("user") User user){
        productQuery.setUserId( user.getId() );
        PageInfo<Product> productPageInfo = productService.queryByParams( productQuery );
        HashMap<String, Object> results = new HashMap<>();
        results.put( "rows", productPageInfo.getList());
        results.put( "categories",productService.queryCategoryOfLevel( 0 ) );
        return new ResultInfo(200,"请求成功",results);
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("delete")
    @ResponseBody
    public ResultInfo deleteProduct(Integer productId){
        productService.deleteProduct( productId );
        return new ResultInfo( 200,"删除成功" );
    }

}
