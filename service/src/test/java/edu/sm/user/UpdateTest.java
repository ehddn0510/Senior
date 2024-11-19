package edu.sm.user;

import edu.sm.service.UserService;
import edu.sm.model.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@SpringBootTest
public class UpdateTest {

    @Autowired
    private UserService userService;

    @Test
    void updateUserInformation() throws Exception {
        // 테스트 대상 유저 ID
        int userId = 2;

        // 수정할 데이터 생성 (일부 필드만 수정)
        User updatedUser = User.builder()
                .userName("이순신")
                .userStreetAddr("용인")
                .userDetailAddr1("용인빌딩")
                .userDetailAddr2("1006호")
                .build();

        // 예외 없이 수정 요청이 실행되는지 검증
        assertDoesNotThrow(() -> userService.modifyById(userId, updatedUser));
    }
}
