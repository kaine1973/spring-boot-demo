package rk.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import rk.configuration.enuma.StockOperationType;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StockOperation {

    private Integer id;
    private Integer productId;
    private String productName;
    private Integer specificationId;
    private String specificationName;
    private Integer userId;
    private StockOperationType operation;
    private Integer amount;
    private Date addDate;
    private Date confirmDate;
    private Boolean confirmed;

    public Boolean checkProperties(){
        return productId == null || specificationId == null || amount == null;
    }

}
