package rk.dao;

import org.apache.ibatis.annotations.Select;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import rk.base.BaseDao;
import rk.po.common.Area;
import rk.po.common.CustomerLevel;
import rk.po.common.CustomerPosition;

import java.util.ArrayList;
import java.util.List;

@Component
public interface CommonDao extends BaseDao<Area> {

    List<Area> queryAreaByParentId(Integer parentId);

    List<CustomerPosition> queryCustomerPosition(Integer id);

    List<CustomerLevel> queryCustomerLevel(Integer id);

    ArrayList<String> queryPermissionByRoleId(Integer roleId);

    List<CustomerPosition> queryCustomerPositions();

    @Select( "select max(sort) from customer_position" )
    int selectMaxPositionSort();

    int addCustomerPosition(String positionName,Integer sort);

    int updateCustomerPosition(Integer id, String positionName, Integer order);

    int deleteCustomerPosition(Integer id);
}
