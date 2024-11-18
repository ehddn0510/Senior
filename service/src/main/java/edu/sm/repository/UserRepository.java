package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface UserRepository extends SMRepository<Integer, User> {
    User selectByUsername(String username) throws Exception;
    User findByUsername(String username);
    User findByTel(String tel);
    User findByEmail(String email);
}
