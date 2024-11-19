package edu.sm.user;

import edu.sm.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@SpringBootTest
public class StatusChangeTest {

    @Autowired
    private UserService userService;

    @Test
    void changeUserStatusToInactive() {
        int userId = 1; // 테스트 유저의 ID
        assertDoesNotThrow(() -> userService.del(userId));
    }
}
