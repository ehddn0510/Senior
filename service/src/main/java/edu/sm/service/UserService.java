package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.User;
import edu.sm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

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

        user.setRegDate(LocalDateTime.now());
        user.setPassword(passwordEncoder.encode(user.getPassword())); // 비밀번호 암호화

        // 주소 필드 암호화
        if (user.getDetailAdd1() != null) user.setDetailAdd1(textEncoder.encrypt(user.getDetailAdd1()));
        if (user.getDetailAddr1() != null) user.setDetailAddr1(textEncoder.encrypt(user.getDetailAddr1()));
        if (user.getDetailAddr2() != null) user.setDetailAddr2(textEncoder.encrypt(user.getDetailAddr2()));

        userRepository.insert(user);
    }

    @Override
    @Transactional
    public void modify(User updatedUser) throws Exception {
        if (updatedUser == null || updatedUser.getUserId() == 0) {
            throw new IllegalArgumentException("유효하지 않은 유저 정보입니다.");
        }

        // 기존 데이터 조회
        User existingUser = userRepository.selectOne(updatedUser.getUserId());
        if (existingUser == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + updatedUser.getUserId());
        }

        // 수정 요청에서 제공된 값만 업데이트
        if (updatedUser.getTel() != null) existingUser.setTel(updatedUser.getTel());
        if (updatedUser.getEmail() != null) existingUser.setEmail(updatedUser.getEmail());
        if (updatedUser.getName() != null) existingUser.setName(updatedUser.getName());

        // 주소 필드 암호화 후 업데이트
        if (updatedUser.getDetailAdd1() != null) existingUser.setDetailAdd1(textEncoder.encrypt(updatedUser.getDetailAdd1()));
        if (updatedUser.getDetailAddr1() != null) existingUser.setDetailAddr1(textEncoder.encrypt(updatedUser.getDetailAddr1()));
        if (updatedUser.getDetailAddr2() != null) existingUser.setDetailAddr2(textEncoder.encrypt(updatedUser.getDetailAddr2()));

        // 기존 데이터에 변경 사항 적용
        userRepository.updateUserInfo(existingUser);
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

    // 유저 상태를 inactive로 설정하여 소프트 삭제 처리
    @Override
    @Transactional
    public void del(Integer userId) throws Exception {
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }

        userRepository.deactivateUser(userId);
    }

    // 사용자 정보 조회 (ID로 조회)
    public User getUserById(Integer userId) throws Exception {
        return get(userId);
    }

    // SMService 인터페이스의 get 메서드 구현 (getUserById 메서드를 호출)
    @Override
    @Transactional(readOnly = true)
    public User get(Integer userId) throws Exception {
        User user = userRepository.selectOne(userId);

        // 주소 필드 복호화
        if (user != null) {
            if (user.getDetailAdd1() != null) user.setDetailAdd1(textEncoder.decrypt(user.getDetailAdd1()));
            if (user.getDetailAddr1() != null) user.setDetailAddr1(textEncoder.decrypt(user.getDetailAddr1()));
            if (user.getDetailAddr2() != null) user.setDetailAddr2(textEncoder.decrypt(user.getDetailAddr2()));
        }
        return user;
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> get() throws Exception {
        return userRepository.select();
    }

    private void validateDuplicateUser(User user) {
        if (userRepository.findByUsername(user.getUsername()) != null) {
            throw new IllegalArgumentException("이미 존재하는 아이디입니다.");
        }
        if (userRepository.findByTel(user.getTel()) != null) {
            throw new IllegalArgumentException("이미 존재하는 전화번호입니다.");
        }
        if (userRepository.findByEmail(user.getEmail()) != null) {
            throw new IllegalArgumentException("이미 존재하는 이메일입니다.");
        }
    }
}
