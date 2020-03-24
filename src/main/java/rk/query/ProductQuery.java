package rk.query;

import lombok.Data;
import rk.base.BaseQuery;

import java.util.Date;

@Data
public class ProductQuery extends BaseQuery {
    private Integer userId;
    private String productName;
    private String brand;
    private String model;
    private Integer categoryId;
    private Date createDate;

}
