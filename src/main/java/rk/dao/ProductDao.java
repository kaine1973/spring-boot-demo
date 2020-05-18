package rk.dao;

import rk.base.BaseDao;
import rk.po.Product;
import rk.po.ProductSpecification;

import java.util.List;

public interface ProductDao extends BaseDao<Product> {

    List<ProductSpecification> queryProductSpecificationByProductId(Integer productId);

    Integer deleteProductSpecifications(Integer productId);
}
