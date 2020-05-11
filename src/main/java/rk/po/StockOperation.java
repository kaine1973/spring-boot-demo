package rk.po;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import rk.configuration.enuma.StockOperationType;
import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StockOperation {

    private Integer id;
    private Integer productId;
    private String productName;
    private String productBrand;
    private String productSerial;
    private String productUnit;
    private Integer specificationId;
    private String specificationName;
    private String userName;
    private Integer userId;
    private StockOperationType operation;
    private Integer amount;
    private BigDecimal price;
    private BigDecimal dealPrice;
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
    private Date addDate;
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
    private Date confirmDate;
    private Boolean confirmed = false;
    private Integer temp;
    public Boolean checkProperties(){
        return productId == null || specificationId == null || amount == null;
    }

    public void fillProductInfo(Product product) {
        this.productUnit = product.getProductUnit();
        this.productBrand = product.getBrand();
        this.productName = product.getProductName();
        this.productSerial = product.getProductSerial();
    }

    public void fillSpecificationInfo(ProductSpecification specification) {
        this.specificationName = specification.getSpecificationName();
        this.price = specification.getPrice();
        this.dealPrice = specification.getPrice();
    }
}
