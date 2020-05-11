package rk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import rk.dao.StatisticsDao;
import rk.po.statistics.CustomerContributionMonthly;

import java.util.List;

@Service
public class StatisticsService {

    @Autowired
    private StatisticsDao statisticsDao;

    public List<CustomerContributionMonthly> queryCustomerContributionByYear(String year) {
        return statisticsDao.queryCustomerContributionByYear(year);
    }
}
