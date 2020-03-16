package rk.query;

import lombok.Data;
import rk.base.BaseQuery;

@Data
public class ProductQuery extends BaseQuery {
    Integer userId;
    String productName;
    String brand;
    String model;
    String categoryId;
    String createDate;
    String updateDate;

}
