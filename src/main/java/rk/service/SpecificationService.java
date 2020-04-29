package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rk.base.BaseService;
import rk.dao.SpecificationDao;
import rk.po.ProductSpecification;

@Service
public class SpecificationService extends BaseService<ProductSpecification> {

    @Autowired
    private SpecificationDao specificationDao;

    public Integer deleteByIdAndUserId(Integer specificationId) {
        specificationDao.delete(specificationId);
        return null;
    }
}
