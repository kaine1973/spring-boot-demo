package rk.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StockOpration {

    private Integer productId;
    private Integer specificationId;
    private Integer amount;
    private Date stateTime;
    private Date confirmTime;

}
