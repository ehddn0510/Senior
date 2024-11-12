package edu.sm.admin;

import edu.sm.model.Admin;
import edu.sm.service.AdminService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
public class LoginTest {

    @Autowired
    AdminService adminService;

    @Test
    public void testLogin() {
        try {
            Admin loginDto = Admin.builder()
                    .adminUsername("admin99")
                    .adminPassword("1234")
                    .build();
            Admin admin = adminService.login(loginDto);

            if (admin != null) {
                log.info("로그인 성공");
                log.info("admin: {}", admin);
            } else {
                log.info("로그인 실패");
            }


        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
