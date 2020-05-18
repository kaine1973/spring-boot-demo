package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rk.base.BaseService;
import rk.dao.CategoryDao;
import rk.po.ProductCategory;

import java.util.ArrayList;
import java.util.List;

@Service
public class CategoryService extends BaseService<ProductCategory> {

    @Autowired
    private CategoryDao categoryDao;


    public List<ProductCategory> queryCategoryOfLevel(Integer parentId) {
        List<ProductCategory> productCategories = categoryDao.selectCategoryOfLevel( parentId );
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




}
