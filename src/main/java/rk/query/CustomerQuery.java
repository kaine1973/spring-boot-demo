package rk.query;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import rk.base.BaseQuery;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomerQuery extends BaseQuery {
    private String queryName;
    private String queryCompany;
    private Integer queryLevel;
    private Integer userId;
}
