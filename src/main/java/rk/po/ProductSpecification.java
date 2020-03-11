package rk.po;

import lombok.Data;

//产品规格
@Data
public class ProductSpecification {
    //数据库id
    private Integer id;
    //名称
    private String specificationName;
    //数量
    private Integer amount;
    //单价
    private Integer price;

}
