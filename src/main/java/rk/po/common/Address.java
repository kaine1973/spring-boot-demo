package rk.po.common;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
    private String ofUser;
    private String name;
    private String phone;

    private Integer userId;

}
