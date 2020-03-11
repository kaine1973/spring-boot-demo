package rk.service;

import org.json.JSONObject;
import org.springframework.stereotype.Service;
import rk.dao.ProductDao;
import rk.model.ResultInfo;
import rk.po.Product;
import rk.po.ProductCategory;
import rk.po.ProductSpecification;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ProductService {

    @Resource
    private ProductDao productDao;

    public List<ProductCategory> queryCategoryOfLevel(Integer parentId) {
        return productDao.selectCategoryOfLevel( parentId );
    }

    public Product queryProductById(Integer productId,Integer userId) {
        return productDao.queryProductById(productId,userId);
    }


    public void insertOrUpdateProduct(Product product) {
        for(int i=0;i < product.getSpecificationNames().size();i++){
            String name = product.getSpecificationNames().get( i );
            Double price = product.getPrices().get(i)==null?0:product.getPrices().get( 0 );
            Integer amount = product.getAmounts().get(i) == null?0:product.getAmounts().get(i);
            new ProductSpecification()
        }
    }
}
