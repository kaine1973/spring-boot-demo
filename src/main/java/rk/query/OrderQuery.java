package rk.query;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import rk.base.BaseQuery;

import java.util.Date;
import java.util.List;

@Data
public class OrderQuery extends BaseQuery {

    private String productName;
    private String orderNumber;
    @DateTimeFormat(pattern = "MM-dd-yyyy-HH-mm-ss")
    private Date dateFrom;
    @DateTimeFormat(pattern = "MM-dd-yyyy-HH-mm-ss")
    private Date dateTo;
    private Integer userId;
    private List<Integer> productIds;

}
