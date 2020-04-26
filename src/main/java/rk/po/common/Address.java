package rk.po.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import rk.po.Customer;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Address {

    private Integer id;

    private String province;
    private Integer provinceId;
    private String city;
    private Integer cityId;
    private String district;
    private Integer districtId;
    private String detail;

    private String company;
    private Integer customerId;
    private byte ofUser;
    private String name;
    private String phone;

    private Integer userId;

    public void setCustomer(Customer customer) {
        this.company = customer.getCompany() +" - " + customer.getCustomerName();
    }
}
