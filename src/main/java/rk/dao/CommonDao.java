package rk.dao;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import rk.base.BaseDao;
import rk.po.common.Area;
import rk.po.common.CustomerLevel;
import rk.po.common.CustomerPosition;

import java.util.List;

@Component
public interface CommonDao extends BaseDao<Area> {

    List<Area> queryAreaByParentId(Integer parentId);

    List<CustomerPosition> queryCustomerPosition(Integer id);

    List<CustomerLevel> queryCustomerLevel(Integer id);

}
