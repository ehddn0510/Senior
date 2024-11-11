package edu.sm.service;

import edu.sm.frame.SMService;
import edu.sm.model.Admin;
import edu.sm.model.Senior;
import edu.sm.model.User;
import edu.sm.repository.AdminRepository;
import edu.sm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService implements SMService<Integer, User> {

    private final UserRepository userRepository;


    @Override
    public void add(User user) throws Exception {

    }

    @Override
    public void modify(User user) throws Exception {
        if (user.getUserId() == 0) {
            throw new IllegalArgumentException("User ID cannot be zero.");
        }
        userRepository.update(user);
    }

    @Override
    public void del(Integer integer) throws Exception {

    }

    @Override
    public User get(Integer integer) throws Exception {
        return userRepository.selectOne(integer);
    }

    @Override
    public List<User> get() throws Exception {
        return userRepository.findAll();
    }

    public void modifyById(Integer id, User updatedUser) throws Exception {
        User existingUser = userRepository.selectOne(id);
        if (existingUser == null) {
            throw new IllegalArgumentException("User not found with ID: " + id);
        }

        // 기존 필드와 새 필드 병합
        if (updatedUser.getUserEmail() != null) {
            existingUser.setUserEmail(updatedUser.getUserEmail());
        }
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
        if (updatedUser.getUserStatus() != null) {
            existingUser.setUserStatus(updatedUser.getUserStatus());
        }
        if (updatedUser.getUserProfile() != null) {
            existingUser.setUserProfile(updatedUser.getUserProfile());
        }

        userRepository.update(existingUser); // 병합된 데이터를 DB에 저장
    }


    // userId로 senior 데이터 조회
    public List<Senior> getSeniorsByUserId(Integer userId) throws Exception {
        return userRepository.selectSeniorByUserId(userId);
    }
    // 사용자 상태를 inactive로 변경하는 메서드
    public void updateStatusToInactive(Integer userId) throws Exception {
        User user = userRepository.selectOne(userId);
        if (user == null) {
            throw new IllegalArgumentException("User not found with ID: " + userId);
        }
        user.setUserStatus("inactive");
        userRepository.update(user);
    }

}
