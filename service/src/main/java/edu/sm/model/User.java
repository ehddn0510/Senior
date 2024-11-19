package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private int userId;
    private String userUsername;              // 사용자 아이디
    private String userPassword;
    private String userTel;
    private String userEmail;
    private String userName;
    private LocalDate userBirthday;
    private String userZipcode;
    private String userStreetAddr;            // 상세 주소 1
    private String userDetailAddr1;           // 상세 주소 2
    private String userDetailAddr2;           // 상세 주소 3
    private LocalDateTime userRegDate;        // 회원가입 일자
    private String userStatus;
    private String userProfile;
}