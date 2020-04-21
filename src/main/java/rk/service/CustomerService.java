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
        Integer id = this.saveUpdate( customer,userId );
        for(Address address:customer.getAddresses()){
            address.setCustomerId( id );
        }
        Integer integer = addressDao.saveBatch( customer.getAddresses() );
        AssertUtil.isTrue( integer<=0, OperationStatus.processFailed );
    }
}
