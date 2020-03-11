package rk.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import rk.annotations.RequestPermission;
import rk.model.ResultInfo;
import rk.po.Product;
import rk.po.ProductSpecification;
import rk.po.User;
import rk.service.ProductService;
import rk.util.TemplateParser;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Controller
@RequestMapping("product")
public class ProductController {

    @Autowired
    private FreeMarkerConfigurer configurer;

    @Autowired
    private ProductService productService;

    @RequestPermission(aclValue = "0")
    @RequestMapping("getProductPage")
    @ResponseBody
    public ResultInfo productDetail(Integer productId,HttpSession session) {
        HashMap<String, Object> params = new HashMap<>();
        params.put( "categorys",productService.queryCategoryOfLevel( 0 ));
        User user = (User) session.getAttribute( "user" );
        if (productId != null){
            params.put( "product", productService.queryProductById(productId,user.getId()));
        }
        String page = TemplateParser.parseTemplate( "product/productDetail", params,configurer );
        return new ResultInfo( 200,"请求成功",page );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("insertOrUpdate")
    @ResponseBody
    public ResultInfo insertOrUpdateProduct(Product product){
        productService.insertOrUpdateProduct(product);
        return new ResultInfo( 200,"保存成功" );
    }

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryCategoryOfLevel")
    @ResponseBody
    public ResultInfo queryCategoryOfLevel(String parentId){
        int pid = 0;
        try{
            pid = Integer.parseInt( parentId );
        }catch (NumberFormatException e){
            return new ResultInfo( 300,"获取产品分类失败，parentId不正确" );
        }
        return new ResultInfo( 200,"",productService.queryCategoryOfLevel( pid ) );
    }

}
