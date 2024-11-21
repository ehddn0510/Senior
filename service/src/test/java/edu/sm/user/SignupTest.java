package edu.sm.user;

import edu.sm.model.User;
import edu.sm.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
@Slf4j
public class SignupTest {

    @Autowired
    private UserService userService;

    @Test
    public void testSignup() {
        try {
            // Given: 테스트 데이터 준비
            User userDto = User.builder()
                    .userUsername("newTestUser2") // 아이디
                    .userPassword("newPassword123") // 비밀번호
                    .userEmail("newtestuser2@example.com") // 이메일
                    .userTel("01087654323") // 전화번호
                    .userName("New Test User") // 이름
                    .userBirthday(LocalDate.of(1990, 1, 1)) // 생년월일 (LocalDate)
                    .userZipcode("12345") // 우편번호
                    .userStreetAddr("서울시 강남구") // 상세주소 1
                    .userDetailAddr1("삼성동") // 상세주소 2
                    .userDetailAddr2("101호") // 상세주소 3
                    .userProfile("profile1.jpg") // 프로필 이미지
                    .build();

            // When: 회원가입 실행
            userService.add(userDto);

            log.info("회원가입 성공: {}", userDto.getUserUsername());
        } catch (Exception e) {
            log.error("회원가입 실패", e);
            throw new RuntimeException(e);
        }
    }
}
