package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import rk.base.BaseService;
import rk.configuration.enuma.OperationStatus;
import rk.dao.AddressDao;
import rk.po.Customer;
import rk.po.common.Address;
import rk.util.AssertUtil;

@Service
public class CustomerService extends BaseService<Customer> {

    @Autowired
    private AddressDao addressDao;

    @Transactional
    public void saveCustomer(Customer customer, Integer userId) {
        AssertUtil.isTrue( this.saveUpdate( customer,userId ) <1, OperationStatus.processFailed );
        for(Address address:customer.getAddresses()){
            address.setCustomerId( customer.getId() );
        }
        Integer integer = addressDao.saveBatch( customer.getAddresses() );
        AssertUtil.isTrue( integer<=0, OperationStatus.processFailed );
    }
}
