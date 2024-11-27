package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Careworker;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CareworkerRepository extends SMRepository<Integer, Careworker> {
    Careworker selectByUsername(String username) throws Exception;
    Careworker selectByTel(String tel) throws Exception;
    Careworker selectByEmail(String email) throws Exception;
    List<Careworker> selectNearbyCareworkers(Double latitude, Double longitude, Double radius) throws Exception;
}
