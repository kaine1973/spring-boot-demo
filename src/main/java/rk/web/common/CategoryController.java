package rk.web.common;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import rk.annotations.RequestPermission;
import rk.model.ResultInfo;
import rk.po.ProductCategory;
import rk.service.CategoryService;
import rk.util.AssertUtil;

import java.util.List;

@Controller
@RequestMapping("category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ObjectMapper objectMapper;

    @RequestPermission(aclValue = "0")
    @RequestMapping("queryAll")
    @ResponseBody
    public ResultInfo queryCategories() throws JsonProcessingException {
        //zTree会将空的children
        objectMapper.setSerializationInclusion( JsonInclude.Include.NON_EMPTY );
        List<ProductCategory> productCategories = categoryService.queryCategoryOfLevel( 0 );
        String s = objectMapper.writeValueAsString(productCategories );
        return new ResultInfo( 200,"", s);
    }

    @RequestPermission(aclValue = "1")
    @RequestMapping("addCategory")
    @ResponseBody
    public ResultInfo addCategory( ProductCategory productCategory ){
        productCategory.checkRequired();
        ProductCategory parent = categoryService.queryById( productCategory.getParentId() );
        AssertUtil.isTrue( parent==null,"不存在该父类" );
        productCategory.setLevel( parent.getLevel()+1 );
        AssertUtil.isTrue( categoryService.saveUpdate( productCategory, null )!=1,"保存失败" );
        return new ResultInfo(200,"保存成功");
    }

    @RequestPermission(aclValue = "1")
    @RequestMapping("editCategory")
    @ResponseBody
    public ResultInfo editCategory( ProductCategory productCategory ){
        productCategory.checkRequired();
        AssertUtil.isTrue( productCategory.getId() == null,"" );
        AssertUtil.isTrue( categoryService.saveUpdate( productCategory, productCategory.getId() )!=1,"保存失败" );
        return new ResultInfo(200,"修改成功");
    }

    @RequestPermission(aclValue = "1")
    @RequestMapping("deleteCategory")
    @ResponseBody
    public ResultInfo deleteCategory( Integer id ){
        AssertUtil.isTrue( id == null||id<=1,"没有选择分类，或者不能删除该分类" );
        AssertUtil.isTrue( categoryService.delete( id )!=1,"保存失败" );
        return new ResultInfo(200,"删除成功");
    }

}
