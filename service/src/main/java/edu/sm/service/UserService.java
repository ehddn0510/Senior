package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.User;
import edu.sm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
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
    }

    @Transactional
    public void modifyById(Integer userId, User updatedUser) throws Exception {
        if (userId == null || userId <= 0) {
            throw new IllegalArgumentException("유효하지 않은 유저 ID입니다.");
        }

        // 기존 데이터 조회
        User existingUser = userRepository.selectOne(userId);
        if (existingUser == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }

        // 수정 요청에서 제공된 값만 반영
        if (updatedUser.getUserTel() != null) {
            existingUser.setUserTel(updatedUser.getUserTel());
        }
        if (updatedUser.getUserName() != null) {
            existingUser.setUserName(updatedUser.getUserName());
        }
        if (updatedUser.getUserZipcode() != null) {
            existingUser.setUserZipcode(updatedUser.getUserZipcode());
        }
        if (updatedUser.getUserDetailAdd1() != null) {
            existingUser.setUserDetailAdd1(updatedUser.getUserDetailAdd1());
        }
        if (updatedUser.getUserDetailAddr1() != null) {
            existingUser.setUserDetailAddr1(updatedUser.getUserDetailAddr1());
        }
        if (updatedUser.getUserDetailAddr2() != null) {
            existingUser.setUserDetailAddr2(updatedUser.getUserDetailAddr2());
        }

        // 주소 필드 암호화
        encryptAddress(existingUser);

        // 변경된 데이터 저장
        userRepository.update(existingUser); // existingUser 전달
    }

    // 비밀번호 수정
    @Transactional
    public void updatePassword(Integer userId, String newPassword) throws Exception {
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }

        userRepository.updatePassword(userId, passwordEncoder.encode(newPassword));
    }

    @Override
    public User get(Integer userId) throws Exception {
        return getUserById(userId);
    }

    @Override
    public void del(Integer userId) throws Exception {
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }

        userRepository.deactivateUser(userId);
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

    @Transactional
    public User login(User user) throws Exception {
        User principal = userRepository.selectByUsername(user.getUserUsername());
        if (principal == null || !passwordEncoder.matches(user.getUserPassword(), principal.getUserPassword())) {
            throw new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        return principal;
    }

    private void encryptAddress(User user) {
        if (user.getUserDetailAddr1() != null) {
            user.setUserDetailAddr1(textEncoder.encrypt(user.getUserDetailAddr1()));
        }
        if (user.getUserDetailAddr2() != null) {
            user.setUserDetailAddr2(textEncoder.encrypt(user.getUserDetailAddr2()));
        }
        if (user.getUserZipcode() != null) {
            user.setUserZipcode(textEncoder.encrypt(user.getUserZipcode()));
        }
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
}
