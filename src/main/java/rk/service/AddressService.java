package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rk.base.BaseService;
import rk.dao.AddressDao;
import rk.po.common.Address;
import rk.query.AddressQuery;

import java.util.List;

@Service
public class AddressService extends BaseService<Address> {

    @Autowired
    private AddressDao addressDao;

    public List<Address> queryByCustomerId(Integer customerId, Integer id) {
        return addressDao.queryByCustomerIdAndUserId( customerId, id );
    }
}
