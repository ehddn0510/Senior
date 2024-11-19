package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Senior;
import edu.sm.repository.SeniorRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

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

    // seniorId를 기준으로 기존 데이터와 새로운 데이터를 병합하여 수정하는 메서드
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
}
