package rk.po;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
//产品

@NoArgsConstructor
@Data
public class Product {

    //数据库id
    private Integer productId;
    //品牌
    private String brand;
    //产品id
    private String productSerial;
    //名称
    @NotBlank
    private String productName;
    //单位
    private String productUnit;
    private String category;
    //型号
    private String model;
    //规格，对应包含 价格、数量
    private ArrayList<String> specificationNames;
    private ArrayList<Double> prices;
    private ArrayList<Integer> amounts;


}
