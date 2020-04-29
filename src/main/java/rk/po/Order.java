package rk.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import rk.po.common.Address;
import rk.util.AssertUtil;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {

    private Integer id;
    private String orderNumber;
    private Integer receiverAddressId;
    private Address receiverAddress;
    private Integer senderAddressId;
    private Address senderAddress;
    private Integer customerId;
    private Customer customer;
    private Date createDate;
    private Boolean isValid;
    private Integer userId;
    private List<StockOperation> stockOperations;
    private List<OrderOperation> orderOperations;

    public void setOrderOperations(List<Integer> operationIds) {
        orderOperations = new ArrayList<>();
        for(Integer id:operationIds){
            orderOperations.add( new OrderOperation(this.id,id) );
        }
    }

    public List<OrderOperation> getOrderOperations() {
        AssertUtil.isTrue( id == null,"订单ID为空" );
        for(OrderOperation orderOperation:orderOperations){
            orderOperation.setOrderId( id );
        }
        return orderOperations;
    }

    public void checkRequired() {
        AssertUtil.isTrue( receiverAddressId == null || customerId == null,"未选择客户/收货人" );
        AssertUtil.isTrue( senderAddressId == null ,"未选择发货人" );

        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        if(this.orderNumber == null){
            this.orderNumber = "SJ"+df.format(new Date());
        }else{
            this.orderNumber = this.orderNumber.replaceAll( " ","" );
            if("".equals( this.orderNumber )){
                this.orderNumber = "SJ"+df.format(new Date());
            }
        }
    }
}
