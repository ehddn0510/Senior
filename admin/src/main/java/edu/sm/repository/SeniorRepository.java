package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Senior;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface SeniorRepository extends SMRepository<Integer, Senior>  {
    Senior selectOne(Integer seniorId);
    List<Senior> findAll();
}
