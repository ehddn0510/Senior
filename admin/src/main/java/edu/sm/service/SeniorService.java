package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.HealthInfo;
import edu.sm.model.Senior;
import edu.sm.repository.SeniorRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class SeniorService implements SMService<Integer, Senior> {

    private final SeniorRepository seniorRepository;

    @Override
    public void add(Senior senior) throws Exception {
        // 추가 기능 구현
    }

    @Override
    public void modify(Senior senior) throws Exception {
        if (senior.getSeniorId() == 0) {
            throw new IllegalArgumentException("Senior ID cannot be zero.");
        }
        seniorRepository.update(senior);
    }

    @Override
    public void del(Integer integer) throws Exception {
        // 삭제 기능 구현
    }

    @Override
    public Senior get(Integer integer) throws Exception {
        return seniorRepository.selectOne(integer);
    }

    @Override
    public List<Senior> get() throws Exception {
        return seniorRepository.findAll();
    }

    // 지역별 인원 수 조회 메서드 추가
    public List<Map<String, Object>> getRegionWisePersonCount() {
        List<Map<String, Object>> regionWiseCount = seniorRepository.getRegionWisePersonCount();
        if (regionWiseCount.isEmpty()) {
            log.warn("No data found for region-wise person count");
        }
        return regionWiseCount;
    }

    public List<Map<String, Object>> getAgeGroupDistribution() {
        List<Map<String, Object>> ageGroupDistribution = seniorRepository.getSeniorAgeGroupDistribution();

        if (ageGroupDistribution.isEmpty()) {
            log.warn("No age group distribution data found in the senior table.");
        }

        return ageGroupDistribution;
    }


    // 기존 메서드들 유지
    public void modifyById(Integer id, Senior updatedSenior) throws Exception {
        Senior existingSenior = seniorRepository.selectOne(id);
        if (existingSenior == null) {
            throw new IllegalArgumentException("Senior not found with ID: " + id);
        }

        // 필드 병합: null이 아닌 값만 업데이트
        if (updatedSenior.getSeniorName() != null) {
            existingSenior.setSeniorName(updatedSenior.getSeniorName());
        }
        if (updatedSenior.getSeniorTel() != null) {
            existingSenior.setSeniorTel(updatedSenior.getSeniorTel());
        }
        if (updatedSenior.getSeniorBirth() != null) {
            existingSenior.setSeniorBirth(updatedSenior.getSeniorBirth());
        }
        if (updatedSenior.getSeniorZipcode() != null) {
            existingSenior.setSeniorZipcode(updatedSenior.getSeniorZipcode());
        }
        if (updatedSenior.getSeniorStreetAddr() != null) {
            existingSenior.setSeniorStreetAddr(updatedSenior.getSeniorStreetAddr());
        }
        if (updatedSenior.getSeniorDetailAddr1() != null) {
            existingSenior.setSeniorDetailAddr1(updatedSenior.getSeniorDetailAddr1());
        }
        if (updatedSenior.getSeniorDetailAddr2() != null) {
            existingSenior.setSeniorDetailAddr2(updatedSenior.getSeniorDetailAddr2());
        }
        if (updatedSenior.getSeniorStatus() != null) {
            existingSenior.setSeniorStatus(updatedSenior.getSeniorStatus());
        }
        if (updatedSenior.getSeniorSignificant() != null) {
            existingSenior.setSeniorSignificant(updatedSenior.getSeniorSignificant());
        }

        seniorRepository.update(existingSenior); // 병합된 데이터를 DB에 저장
    }

    public List<HealthInfo> getHealthInfoBySeniorId(Integer seniorId) throws Exception {
        if (seniorId == null || seniorId <= 0) {
            throw new IllegalArgumentException("Invalid senior ID: " + seniorId);
        }
        List<HealthInfo> healthInfoList = seniorRepository.findHealthInfoBySeniorId(seniorId);
        if (healthInfoList.isEmpty()) {
            log.warn("No health information found for senior ID: {}", seniorId);
        }
        return healthInfoList;
    }

    public Map<String, Object> getRecentContractInfo(Integer seniorId) {
        return seniorRepository.findRecentContractInfoBySeniorId(seniorId);
    }

    public Long getTotalContractAmount(Integer seniorId) {
        return seniorRepository.selectTotalContractAmountByseniorId(seniorId);
    }

    public Long getContractRenewalCount(Integer seniorId) {
        return seniorRepository.selectContractRenewalCountByseniorId(seniorId);
    }


}
