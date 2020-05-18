package rk;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import rk.dao.CategoryDao;
import rk.po.ProductCategory;
import rk.service.ProductService;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = App.class)
public class TestSql {

    @Autowired
    ProductService productService;

    @Autowired
    CategoryDao categoryDao;

    @Test
    public void queryProductByParam() throws JsonProcessingException {
        List<ProductCategory> productCategories = categoryDao.selectCategoryOfLevel( 0 );
        String s = new ObjectMapper().writeValueAsString( productCategories );
        System.out.println(s);
    }


}
