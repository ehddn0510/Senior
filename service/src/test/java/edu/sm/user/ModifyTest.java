package edu.sm.user;

import edu.sm.model.User;
import edu.sm.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@SpringBootTest
public class ModifyTest {

    @Autowired
    private UserService userService;

    @Test
    void modifyUserInformation() {
        User updatedUser = new User();
        updatedUser.setUserId(2); // 테스트 유저의 ID
        updatedUser.setTel("01055556666"); // 필수 값 설정
        updatedUser.setEmail("newemail@example.com");
        updatedUser.setName("이말수"); // 다른 필드도 설정 (선택사항)

        // 수정 테스트 실행
        assertDoesNotThrow(() -> userService.modify(updatedUser));
    }
}
