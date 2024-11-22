package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private int userId;
    private String userUsername;
    private String userPassword;
    private String userTel;
    private String userEmail;
    private String userName;
    private LocalDate userBirthday;
    private String userZipcode;
    private String userStreetAddr;
    private String userDetailAddr1;
    private String userDetailAddr2;
    private LocalDateTime userRegDate;
    private String userStatus;
    private String userProfile;
    private MultipartFile userProfileFile;
}