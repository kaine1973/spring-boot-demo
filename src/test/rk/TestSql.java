package rk;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import org.json.JSONObject;
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
import rk.po.ProductCategory;
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
    public void queryProductByParam() throws JsonProcessingException {
        List<ProductCategory> productCategories = productDao.selectCategoryOfLevel( 0 );
        String s = new ObjectMapper().writeValueAsString( productCategories );
        System.out.println(s);
    }


}
