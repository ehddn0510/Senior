package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.User;
import edu.sm.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.Service;
import org.apache.http.auth.InvalidCredentialsException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import static net.sf.jsqlparser.util.validation.metadata.NamedObject.user;

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
    @PostMapping("/login")
    public ResponseDto<Integer> login(@RequestBody User user, HttpSession session) {
        try {
            User principal = userService.login(user);
            session.setAttribute("principal", principal.getUserId());
            session.setAttribute("role", "USER");
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

}
