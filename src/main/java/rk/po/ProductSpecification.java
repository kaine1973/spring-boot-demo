package rk.po;

import lombok.AllArgsConstructor;
import lombok.Data;

//产品规格
@Data
@AllArgsConstructor
public class ProductSpecification {
    //数据库id
    private Integer id;
    //产品ID
    private Integer productId;
    //名称
    private String specificationName;
    //单价
    private Double price;
    //数量
    private Integer amount;

}
