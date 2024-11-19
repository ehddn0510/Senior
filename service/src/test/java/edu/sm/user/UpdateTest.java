package edu.sm.user;

import edu.sm.service.UserService;
import edu.sm.model.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
public class UpdateTest {

    @Autowired
    private UserService userService;

    @Test
    void updateUserInformation() {
        int userId = 3; // 테스트 유저의 ID

        // 2. 수정할 데이터 생성
        User updatedUser = User.builder()
                .userName("Updated Name") // 새 이름
                .userEmail("updated.email@example.com") // 새 이메일
                .userDetailAdd1("서울")
                .userDetailAddr1("강서구") // 새 상세주소1
                .userDetailAddr2("집") // 새 상세주소2
                .build();

        // 3. 수정 요청 실행
        assertDoesNotThrow(() -> userService.modifyById(userId, updatedUser));
    }
}
