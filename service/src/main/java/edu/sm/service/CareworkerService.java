package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Careworker;
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

    @Override
    public void modifyById(Integer integer, Careworker careworker) throws Exception {
        SMService.super.modifyById(integer, careworker);
    }

    @Override
    public List<Careworker> get() throws Exception {
        return List.of();
    }

    @Override
    public Careworker get(Integer integer) throws Exception {
        return null;
    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public void modify(Careworker careworker) throws Exception {

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
}
