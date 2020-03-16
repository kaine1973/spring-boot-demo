package rk.po;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Date;
//产品

@NoArgsConstructor
@Data
public class Product {

    //数据库id
    private Integer productId;
    //用户id
    private Integer userId;
    //品牌
    private String brand = "";
    //产品id
    private String productSerial = "";
    //名称
    @NotBlank
    private String productName = "";
    //单位
    private String productUnit = "";
    //分类
    private Integer categoryId = 0;
    //型号
    private String model = "";
    //添加日期
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
    private Date createDate;

    //修改日期
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
    private Date updateDate;
    //规格，对应包含 价格、数量
    private ArrayList<String> specificationNames = new ArrayList<>();
    private ArrayList<Double> prices = new ArrayList<>();
    private ArrayList<Integer> amounts = new ArrayList<>();


}
