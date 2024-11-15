package edu.sm.careworker;

import edu.sm.model.Careworker;
import edu.sm.model.enums.DayOfWeek;
import edu.sm.model.enums.Gender;
import edu.sm.service.CareworkerService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class InsertTest {

    @Autowired
    CareworkerService careworkerService;

    @Test
    public void testInsert() {
        try {
            Careworker careworker = Careworker.builder()
                    .cwUsername("hong123")
                    .cwPassword("password123")
                    .cwTel("01012345678")
                    .cwEmail("hong@example.com")
                    .cwName("홍길동")
                    .cwGender(Gender.M)
                    .cwBirthday(java.sql.Date.valueOf("1990-01-01").toLocalDate())
                    .cwZipcode("12345")
                    .cwStreetAddr("충청남도 천안시")
                    .cwDetailAddr1("동남구")
                    .cwDetailAddr2("신부동")
                    .cwProfile("profile.jpg")
                    .cwHoliday(DayOfWeek.SUNDAY)
                    .cwIntro("보호사 소개 글 ...")
                    .cwExperience(5)
                    .build();

            careworkerService.add(careworker);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
