package edu.sm.senior;

import edu.sm.service.SeniorService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@SpringBootTest
public class SeniorStatusChangeTest {

    @Autowired
    private SeniorService seniorService;

    @Test
    void changeSeniorStatusToInactive() {
        int seniorId = 24; // 테스트 시니어의 ID
        assertDoesNotThrow(() -> seniorService.updateStatusToInactive(seniorId));
    }
}