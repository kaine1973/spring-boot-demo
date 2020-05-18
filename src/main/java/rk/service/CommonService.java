package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import rk.dao.CommonDao;
import rk.po.common.Area;
import rk.po.common.CustomerLevel;
import rk.po.common.CustomerPosition;
import rk.util.AssertUtil;

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

    public List<CustomerPosition> queryCustomerPositions() {
        return commonDao.queryCustomerPositions();
    }

    @Transactional
    public void savePositionOrder(List<Integer> ids) {
        for(int i = 0;i < ids.size();i++){
            AssertUtil.isTrue( commonDao.updateCustomerPosition(ids.get( i ),null,i)!=1,"保存顺序失败" );
        }
    }

    public void addCustomerPosition(String positionName){
        int sort = commonDao.selectMaxPositionSort();
        AssertUtil.isTrue( commonDao.addCustomerPosition(positionName,sort+1)!=1,"添加失败" );
    }

    public void editCustomerPosition(String positionName,Integer id) {
        AssertUtil.isTrue( commonDao.updateCustomerPosition(id,positionName,null)!=1,"添加失败" );
    }


    public void deleteCustomerPosition(Integer id) {
        AssertUtil.isTrue( commonDao.deleteCustomerPosition(id)!=1,"添加失败" );
    }
}
