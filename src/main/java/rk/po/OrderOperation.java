package rk.po;

import lombok.Data;

@Data
public class OrderOperation {

    private Integer id;
    private Integer orderId;
    private Integer operationId;

    public OrderOperation(Integer orderId, Integer operationId) {
        this.orderId = orderId;
        this.operationId = operationId;
    }
}
