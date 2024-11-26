package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Senior;
import edu.sm.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface UserRepository extends SMRepository<Integer, User> {
    User selectOne(Integer userId);
    List<User> findAll();
    List<Senior> selectSeniorByUserId(Integer userId);
    void update(User user) throws Exception;

    // 월별 회원 가입 통계 조회
    List<Map<String, Object>> selectMonthlySignupStats();

    // 유저 상태별 카운트 조회
    List<Map<String, Object>> selectUserStatusCount();

    // 유저별 계약 금액 조회
    List<Map<String, Object>> selectTotalContractAmountByUserId();

    // 유저별 시니어 수 조회
    List<Map<String, Object>> selectSeniorCountByUserId();

    // 계약 갱신 빈도 조회
    List<Map<String, Object>> selectContractRenewalCountByUserId();
}
