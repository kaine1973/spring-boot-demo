package rk.service;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import rk.base.BaseService;
import rk.configuration.enuma.OperationStatus;
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

    @Autowired
    private SpecificationService specificationService;

    public Product queryProductById(Integer productId) {
        return productDao.queryById(productId);
    }
    @Transactional
    public void insertOrUpdateProduct(Product product) {

        AssertUtil.isTrue( this.saveUpdate( product,product.getProductId() )<1,"产品添加失败" );
        for(ProductSpecification specification:product.getProductSpecifications()){
            specification.setProductId( product.getProductId() );
            AssertUtil.isTrue( specificationService.saveUpdate( specification,specification.getId() )<1,"保存产品分类失败" );
        }
    }

    @Transactional
    public void deleteProduct(Integer productId) {
        this.delete( productId );
        AssertUtil.isTrue( productDao.deleteProductSpecifications( productId )<1,"删除失败" );
    }

    public List<ProductSpecification> queryProductSpecifications(Integer productId) {
        return productDao.queryProductSpecificationByProductId( productId );
    }

}
