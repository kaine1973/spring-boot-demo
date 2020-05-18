package rk.query;

import lombok.Data;

@Data
public class AddressQuery extends rk.base.BaseQuery {

    private Integer ofUser;
    private Integer userId;

}
