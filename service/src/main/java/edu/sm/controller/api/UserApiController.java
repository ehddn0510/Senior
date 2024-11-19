package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.User;
import edu.sm.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.auth.InvalidCredentialsException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@RestController
@Slf4j
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
            log.error("회원가입 중 잘못된 입력 값입니다.", e);
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), 0);
        } catch (Exception e) {
            log.error("회원가입 중 예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 사용자 정보 조회 API 엔드포인트
    @GetMapping("/{userId}")
    public ResponseDto<User> getUser(@PathVariable int userId) {
        try {
            User user = userService.get(userId);
            return new ResponseDto<>(HttpStatus.OK.value(), user);
        } catch (Exception e) {
            log.error("사용자 조회 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), null);
        }
    }

    // 로그인 API 엔드포인트
    @PostMapping("/login")
    public ResponseDto<Integer> login(@RequestBody User user, HttpSession session) {
        try {
            User principal = userService.login(user);
            session.setAttribute("principal", principal);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (UsernameNotFoundException e) {
            log.error("존재하지 않는 사용자 아이디입니다.", e);
            return new ResponseDto<>(HttpStatus.NOT_FOUND.value(), 0); // 사용자 아이디가 없는 경우 404 반환
        } catch (InvalidCredentialsException e) {
            log.error("비밀번호가 일치하지 않습니다.", e);
            return new ResponseDto<>(HttpStatus.UNAUTHORIZED.value(), 0); // 비밀번호 오류인 경우 401 반환
        } catch (IllegalArgumentException e) {
            log.error("잘못된 입력 값입니다.", e);
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), 0);
        } catch (Exception e) {
            log.error("예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 회원 정보 수정 (비밀번호 제외)
    @PutMapping("/update/{id}")
    public ResponseDto<Integer> updateUserInfo(@PathVariable Integer id, @RequestBody User user) {
        try {
            userService.modifyById(id, user);  // 기본 정보 수정
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            log.error("회원 정보 수정 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 비밀번호 수정
    @PutMapping("/update/password/{id}")
    public ResponseDto<Integer> updatePassword(@PathVariable Integer id, @RequestBody String newPassword) {
        try {
            userService.updatePassword(id, newPassword); // 비밀번호 수정 서비스 호출
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            log.error("비밀번호 수정 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 유저 상태를 inactive로 설정하여 "소프트 삭제" 처리
    @DeleteMapping("/delete/{id}")
    public ResponseDto<Integer> delete(@PathVariable Integer id) {
        try {
            userService.del(id); // 상태를 inactive로 변경
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 1 반환
        } catch (Exception e) {
            log.error("유저 소프트 삭제 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }
}
