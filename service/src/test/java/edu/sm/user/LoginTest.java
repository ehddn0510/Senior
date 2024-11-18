package edu.sm.user;

import edu.sm.model.User;
import lombok.extern.slf4j.Slf4j;
import edu.sm.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class LoginTest {

    @Autowired
    UserService userService;

    @Test
    public void testLogin() {
        try {
            User loginDto = User.builder()
                    .userUsername("newTestUser7")
                    .userPassword("newPassword123")
                    .build();
            User user = userService.login(loginDto);

            if (user != null) {
                log.info("로그인 성공");
                log.info("user: {}", user);
            } else {
                log.info("로그인 실패");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}