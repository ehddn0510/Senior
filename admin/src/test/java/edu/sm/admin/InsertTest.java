package edu.sm.admin;

import edu.sm.model.Admin;
import edu.sm.service.AdminService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class InsertTest {

    @Autowired
    AdminService adminService;

    @Test
    public void testInsert() {
        try {
            Admin admin = Admin.builder()
                    .adminId(0)
                    .adminUsername("admin99")
                    .adminPassword("1234")
                    .adminName("홍길동")
                    .build();
            adminService.add(admin);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
