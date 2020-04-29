package rk.dao;

import org.springframework.stereotype.Component;
import rk.base.BaseDao;
import rk.po.Order;
import rk.po.OrderOperation;

import java.util.List;

@Component
public interface OrderDao extends BaseDao<Order> {
    int saveOrderOperations(List<OrderOperation> orderOperations);

    List<Order> queryByOrderNumber(String orderNumber);
}
