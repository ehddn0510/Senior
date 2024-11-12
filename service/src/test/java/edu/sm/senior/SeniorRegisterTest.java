package edu.sm.senior;

import edu.sm.model.Senior;
import edu.sm.service.SeniorService;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

@SpringBootTest
public class SeniorRegisterTest {


    @Autowired
    private SeniorService seniorService;

    @Autowired
    private StandardPBEStringEncryptor textEncoder;

    @Test
    void registerSenior() {
        // 테스트할 평문 주소 데이터
        String streetAddr = "서울시";
        String detailAddr1 = "강남구";
        String detailAddr2 = "청담동";

        // Senior 객체 생성
        Senior senior = Senior.builder()
                .seniorName("동바바")
                .seniorGender("male")
                .seniorTel("010-1234-5678")
                .seniorBirth(LocalDate.of(1945, 5, 10))
                .seniorZipcode("12345")
                .seniorStreetAddr(streetAddr)
                .seniorDetailAddr1(detailAddr1)
                .seniorDetailAddr2(detailAddr2)
                .seniorRdate(LocalDateTime.now())
                .seniorStatus("active")
                .seniorSignificant("알레르기 없음")
                .userId(1)
                .build();

        // SeniorService의 add 메서드 호출 및 예외 발생 여부 확인
        assertDoesNotThrow(() -> seniorService.add(senior));

    }
}