package rk.po.common;

import com.fasterxml.jackson.annotation.JsonTypeInfo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import rk.po.Customer;
import rk.util.AssertUtil;

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
    private Integer isValid;
    private Integer primary;

    public void setCustomer(Customer customer) {
        this.company = customer.getCompany() +" - " + customer.getCustomerName();
    }

    public void checkRequired() {
        AssertUtil.isTrue( districtId == null,"未选择地区" );
        AssertUtil.isTrue( company == null||"".equals( company.trim() ),"未输入公司" );
        AssertUtil.isTrue( phone == null||"".equals( phone.trim() ),"未输入电话" );
        AssertUtil.isTrue( name == null||"".equals( name.trim() ),"未输入姓名" );
        AssertUtil.isTrue( detail == null||"".equals( detail.trim() ),"未输入详细地址" );

    }
}
