package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.User;
import edu.sm.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/users")
public class UserApiController {

    private final UserService userService;

    // 회원가입 API 엔드포인트
    @PostMapping("/signup")
    public ResponseDto<Integer> registerUser(@RequestBody User user) {
        try {
            userService.add(user);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (IllegalArgumentException e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 사용자 정보 조회 API 엔드포인트
    @GetMapping("/{userId}")
    public ResponseDto<User> getUser(@PathVariable int userId) {
        try {
            User user = userService.getUserById(userId);
            return new ResponseDto<>(HttpStatus.OK.value(), user);
        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), null);
        }
    }

    // 회원 정보 수정 (비밀번호 제외)
    @PutMapping("/update/{id}")
    public ResponseDto<Integer> updateUserInfo(@PathVariable Integer id, @RequestBody User user) {
        try {
            userService.modifyById(id, user);  // 기본 정보 수정
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 비밀번호 수정
    @PutMapping("/update/password/{id}")
    public ResponseDto<Integer> updatePassword(@PathVariable Integer id, @RequestBody String newPassword) {
        try {
            User updatedUser = new User();
            updatedUser.setUserId(id);
            updatedUser.setPassword(newPassword);
            userService.modifyById(id, updatedUser); // 비밀번호 수정
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 유저 상태를 inactive로 설정하여 "소프트 삭제" 처리
    @DeleteMapping("/delete/{id}")
    public ResponseDto<Integer> deactivateUser(@PathVariable Integer id) {
        try {
            userService.del(id); // 상태를 inactive로 변경
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 1 반환
        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }
}
