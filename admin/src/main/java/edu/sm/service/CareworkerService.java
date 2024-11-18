package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Careworker;
import edu.sm.model.License;
import edu.sm.repository.CareworkerRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class CareworkerService implements SMService<Integer, Careworker> {

    private final CareworkerRepository careworkerRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final StandardPBEStringEncryptor textEncoder;

    // 보호사 id로 자격증 목록 조회
    public List<License> getLicensesByCareworkerId(Integer cwId) throws Exception {
        return careworkerRepository.selectLicensesByCareworkerId(cwId);
    }

    // 보호사 상태를 waiting에서 active로 변경
    public void activateCareworker(Integer cwId) throws Exception {
        careworkerRepository.updateStatusToActive(cwId);
    }

    @Override
    public void add(Careworker careworker) throws Exception {
        if (careworkerRepository.selectByUsername(careworker.getCwUsername()) != null) {
            throw new IllegalArgumentException("이미 존재하는 사용자 아이디입니다.");
        }

        // 비밀번호 암호화
        careworker.setCwPassword(passwordEncoder.encode(careworker.getCwPassword()));

        // 주소 필드 암호화
        if (careworker.getCwStreetAddr() != null) {
            careworker.setCwStreetAddr(textEncoder.encrypt(careworker.getCwStreetAddr()));
        }
        if (careworker.getCwDetailAddr1() != null) {
            careworker.setCwDetailAddr1(textEncoder.encrypt(careworker.getCwDetailAddr1()));
        }
        if (careworker.getCwDetailAddr2() != null) {
            careworker.setCwDetailAddr2(textEncoder.encrypt(careworker.getCwDetailAddr2()));
        }
        careworkerRepository.insert(careworker);
    }

    @Override
    public List<Careworker> get() throws Exception {
        return careworkerRepository.findAll();
    }

    @Override
    public Careworker get(Integer integer) throws Exception {
        return careworkerRepository.selectOne(integer);
    }

    @Override
    public void modifyById(Integer integer, Careworker careworker) throws Exception {
        SMService.super.modifyById(integer, careworker);
    }

    @Override
    public void del(Integer integer) throws Exception {
        // 실질적인 삭제 구현이 필요하다면 여기에 추가
    }

    @Override
    public void modify(Careworker careworker) throws Exception {
        // 실질적인 수정 구현이 필요하다면 여기에 추가
    }
}
