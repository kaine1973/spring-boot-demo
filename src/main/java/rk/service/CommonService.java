package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rk.dao.CommonDao;
import rk.po.common.Area;
import rk.po.common.CustomerLevel;
import rk.po.common.CustomerPosition;

import java.util.List;

@Service
public class CommonService{

    @Autowired
    private CommonDao commonDao;

    public List<CustomerLevel> queryCustomerLevelById(Integer id){
        return commonDao.queryCustomerLevel( id );
    }

    public List<CustomerPosition> queryCustomerPositionById(Integer id){
        return commonDao.queryCustomerPosition( id );
    }

    public List<Area> queryAreaByParentId(Integer parentId){
        return commonDao.queryAreaByParentId( parentId );
    }

}
