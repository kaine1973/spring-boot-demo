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

import java.util.ArrayList;

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
        ArrayList<Address> newAddresses = new ArrayList<>();
        for(Address address:customer.getAddresses()){
            if(address.getId() != null){
                Address temp = addressDao.queryByIdAndUserId( address.getId(), userId );
                AssertUtil.isTrue( temp==null,"用户没有该地址" );
                AssertUtil.isTrue( ! temp.getCustomerId().equals( customer.getId() ),"客户没有该地址" );
                addressDao.update( address );
            }else{
                newAddresses.add( address );
            }
        }
        if(newAddresses.size()>0){
            AssertUtil.isTrue( addressDao.saveBatch( newAddresses ) != newAddresses.size(), OperationStatus.processFailed );
        }
    }
}
