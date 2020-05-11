package rk.dao;

import org.springframework.stereotype.Component;
import rk.po.statistics.CustomerContributionMonthly;

import java.util.List;

@Component
public interface StatisticsDao {
    List<CustomerContributionMonthly> queryCustomerContributionByYear(String year);
}
