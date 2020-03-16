package rk.dao;

import org.apache.ibatis.annotations.Param;
import rk.base.BaseDao;
import rk.po.Product;
import rk.po.ProductCategory;
import rk.po.ProductSpecification;

import java.util.ArrayList;
import java.util.List;

public interface ProductDao extends BaseDao<Product> {

    List<ProductCategory> selectCategoryOfLevel(Integer parentId);

    Integer insertProduct(Product product);

    Integer insertproductSpecifications(ArrayList<ProductSpecification> productSpecifications);
}
