package rk.service;

import org.json.JSONObject;
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

    public List<ProductCategory> queryCategoryOfLevel(Integer parentId) {
        List<ProductCategory> productCategories = productDao.selectCategoryOfLevel( parentId );
        for(ProductCategory productCategory:productCategories){
            setChildIds(productCategory);
        }
        return productCategories;
    }
    //获取所有子节点的ID
    private ArrayList<Integer> setChildIds(ProductCategory productCategory) {
        ArrayList<Integer> ids = new ArrayList<>();
        ids.add(productCategory.getId());
        for(ProductCategory childProductCategory:productCategory.getChildren()){
            ids.addAll( setChildIds( childProductCategory ) );
        }
        productCategory.setChildIds( ids );
        return ids;
    }

    public Product queryProductById(Integer productId,Integer userId) {
        return productDao.queryByIdAndUserId(productId,userId);
    }
    @Transactional
    public void insertOrUpdateProduct(Product product) {

        if(product.getProductId() != null) {
            AssertUtil.isTrue( productDao.deleteProductSpecifications( product.getProductId() ) < 1, "产品规格删除失败" );
        }

        AssertUtil.isTrue( this.saveUpdate( product,product.getProductId() )<1,"产品添加失败" );
        for(int i=0;i < product.getProductSpecifications().size();i++){
            ProductSpecification productSpecification = product.getProductSpecifications().get( i );
            if("".equals( productSpecification.getSpecificationName() )||null == productSpecification.getSpecificationName()){
                throw new ParamRequestException( OperationStatus.paramNotAvailable );
            }else if("".equals( productSpecification.getPrice() )||null == productSpecification.getPrice()){
                throw new ParamRequestException( OperationStatus.paramNotAvailable );
            }
            productSpecification.setProductId( product.getProductId() );
        }
        AssertUtil.isTrue( productDao.insertproductSpecifications(product.getProductSpecifications())<1,"产品规格添加失败" );
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
