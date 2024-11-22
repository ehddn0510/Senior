package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Careworker;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface CareworkerRepository extends SMRepository<Integer, Careworker> {
    Careworker selectByUsername(String username) throws Exception;
    Careworker selectByTel(String tel);
    Careworker selectByEmail(String email);
}
