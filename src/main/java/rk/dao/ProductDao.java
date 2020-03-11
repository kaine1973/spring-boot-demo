package rk.dao;

import org.apache.ibatis.annotations.Param;
import rk.po.Product;
import rk.po.ProductCategory;

import java.util.List;

public interface ProductDao {

    List<ProductCategory> selectCategoryOfLevel(Integer parentId);

    Product queryProductById(@Param( "id" ) Integer productId,@Param( "userId" ) Integer userId);


}
