package rk.po;

import lombok.Data;

@Data
public class ProductCategory {

    private int id;
    private String categoryName;
    private int parentId;

}
