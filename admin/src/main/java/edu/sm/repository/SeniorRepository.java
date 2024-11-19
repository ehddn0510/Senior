package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.HealthInfo;
import edu.sm.model.Senior;
import edu.sm.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface SeniorRepository extends SMRepository<Integer, Senior>  {
    Senior selectOne(Integer seniorId);
    List<Senior> findAll();
    void update(Senior senior) throws Exception;
    List<HealthInfo>  findHealthInfoBySeniorId(Integer seniorId);
}
