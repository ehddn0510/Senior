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
    Careworker selectByUsername(String cwUsername);
    void update(Careworker careworker); // update 쿼리 메서드
    Careworker selectOne(Integer userId);
    List<Careworker> findAll();
    List<Careworker> findWaiting();
    Careworker selectById(Integer cwId);
    List<License> selectLicensesByCareworkerId(Integer cwId);
    void updateStatusFromWaitingToActive(Integer cwId);
    List<Careworker> findWaitingWithLicenses();

}
