package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserRepository extends SMRepository<Integer, User> {
    User selectByUsername(String userUsername) throws Exception; // 필드 이름에 맞게 수정
    User findByUsername(String userUsername); // 필드 이름에 맞게 수정
    User findByTel(String userTel); // 필드 이름에 맞게 수정
    User findByEmail(String userEmail); // 필드 이름에 맞게 수정
    User findByEmailForFindId(String userEmail); // 필드 이름에 맞게 수정
}
