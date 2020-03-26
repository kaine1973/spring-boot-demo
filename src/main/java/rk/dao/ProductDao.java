package rk.dao;

import rk.base.BaseDao;
import rk.po.Product;
import rk.po.ProductCategory;
import rk.po.ProductSpecification;

import java.util.List;

public interface ProductDao extends BaseDao<Product> {

    List<ProductCategory> selectCategoryOfLevel(Integer parentId);

    List<ProductSpecification> queryProductSpecificationByProductId(Integer productId);

    Integer insertProduct(Product product);

    Integer insertproductSpecifications(List<ProductSpecification> productSpecifications);

    Integer deleteProductSpecifications(Integer productId);
}
