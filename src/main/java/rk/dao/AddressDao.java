package rk.dao;

import org.springframework.stereotype.Component;
import rk.base.BaseDao;
import rk.po.common.Address;

import java.util.List;

@Component
public interface AddressDao extends BaseDao<Address> {

    List<Address> queryUserAddresses(Integer userId);

    List<Address> queryByCustomerIdAndUserId(Integer customerId, Integer id);
}
