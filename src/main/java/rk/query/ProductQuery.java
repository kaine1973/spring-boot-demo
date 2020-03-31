package rk.query;

import lombok.Data;
import rk.base.BaseQuery;

import java.util.ArrayList;

@Data
public class ProductQuery extends BaseQuery {

    private Integer userId;
    private String productName;
    private String brand;
    private String productSerial;
    private ArrayList<Integer> categoryId;

}
