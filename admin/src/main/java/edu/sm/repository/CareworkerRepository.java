package edu.sm.repository;

import edu.sm.frame.SMRepository;
import edu.sm.model.Careworker;
import edu.sm.model.License;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CareworkerRepository extends SMRepository<Integer, Careworker> {
    Careworker selectByUsername(String cwUsername) throws Exception;
    void update(Careworker careworker) throws Exception;
    Careworker selectOne(Integer userId);
    List<Careworker> findAll();
    // 보호사 ID로 상세 정보 조회
    Careworker selectById(Integer cwId) throws Exception;

    // 보호사 ID로 자격증 목록 조회
    List<License> selectLicensesByCareworkerId(Integer cwId) throws Exception;

    // 보호사 상태를 waiting -> active로 업데이트
    void updateStatusToActive(Integer cwId) throws Exception;
}
