package rk.po;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import rk.configuration.enuma.StockOperationType;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
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
    private String productUnit;
    private Integer specificationId;
    private String specificationName;
    private Integer userId;
    private StockOperationType operation;
    private Integer amount;
    private BigDecimal price;
    private BigDecimal dealPrice;
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
    private Date addDate;
    @JsonFormat(pattern = "yyyy-MM-dd hh:mm:ss", timezone = "GMT+8")
    private Date confirmDate;
    private Boolean confirmed;
    public Boolean checkProperties(){
        return productId == null || specificationId == null || amount == null;
    }

    public void fillProductInfo(Product product) {
        this.productName = product.getProductName();
    }

    public void fillSpecificationInfo(ProductSpecification specification) {
        this.specificationName = specification.getSpecificationName();
        this.price = specification.getPrice();
    }
}
