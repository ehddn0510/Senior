package edu.sm.user;

import edu.sm.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class FindTest {

    @Autowired
    private UserService userService;

    @Test
    public void testFindIdByEmail() {
        try {
            // Given
            String testEmail = "newtestuser1@example.com";

            // When
            String username = userService.findIdByEmail(testEmail);

            // 결과 출력
            log.info("마스킹된 아이디: {}", username);

        } catch (Exception e) {
            log.error("아이디 찾기 실패", e);
            throw new RuntimeException(e);
        }
    }

}
