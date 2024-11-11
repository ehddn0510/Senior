package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.User;
import edu.sm.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
public class UserApiController {

    private final UserService userService;

    @PostMapping("/api/user/updateUser")
    public ResponseDto<Integer> updateUser(User user) {
        log.info("Received User data: {}", user); // User 객체의 내용 확인
        try {
            // here Tlqkf
            userService.modifyById(user.getUserId(), user);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (IllegalArgumentException e) {
            log.error("잘못된 입력 값입니다.", e);
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), 0);
        } catch (Exception e) {
            log.error("예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }


    // 사용자 상태를 inactive로 변경하는 API
    @PostMapping("/api/user/deactivate/{id}")
    public ResponseDto<Integer> deactivateUser(@PathVariable Integer id) {
        try {
            userService.updateStatusToInactive(id); // 상태를 inactive로 업데이트
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 상태 코드 200 반환
        } catch (IllegalArgumentException e) {
            log.error("존재하지 않는 사용자입니다.", e);
            return new ResponseDto<>(HttpStatus.NOT_FOUND.value(), 0); // 사용자 미존재 시 404 반환
        } catch (Exception e) {
            log.error("예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0); // 서버 오류 시 500 반환
        }
    }

    // 사용자 비밀번호 수정 API
//    @PostMapping("/updatePassword")
//    public ResponseDto<Integer> updatePassword(@RequestBody User user, @RequestParam String newPassword) {
//        try {
//            userService.updatePasswordById(user.getUserId(), newPassword); // 비밀번호 업데이트
//            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 상태 코드 200 반환
//        } catch (IllegalArgumentException e) {
//            log.error("잘못된 입력 값입니다.", e);
//            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), 0); // 잘못된 입력 시 400 반환
//        } catch (Exception e) {
//            log.error("예기치 않은 오류 발생", e);
//            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0); // 서버 오류 시 500 반환
//        }
//    }
}
