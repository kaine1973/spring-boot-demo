package rk.configuration.enuma;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public enum StockOperationType {

    STOCK_OUT(1,"出库"),
    STOCK_IN(2,"入库");

    StockOperationType(Integer id,String name ){

    }

    public Integer id;
    public String name;

}
