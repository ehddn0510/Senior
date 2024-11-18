package edu.sm.model;

import edu.sm.model.enums.CwStatus;
import edu.sm.model.enums.DayOfWeek;
import edu.sm.model.enums.Gender;
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
public class License {
    private LocalDateTime licenseStartDate;
    private LocalDateTime licenseEndDate;
    private String licenseStartDateStr; // 변환된 필드
    private String licenseEndDateStr;   // 변환된 필드
    private int licenseStatus;
    private String licenseName;
}