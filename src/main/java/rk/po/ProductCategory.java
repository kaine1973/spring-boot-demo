package rk.po;

import com.fasterxml.jackson.annotation.JsonAlias;
import lombok.Data;

import java.util.ArrayList;

@Data
public class ProductCategory {

    private int id;
    @JsonAlias("name")
    private String categoryName;
    private int parentId;
    private ArrayList<ProductCategory> children;

}
