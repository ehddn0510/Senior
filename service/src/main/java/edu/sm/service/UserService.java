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

@Slf4j
@Service
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
        user.setUserPassword(passwordEncoder.encode(user.getUserPassword())); // 비밀번호 암호화

        // 주소 필드 암호화
        if (user.getUserDetailAdd1() != null) user.setUserDetailAdd1(textEncoder.encrypt(user.getUserDetailAdd1()));
        if (user.getUserDetailAddr1() != null) user.setUserDetailAddr1(textEncoder.encrypt(user.getUserDetailAddr1()));
        if (user.getUserDetailAddr2() != null) user.setUserDetailAddr2(textEncoder.encrypt(user.getUserDetailAddr2()));

        userRepository.insert(user);
    }

    @Override
    public void modify(User user) throws Exception {
        // 수정 로직 추가
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
        return null;
    }

    public User getUserById(int userId) throws Exception {
        User user = userRepository.selectOne(userId);

        // 주소 필드 복호화
        if (user != null) {
            if (user.getUserDetailAdd1() != null) user.setUserDetailAdd1(textEncoder.decrypt(user.getUserDetailAdd1()));
            if (user.getUserDetailAddr1() != null) user.setUserDetailAddr1(textEncoder.decrypt(user.getUserDetailAddr1()));
            if (user.getUserDetailAddr2() != null) user.setUserDetailAddr2(textEncoder.decrypt(user.getUserDetailAddr2()));
        }
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

    // 로그인
    @Transactional
    public User login(User user) throws Exception {
        User principal = userRepository.selectByUsername(user.getUserUsername());
        if (principal == null) {
            throw new UsernameNotFoundException("존재하지 않는 사용자 아이디입니다.");
        }
        if (!passwordEncoder.matches(user.getUserPassword(), principal.getUserPassword())) {
            throw new InvalidCredentialsException("비밀번호가 일치하지 않습니다.");
        }
        return principal;
    }

    // 필수 필드 유효성 검사를 위한 메서드
    private void validateServiceFields(User user) {
        if (user.getUserUsername() == null || user.getUserUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 이름은 필수 입력 항목입니다.");
        }
        if (user.getUserPassword() == null || user.getUserPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("비밀번호는 필수 입력 항목입니다.");
        }
        if (user.getUserName() == null || user.getUserName().trim().isEmpty()) {
            throw new IllegalArgumentException("이름은 필수 입력 항목입니다.");
        }
    }
}
