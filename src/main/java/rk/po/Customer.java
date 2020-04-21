package rk.po;

import lombok.Data;
import rk.po.common.Address;
import rk.util.AssertUtil;

import java.util.ArrayList;
import java.util.Date;

@Data
public class Customer {

    private Integer userId;
    private Integer id;
    private String customerName;
    private Date createTime;
    private String phone;
    private byte gender;
    private Integer levelId;
    private String levelSign;
    private Integer positionId;
    private String customerId;
    private String company;
    private String note;
    private ArrayList<Address> addresses;

    public void checkNecessaryProperty() {
        AssertUtil.isTrue( customerName == null || "".equals( customerName ),"参数有误，客户名必填" );
    }
}
