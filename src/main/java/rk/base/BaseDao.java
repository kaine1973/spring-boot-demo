package rk.base;

import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * Created by lp on 2018/1/3.
 */
@Component
public interface BaseDao<T> {
    /**
     * 添加记录
     * @param entity
     * @return
     * @throws DataAccessException
     */
    Integer save(T entity) throws DataAccessException;

    /**
     * 批量添加记录
     * @param entities
     * @return
     * @throws DataAccessException
     */
    Integer saveBatch(List<T> entities) throws  DataAccessException;

    /**
     * 查询单条记录
     * @param id
     * @return
     * @throws DataAccessException
     */
    T queryById(Integer id) throws  DataAccessException;

    /**
     * 查询单条记录，根据userID和ID
     * @param productId
     * @return
     * @throws DataAccessException
     */
    T queryByIdAndUserId(@Param("id") Integer productId, @Param("userId") Integer userId) throws  DataAccessException;

    /**
     * 多条件查询
     * @param baseQuery
     * @return
     * @throws DataAccessException
     */
    List<T> queryByParams(BaseQuery baseQuery) throws  DataAccessException;


    /**
     * 更新单条记录
     * @param entity
     * @return
     * @throws DataAccessException
     */
    Integer update(T entity) throws DataAccessException;


    /**
     * 批量更新记录
     * @param map
     * @return
     * @throws DataAccessException
     */
    Integer updateBatch(Map map) throws  DataAccessException;


    /**
     * 删除单条记录
     * @param id
     * @return
     * @throws DataAccessException
     */
    Integer delete(Integer id) throws  DataAccessException;

    /**
     * 批量删除记录
     * @param ids
     * @return
     * @throws DataAccessException
     */
    Integer deleteBatch(Integer[] ids) throws  DataAccessException;


    Integer deleteByIdAndUserId(Integer specificationId, Integer userId);
}
