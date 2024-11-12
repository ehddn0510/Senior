package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.User;
import edu.sm.service.MypageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/user")
public class MypageApiController {

    private final MypageService mypageService;

    // 회원 정보 수정 (비밀번호 제외)
    @PutMapping("/update/{id}")
    public ResponseDto<Integer> updateUserInfo(@PathVariable Integer id, @RequestBody User user) throws Exception {
        mypageService.modifyById(id, user);  // 기본 정보 수정
        return new ResponseDto<>(HttpStatus.OK.value(), 1);
    }

    // 비밀번호 수정
    @PutMapping("/update/password/{id}")
    public ResponseDto<Integer> updatePassword(@PathVariable Integer id, @RequestBody String newPassword) throws Exception {
        User updatedUser = new User();
        updatedUser.setUserId(id);
        updatedUser.setPassword(newPassword);
        mypageService.modifyById(id, updatedUser); // 비밀번호 수정
        return new ResponseDto<>(HttpStatus.OK.value(), 1);
    }

    // 유저 상태를 inactive로 설정하여 "소프트 삭제" 처리
    @DeleteMapping("/delete/{id}")
    public ResponseDto<Integer> deactivateUser(@PathVariable Integer id) throws Exception {
        mypageService.del(id); // 상태를 inactive로 변경
        return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 1 반환
    }

    // 유저 조회
    @GetMapping("/{id}")
    public ResponseDto<User> getUser(@PathVariable Integer id) throws Exception {
        User user = mypageService.get(id);
        return new ResponseDto<>(HttpStatus.OK.value(), user); // 조회된 유저 정보 반환
    }
}
