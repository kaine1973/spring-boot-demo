package rk.po.statistics;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class CustomerContributionMonthly {

    private String customerName;
    private String company;
    private Integer customerId;
    private BigDecimal jan;
    private BigDecimal feb;
    private BigDecimal mar;
    private BigDecimal apr;
    private BigDecimal may;
    private BigDecimal jun;
    private BigDecimal jul;
    private BigDecimal aug;
    private BigDecimal sep;
    private BigDecimal oct;
    private BigDecimal nov;
    private BigDecimal dece;

}
