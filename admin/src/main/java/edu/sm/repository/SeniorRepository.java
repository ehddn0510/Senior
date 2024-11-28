package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.HealthInfo;
import edu.sm.model.Senior;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface SeniorRepository extends SMRepository<Integer, Senior> {

    Senior selectOne(Integer seniorId);

    List<Senior> findAll();

    void update(Senior senior) throws Exception;

    List<HealthInfo> findHealthInfoBySeniorId(Integer seniorId);

    Map<String, Object> findRecentContractInfoBySeniorId(Integer seniorId);

    Long selectTotalContractAmountByseniorId(Integer seniorId);

    Long selectContractRenewalCountByseniorId(Integer seniorId);

    List<Map<String, Object>> getRegionWisePersonCount();

    List<Map<String, Object>> getSeniorAgeGroupDistribution();
}
