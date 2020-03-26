package rk.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

//产品规格
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductSpecification {
    //数据库id
    private Integer id;
    //产品ID
    private Integer productId;
    //名称
    private String specificationName;
    //单价
    private BigDecimal price;
    //数量
    private Integer amount;

    public ProductSpecification(String specificationName, BigDecimal price, Integer amount) {
        this.specificationName = specificationName;
        this.price = price;
        this.amount = amount;
    }
}
