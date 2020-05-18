package rk.dao;

import org.springframework.stereotype.Component;
import rk.base.BaseDao;
import rk.po.ProductCategory;

import java.util.List;

@Component
public interface CategoryDao extends BaseDao<ProductCategory> {


    List<ProductCategory> selectCategoryOfLevel(Integer parentId);


}
