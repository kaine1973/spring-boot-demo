package rk.po;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//产品

@Data
public class Product {

    //用户id
    private Integer userId;
    //数据库id
    private Integer productId;
    //名称
    private String productName;
    //品牌
    private String brand;
    //型号
    private String model;
    //单位
    private String productUnit;
    //产品id
    private String productSerial;
    //分类
    private Integer categoryId;
    //添加日期
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
    private Date createDate;

    //修改日期
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
    private Date updateDate;
    //规格，对应包含 价格、数量
    private List<ProductSpecification> productSpecifications;

    public void setProductSpecifications(List<ProductSpecification> specifications){
        productSpecifications = new ArrayList<>();
        for(ProductSpecification specification:specifications){
            if(null == specification.getId() && 0 == specification.getIsValid()){
                continue;
            }
            productSpecifications.add( specification );
        }
    }


}
