package rk.po;

import lombok.Data;

import java.util.Date;

@Data
public class Customer {

    private Integer userId;
    private Integer id;
    private String customerName;
    private Date createTime;
    private String phone;
    private byte gender;
    private Integer addressId;
    private String addressDetail;
    private Integer levelId;
    private Integer positionId;
    private String customerId;
    private String company;
    private String note;
}
