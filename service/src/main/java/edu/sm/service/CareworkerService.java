package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Careworker;
import edu.sm.model.User;
import edu.sm.model.enums.CwStatus;
import edu.sm.repository.CareworkerRepository;
import edu.sm.util.FileUploadUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.nio.file.Paths;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class CareworkerService implements SMService<Integer, Careworker> {

    private final CareworkerRepository careworkerRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final StandardPBEStringEncryptor textEncoder;

    @Value("${app.dir.uploaddir}")
    String imgDir;

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
        String careworkerDir = Paths.get(imgDir, "careworker").toString();

        validateDuplicateUser(careworker);

        FileUploadUtil.saveFile(careworker.getCwProfileFile(), careworkerDir);

        careworker.setCwPassword(passwordEncoder.encode(careworker.getCwPassword()));
        encryptAddressFields(careworker);

        careworker.setCwStatus(CwStatus.WAITING);

        careworkerRepository.insert(careworker);
    }

    @Transactional
    public Careworker login(Careworker careworker) throws Exception {
        Careworker principal = careworkerRepository.selectByUsername(careworker.getCwUsername());
        if (principal == null || !passwordEncoder.matches(careworker.getCwPassword(), principal.getCwPassword())) {
            throw new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        return principal;
    }

    public List<Careworker> getCareworkersWithinRadius(double latitude, double longitude, double radius) throws Exception {
        return careworkerRepository.selectNearbyCareworkers(latitude, longitude, radius);
    }

    private void validateDuplicateUser(Careworker careworker) throws Exception {
        if (careworkerRepository.selectByUsername(careworker.getCwUsername()) != null) {
            throw new IllegalArgumentException("이미 존재하는 아이디입니다.");
        }
        if (careworkerRepository.selectByTel(careworker.getCwTel()) != null) {
            throw new IllegalArgumentException("이미 존재하는 전화번호입니다.");
        }
        if (careworkerRepository.selectByEmail(careworker.getCwEmail()) != null) {
            throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
        }
    }

    private void encryptAddressFields(Careworker careworker) {
        if (careworker.getCwStreetAddr() != null) careworker.setCwStreetAddr(textEncoder.encrypt(careworker.getCwStreetAddr()));
        if (careworker.getCwDetailAddr1() != null) careworker.setCwDetailAddr1(textEncoder.encrypt(careworker.getCwDetailAddr1()));
        if (careworker.getCwDetailAddr2() != null) careworker.setCwDetailAddr2(textEncoder.encrypt(careworker.getCwDetailAddr2()));
    }

    private void decryptAddressFields(Careworker careworker) {
        if (careworker != null) {
            if (careworker.getCwStreetAddr() != null) careworker.setCwStreetAddr(textEncoder.decrypt(careworker.getCwStreetAddr()));
            if (careworker.getCwDetailAddr1() != null) careworker.setCwDetailAddr1(textEncoder.decrypt(careworker.getCwDetailAddr1()));
            if (careworker.getCwDetailAddr2() != null) careworker.setCwDetailAddr2(textEncoder.decrypt(careworker.getCwDetailAddr2()));
        }
    }
}
