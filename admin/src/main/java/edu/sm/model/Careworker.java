package edu.sm.model;

import edu.sm.model.enums.CwStatus;
import edu.sm.model.enums.DayOfWeek;
import edu.sm.model.enums.Gender;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Careworker {
    private Integer cwId;
    private String cwUsername;
    private String cwPassword;
    private String cwTel;
    private String cwEmail;
    private String cwName;
    private Gender cwGender;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date cwBirthday;
    private String cwZipcode;
    private String cwStreetAddr;
    private String cwDetailAddr1;
    private String cwDetailAddr2;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date cwRdate;
    private CwStatus cwStatus;
    private String cwProfile;
    private DayOfWeek cwHoliday;
    private String cwIntro;
    private Integer cwExperience;

    // 자격증 목록 필드 추가
    private List<License> licenses;
}
