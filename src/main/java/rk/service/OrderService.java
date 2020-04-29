package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import rk.base.BaseService;
import rk.configuration.enuma.OperationStatus;
import rk.configuration.enuma.StockOperationType;
import rk.dao.OrderDao;
import rk.dao.StockDao;
import rk.po.Order;
import rk.po.StockOperation;
import rk.po.User;
import rk.util.AssertUtil;

import java.util.List;


@Service
public class OrderService extends BaseService<Order> {

    @Autowired
    private StockDao stockDao;

    @Autowired
    private OrderDao orderDao;

    @Transactional
    public void confirmStockOut(Order order, List<Integer> ids) {
        AssertUtil.isTrue( orderDao.queryByOrderNumber(order.getOrderNumber()).size()>0,"已经存在该订单号" );
        AssertUtil.isTrue( stockDao.confirmStockOperations(ids) != ids.size(), OperationStatus.processFailed );
        order.setOrderOperations(ids);
        AssertUtil.isTrue( orderDao.save( order )!=1,OperationStatus.processFailed );
        AssertUtil.isTrue( orderDao.saveOrderOperations(order.getOrderOperations())!=ids.size(),OperationStatus.processFailed );
    }

}
