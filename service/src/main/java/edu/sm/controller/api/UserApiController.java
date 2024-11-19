package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.User;
import edu.sm.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/users")
public class UserApiController {

    private final UserService userService;

    // 회원가입 API
    @PostMapping("/signup")
    public ResponseDto<Integer> registerUser(@RequestBody User user) {
        try {
            userService.add(user);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            log.error("회원가입 실패", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 사용자 정보 조회 API
    @GetMapping("/{userId}")
    public ResponseDto<User> getUser(@PathVariable int userId) {
        try {
            User user = userService.getUserById(userId);
            return new ResponseDto<>(HttpStatus.OK.value(), user);
        } catch (Exception e) {
            log.error("사용자 조회 실패", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), null);
        }
    }

    // 로그인 API
    @PostMapping("/login")
    public ResponseDto<Integer> login(@RequestBody User user, HttpSession session) {
        try {
            User principal = userService.login(user);
            session.setAttribute("principal", principal);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            log.error("로그인 실패", e);
            return new ResponseDto<>(HttpStatus.UNAUTHORIZED.value(), 0);
        }
    }

    // 아이디 찾기 API
    @GetMapping("/findid")
    public ResponseDto<String> findId(@RequestParam String userEmail) {
        try {
            String username = userService.findIdByEmail(userEmail);
            return new ResponseDto<>(HttpStatus.OK.value(), username);
        } catch (Exception e) {
            log.error("아이디 찾기 실패", e);
            return new ResponseDto<>(HttpStatus.NOT_FOUND.value(), null);
        }
    }
}
