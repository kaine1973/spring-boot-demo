package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rk.base.BaseService;
import rk.configuration.enuma.StockOperationType;
import rk.dao.StockDao;
import rk.po.StockOperation;
import rk.util.AssertUtil;

import java.util.List;

@Service
public class StockService extends BaseService<StockOperation> {

    @Autowired
    StockDao stockDao;

    public List<StockOperation> queryUnconfirmedStockOperation(Integer userId, StockOperationType operationType) {
        List<StockOperation> operations = stockDao.queryUnconfirmed(userId,operationType);
        AssertUtil.isTrue(operations.size()<1,"出库单上什么都没有");
        return operations;
    }

}
