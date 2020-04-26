package rk.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import rk.base.BaseService;
import rk.configuration.enuma.OperationStatus;
import rk.configuration.enuma.StockOperationType;
import rk.dao.StockDao;
import rk.exceptions.ParamRequestException;
import rk.po.Product;
import rk.po.ProductSpecification;
import rk.po.StockOperation;
import rk.util.AssertUtil;

import java.util.List;

@Service
public class StockService extends BaseService<StockOperation> {

    @Autowired
    StockDao stockDao;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private ProductService productService;

    public List<StockOperation> queryUnconfirmedStockOperation(Integer userId, StockOperationType operationType) {
        return stockDao.queryUnconfirmed(userId,operationType);
    }

    @Transactional
    public List<StockOperation> stockOperationParser(String stockOperations,Integer userId){
        stockDao.deleteTemp(userId);
        List<StockOperation> operations = null;
        AssertUtil.isTrue(stockOperations == null,"参数不正确，没有获取到需要的参数");
        try {
            operations = objectMapper.readValue( stockOperations, new TypeReference<List<StockOperation>>() {
            } );
        }catch (JsonProcessingException e){
            throw new ParamRequestException( OperationStatus.paramNotAvailable );
        }
        AssertUtil.isTrue(operations.size()<1,"没有选择规格");
        for(StockOperation stockOperation:operations){
            AssertUtil.isTrue(stockOperation.checkProperties(),OperationStatus.paramNotAvailable);

            Product product = productService.queryProductById( stockOperation.getProductId(), userId );
            AssertUtil.isTrue( product==null,String.format( "产品%s不存在",stockOperation.getProductName() ));
            stockOperation.fillProductInfo(product);

            boolean specificationDoesntExists = true;
            for(ProductSpecification specification:product.getProductSpecifications()){
                if(specification.getId().equals( stockOperation.getSpecificationId() )){
                    specificationDoesntExists = false;
                    stockOperation.fillSpecificationInfo(specification);
                }
            }
            AssertUtil.isTrue( specificationDoesntExists,String.format( "产品%s不存在对应的规格:%s",product.getProductName(),stockOperation.getSpecificationName() ) );
            stockOperation.setUserId(userId);
            stockOperation.setOperation(StockOperationType.STOCK_OUT);
        }
        AssertUtil.isTrue( stockDao.saveBatch( operations )<operations.size(), OperationStatus.processFailed );
        return operations;
    }

}
