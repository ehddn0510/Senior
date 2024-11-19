package edu.sm.careworker;

import edu.sm.model.Careworker;
import edu.sm.service.CareworkerService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class LoginTest {

    @Autowired
    CareworkerService careworkerService;

    @Test
    public void testLogin() {
        try {
            Careworker loginDto = Careworker.builder()
                    .cwUsername("hong123")
                    .cwPassword("password123")
                    .build();
            Careworker careworker = careworkerService.login(loginDto);

            if (careworker != null) {
                log.info("로그인 성공");
                log.info("careworker: {}", careworker);
            } else {
                log.info("로그인 실패");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
