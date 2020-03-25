package rk.service;

import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import rk.base.BaseService;
import rk.dao.ProductDao;
import rk.exceptions.ParamRequestException;
import rk.model.ResultInfo;
import rk.po.Product;
import rk.po.ProductCategory;
import rk.po.ProductSpecification;
import rk.util.AssertUtil;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class ProductService extends BaseService<Product> {

    @Resource
    private ProductDao productDao;

    public List<ProductCategory> queryCategoryOfLevel(Integer parentId) {
        return productDao.selectCategoryOfLevel( parentId );
    }

    public Product queryProductById(Integer productId,Integer userId) {
        return productDao.queryById(productId,userId);
    }
    @Transactional
    public void insertOrUpdateProduct(Product product) {
        AssertUtil.isTrue( productDao.insertProduct(product)<1,"产品添加失败" );
        for(int i=0;i < product.getProductSpecifications().size();i++){
            ProductSpecification productSpecification = product.getProductSpecifications().get( i );
            String name = productSpecification.getSpecificationName();
            if("".equals( name )||null == name){
                throw new ParamRequestException( 300, "产品规格名不能为空" );
            }
            productSpecification.setProductId( product.getProductId() );
        }
        AssertUtil.isTrue( productDao.insertproductSpecifications(product.getProductSpecifications())<1,"产品规格添加失败" );
    }
}
