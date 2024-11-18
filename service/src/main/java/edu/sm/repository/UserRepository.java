package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserRepository extends SMRepository<Integer, User> {
    User findByUsername(String username);
    User findByTel(String tel);
    User findByEmail(String email);
    // 회원 정보 수정
    void updateUserInfo(User user);

    // 비밀번호 수정
    void updatePassword(@Param("userId") int userId, @Param("newPassword") String newPassword);

    // 계정 비활성화 (소프트 삭제)
    void deactivateUser(int userId);
}
