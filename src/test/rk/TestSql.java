package rk;

import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import rk.App;
import rk.base.BaseQuery;
import rk.dao.ProductDao;
import rk.po.Product;
import rk.po.ProductSpecification;
import rk.query.ProductQuery;
import rk.service.ProductService;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = App.class)
public class TestSql {

    @Autowired
    ProductService productService;

    @Autowired
    ProductDao productDao;

    @Test
    public void queryProductByParam(){
        ProductQuery productQuery = new ProductQuery();
        productQuery.setPageSize( 10 );
        productQuery.setPageNum( 0 );
        productQuery.setUserId( 1 );
        PageInfo<Product> productPageInfo = productService.queryByParams( productQuery );
        List<Product> list = productPageInfo.getList();
        System.out.println(list.toString());
        List<ProductSpecification> productSpecifications = productDao.queryProductSpecificationByProductId(14);
        System.out.println(productSpecifications);
    }


}
