package rk.dao;

import org.springframework.stereotype.Component;
import rk.base.BaseDao;
import rk.configuration.enuma.StockOperationType;
import rk.po.StockOperation;

import java.util.List;

@Component
public interface StockDao extends BaseDao<StockOperation> {
    List<StockOperation> queryUnconfirmed(Integer userId, StockOperationType operationType,String temp);

    void deleteTemp(Integer userId);

    Integer confirmStockOperations(List<Integer> ids);

    List<StockOperation> queryUnconfirmedTemp(Integer userId, StockOperationType operationType);
}
