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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.model.ResultInfo;
import rk.po.*;
import rk.query.ProductQuery;
import rk.service.CategoryService;
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

    @Autowired
    private CategoryService categoryService;

    @RequestPermission(aclValue = "0")
    @RequestMapping("getProductPage")
    @ResponseBody
    public ModelAndView productDetail(Integer productId, @SessionAttribute User user) {
        HashMap<String, Object> params = new HashMap<>();
        params.put( "categories",categoryService.queryCategoryOfLevel( 0 ));
        if (productId != null){
            params.put( "product", productService.queryProductById(productId));
        }
        String content = TemplateParser.parseTemplate( "product/detail", params,configurer );
        return new ModelAndView( "main" ).addObject( "content",content ).addObject( "page_active","product_detail" );
    }

    @RequestPermission(aclValue = "1")
    @RequestMapping("insertOrUpdate")
    @ResponseBody
    public ResultInfo insertOrUpdateProduct(Product product,String specifications) throws JsonProcessingException {
        HashMap<String, Object> cantBeNullValues = new HashMap<>();
        cantBeNullValues.put( "产品名称",product.getProductName() );
        cantBeNullValues.put( "产品分类",product.getCategoryId() );
        cantBeNullOrEmpty( cantBeNullValues );

        List<ProductSpecification> productSpecifications = objectMapper.readValue( specifications, new TypeReference<List<ProductSpecification>>() {} );
        product.setProductSpecifications( productSpecifications );
        AssertUtil.isTrue(product.getProductSpecifications().size()<1,"需要至少一个产品规格");
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
    @RequestMapping("manage")
    @ResponseBody
    public ModelAndView productManage(ProductQuery productQuery, @SessionAttribute("user") User user){
//        productQuery.setUserId( user.getId() );
//        productQuery.setPageNum( 0 );
//        productQuery.setPageSize( 10 );
//        PageInfo<Product> productPageInfo = productService.queryByParams( productQuery );
        HashMap<String, Object> results = new HashMap<>();
//        results.put( "rows", productPageInfo.getList());
//        results.put( "categories",productService.queryCategoryOfLevel( 0 ) );
        String content = TemplateParser.parseTemplate( "/product/manage", results, configurer );
        return new ModelAndView("main").addObject( "content",content ).addObject( "page_active","product_manage" );
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
        return new ResultInfo(200,"请求成功",productPageInfo);
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

}
