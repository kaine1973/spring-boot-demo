package rk.query;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import rk.base.BaseQuery;
import java.util.Date;

@Data
public class StockQuery extends BaseQuery {


    @DateTimeFormat(pattern = "MM-dd-yyyy-HH-mm-ss")
    @JsonFormat(pattern = "MM-dd-yyyy-hh-mm-ss", timezone = "GMT+8")
    private Date startDate;
    @DateTimeFormat(pattern = "MM-dd-yyyy-HH-mm-ss")
    @JsonFormat(pattern = "MM-dd-yyyy-hh-mm-ss", timezone = "GMT+8")
    private Date endDate = new Date();
    private String productLike;
    private Integer userId;
    private String type;

    public StockQuery(String type){
        this.type = type;
    }

}
