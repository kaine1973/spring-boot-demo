package rk.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import rk.po.common.Address;
import rk.po.common.Invoice;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {

    private Address receiverAddress;
    private Address senderAddress;
    private Invoice invoice;
    private Integer paymentMethodId;
    private Integer deliveryMethodId;
    private String otherInfo;
    private List<StockOperation> stockOperations;
    private Date createDate;
    private Boolean isValid;
}
