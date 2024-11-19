package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserRepository extends SMRepository<Integer, User> {
    User selectByUsername(String username) throws Exception;
    User findByUsername(String username);
    User findByTel(String tel);
    User findByEmail(String email);
    // 비밀번호 수정
    void updatePassword(@Param("userId") int userId, @Param("newPassword") String newPassword);
    // 사용자 상태를 inactive로 변경 (소프트 삭제)
    void deactivateUser(@Param("userId") int userId);

}
