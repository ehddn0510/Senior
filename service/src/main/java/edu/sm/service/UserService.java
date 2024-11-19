package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.User;
import edu.sm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.auth.InvalidCredentialsException;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
@Service
@Slf4j
@RequiredArgsConstructor
public class UserService implements SMService<Integer, User> {
    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final StandardPBEStringEncryptor textEncoder;

    @Override
    @Transactional
    public void add(User user) throws Exception {
        validateDuplicateUser(user);

        user.setUserRegDate(LocalDateTime.now());
        user.setUserPassword(encodePassword(user.getUserPassword())); // 비밀번호 암호화
        encryptAddressFields(user); // 주소 필드 암호화

        userRepository.insert(user);
    }

    @Override
    public void modify(User user) throws Exception {
        validateDuplicateUser(user);
        user.setUserPassword(encodePassword(user.getUserPassword())); // 수정 시 비밀번호 암호화
        encryptAddressFields(user); // 주소 필드 암호화
        userRepository.update(user);
    }

    @Override
    public void del(Integer userId) throws Exception {
        userRepository.delete(userId);
    }

    @Override
    public User get(Integer userId) throws Exception {
        return getUserById(userId);
    }

    @Override
    public List<User> get() throws Exception {
        return userRepository.select();
    }

    // 특정 ID로 사용자 검색
    public User getUserById(int userId) throws Exception {
        User user = userRepository.selectOne(userId);
        decryptAddressFields(user); // 주소 필드 복호화
        return user;
    }

    private void validateDuplicateUser(User user) {
        if (userRepository.findByUsername(user.getUserUsername()) != null) {
            throw new IllegalArgumentException("이미 존재하는 아이디입니다.");
        }
        if (userRepository.findByTel(user.getUserTel()) != null) {
            throw new IllegalArgumentException("이미 존재하는 전화번호입니다.");
        }
        if (userRepository.findByEmail(user.getUserEmail()) != null) {
            throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
        }
    }

    // 로그인 로직
    @Transactional
    public User login(User user) throws Exception {
        User principal = userRepository.selectByUsername(user.getUserUsername());
        if (principal == null || !passwordEncoder.matches(user.getUserPassword(), principal.getUserPassword())) {
            throw new InvalidCredentialsException("아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        return principal;
    }

    // 이메일로 아이디 찾기
    public String findIdByEmail(String email) throws Exception {
        User user = userRepository.findByEmailForFindId(email);
        if (user == null) {
            throw new IllegalArgumentException("해당 이메일로 등록된 계정을 찾을 수 없습니다.");
        }

        String username = user.getUserUsername();

        // 아이디를 반으로 나누기
        int length = username.length();
        int halfLength = length / 2;

        // 앞부분: 반만 가져오기, 뒷부분: 나머지 부분은 *로 채우기
        String maskedUsername = username.substring(0, halfLength)
                + "*".repeat(length - halfLength);

        return maskedUsername;
    }



    // 주소 필드 암호화
    private void encryptAddressFields(User user) {
        if (user.getUserStreetAddr() != null) user.setUserStreetAddr(textEncoder.encrypt(user.getUserStreetAddr()));
        if (user.getUserDetailAddr1() != null) user.setUserDetailAddr1(textEncoder.encrypt(user.getUserDetailAddr1()));
        if (user.getUserDetailAddr2() != null) user.setUserDetailAddr2(textEncoder.encrypt(user.getUserDetailAddr2()));
    }

    // 주소 필드 복호화
    private void decryptAddressFields(User user) {
        if (user != null) {
            if (user.getUserStreetAddr() != null) user.setUserStreetAddr(textEncoder.decrypt(user.getUserStreetAddr()));
            if (user.getUserDetailAddr1() != null) user.setUserDetailAddr1(textEncoder.decrypt(user.getUserDetailAddr1()));
            if (user.getUserDetailAddr2() != null) user.setUserDetailAddr2(textEncoder.decrypt(user.getUserDetailAddr2()));
        }
    }

    // 비밀번호 암호화
    private String encodePassword(String rawPassword) {
        return passwordEncoder.encode(rawPassword);
    }
}
