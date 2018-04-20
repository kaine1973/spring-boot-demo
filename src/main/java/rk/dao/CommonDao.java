package rk.dao;

import java.util.List;

public interface CommonDao {

    int insertBatch(List<Object> ts);

    int insert(Object obj);

     int deleteBatchByIds(Integer[] ids);

     int deleteById(Integer id);

     int updateById(Object obj);

     List<Object> queryAll();

     Object queryById(Integer id);

}
