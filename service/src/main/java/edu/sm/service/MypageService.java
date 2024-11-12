package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.User;
import edu.sm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MypageService implements SMService<Integer, User> {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    // SMService의 add 메서드 구현
    @Override
    @Transactional
    public void add(User user) throws Exception {
        // 회원 추가 로직이 필요하지 않다면 빈 메서드로 유지
    }

    // SMService의 modify 메서드 구현
    @Override
    @Transactional
    public void modify(User user) throws Exception {
        if (user == null || user.getUserId() == 0) {
            throw new IllegalArgumentException("유효하지 않은 유저 정보입니다.");
        }

        // 기본 정보 수정 로직
        updateUserInfo(user.getUserId(), user);
    }

    // SMService의 del 메서드 구현
    @Override
    @Transactional
    public void del(Integer userId) throws Exception {
        deactivateUser(userId);
    }

    // 비밀번호 수정 (modifyById 활용)
    @Override
    @Transactional
    public void modifyById(Integer userId, User updatedUser) throws Exception {
        if (updatedUser == null || updatedUser.getPassword() == null) {
            throw new IllegalArgumentException("비밀번호가 제공되지 않았습니다.");
        }

        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }

        user.setPassword(passwordEncoder.encode(updatedUser.getPassword())); // 비밀번호 암호화 후 설정
        userRepository.update(user);
    }

    // 유저 상태를 inactive로 설정하여 소프트 삭제 처리
    @Transactional
    public void deactivateUser(Integer userId) throws Exception {
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }

        user.setStatus("inactive");
        userRepository.update(user);
    }

    // 회원 정보 수정 (비밀번호 제외)
    @Transactional
    public void updateUserInfo(Integer userId, User updatedUser) throws Exception {
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("해당 ID로 유저를 찾을 수 없습니다: " + userId);
        }

        if (updatedUser.getEmail() != null) user.setEmail(updatedUser.getEmail());
        if (updatedUser.getTel() != null) user.setTel(updatedUser.getTel());
        if (updatedUser.getName() != null) user.setName(updatedUser.getName());
        if (updatedUser.getZipcode() != null) user.setZipcode(updatedUser.getZipcode());
        if (updatedUser.getDetailAdd1() != null) user.setDetailAdd1(updatedUser.getDetailAdd1());
        if (updatedUser.getDetailAddr1() != null) user.setDetailAddr1(updatedUser.getDetailAddr1());
        if (updatedUser.getDetailAddr2() != null) user.setDetailAddr2(updatedUser.getDetailAddr2());
        if (updatedUser.getProfileImage() != null) user.setProfileImage(updatedUser.getProfileImage());

        userRepository.update(user);
    }

    // 유저 조회
    @Override
    @Transactional(readOnly = true)
    public User get(Integer userId) throws Exception {
        return userRepository.selectOne(userId);
    }

    // 모든 유저 조회
    @Override
    @Transactional(readOnly = true)
    public List<User> get() throws Exception {
        return userRepository.select();
    }
}
