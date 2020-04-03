package rk.web;

import com.fasterxml.jackson.annotation.JsonInclude;
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
import rk.exceptions.ParamRequestException;
import rk.model.ResultInfo;
import rk.po.*;
import rk.query.ProductQuery;
import rk.service.ProductService;
import rk.util.AssertUtil;
import rk.util.TemplateParser;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

    @RequestPermission(aclValue = "1")
    @RequestMapping("insertOrUpdate")
    @ResponseBody
    public ResultInfo insertOrUpdateProduct(Product product,String specifications,@SessionAttribute User user) throws JsonProcessingException {
        product.setUserId( user.getId() );
        HashMap<String, Object> cantBeNullValues = new HashMap<>();
        cantBeNullValues.put( "产品名称",product.getProductName() );
        cantBeNullValues.put( "产品分类",product.getCategoryId() );
        cantBeNullOrEmpty( cantBeNullValues );

        List<ProductSpecification> productSpecifications = objectMapper.readValue( specifications, new TypeReference<List<ProductSpecification>>() {} );
        if(productSpecifications.size()>0) {
            product.setProductSpecifications( productSpecifications );
        }else{
            return new ResultInfo( 300,"需要至少一个产品规格" );
        }
        productService.insertOrUpdateProduct(product);
        return new ResultInfo( 200,"保存成功" );
    }

    private void cantBeNullOrEmpty(HashMap<String,Object> values){
        for(String key:values.keySet()){
            AssertUtil.isTrue(values.get( key ) == null,key+"不能为空");
            if(values.get( key ) instanceof String){
                AssertUtil.isTrue( ((String)values.get( key )).isEmpty(),key+"不能为空" );
            }
        }
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryCategory")
    @ResponseBody
    public ResultInfo queryCategories() throws JsonProcessingException {
        //zTree会将空的children
        objectMapper.setSerializationInclusion( JsonInclude.Include.NON_EMPTY );
        List<ProductCategory> productCategories = productService.queryCategoryOfLevel( 0 );
        String s = objectMapper.writeValueAsString(productCategories );
        return new ResultInfo( 200,"", s);
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("manage")
    @ResponseBody
    public ResultInfo productManage(ProductQuery productQuery, @SessionAttribute("user") User user){
//        productQuery.setUserId( user.getId() );
//        productQuery.setPageNum( 0 );
//        productQuery.setPageSize( 10 );
//        PageInfo<Product> productPageInfo = productService.queryByParams( productQuery );
        HashMap<String, Object> results = new HashMap<>();
//        results.put( "rows", productPageInfo.getList());
//        results.put( "categories",productService.queryCategoryOfLevel( 0 ) );
        return new ResultInfo(200,"请求成功",TemplateParser.parseTemplate( "/product/manage", results, configurer ));
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryByParams")
    @ResponseBody
    public ResultInfo queryByParams(ProductQuery productQuery,String categoryIdString, @SessionAttribute("user") User user) throws JsonProcessingException {
        productQuery.setUserId( user.getId() );
        if(null!=categoryIdString && !"".equals( categoryIdString )) {
            productQuery.setCategoryId( objectMapper.readValue( categoryIdString, new TypeReference<ArrayList<Integer>>() {
            } ) );
        }
        PageInfo<Product> productPageInfo = productService.queryByParams( productQuery );
        HashMap<String, Object> results = new HashMap<>();
        results.put( "pageNum",productPageInfo.getPages() );
        results.put( "rows", productPageInfo.getList());
        return new ResultInfo(200,"请求成功",results);
    }

    @RequestPermission(aclValue = "1")
    @RequestMapping("delete")
    @ResponseBody
    public ResultInfo deleteProduct(Integer productId){
        productService.deleteProduct( productId );
        return new ResultInfo( 200,"删除成功" );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryProductSpecifications")
    @ResponseBody
    public ResultInfo queryProductSpecifications(Integer productId){
        List<ProductSpecification> specifications = productService.queryProductSpecifications( productId );
        return new ResultInfo( 200,"删除成功",specifications );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("stockOut")
    @ResponseBody
    public ResultInfo stockOut(String stockOprations) {
        try {
            ArrayList<StockOpration> oprations = objectMapper.readValue( stockOprations, new TypeReference<ArrayList<StockOpration>>() {
            } );
            System.out.println(oprations);
        }catch (JsonProcessingException e){
            throw new ParamRequestException( OperationStatus.paramNotAvailable );
        }
        return new ResultInfo( 200,"操作成功" );
    }
}
