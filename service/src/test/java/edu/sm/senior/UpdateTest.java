package edu.sm.senior;

import edu.sm.model.Senior;
import edu.sm.service.SeniorService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@SpringBootTest
public class UpdateTest {

    @Autowired
    private SeniorService seniorService;

    @Test
    void updateSeniorInfo() {
        int seniorId = 2; // 테스트 시니어의 ID
        Senior updatedSenior = Senior.builder()
                .seniorName("홍길순")
                .seniorStreetAddr("서울시 중구 명동길 24")
                .seniorDetailAddr1("명동빌딩 10층")
                .seniorDetailAddr2("1001호")
                .build();

        assertDoesNotThrow(() -> seniorService.modifyById(seniorId, updatedSenior));
    }
}