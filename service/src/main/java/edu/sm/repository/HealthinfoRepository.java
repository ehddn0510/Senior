package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Careworker;
import edu.sm.model.HealthInfo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface HealthinfoRepository extends SMRepository<Integer, HealthInfo> {
    List<HealthInfo> findHealthInfoBySeniorId(Integer seniorId);
}
