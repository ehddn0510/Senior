package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class License {
    private Integer licenseId;           // license_id와 매핑되는 필드 추가
    private String licenseName;
    private LocalDateTime licenseStartDate;
    private LocalDateTime licenseEndDate;
    private String licenseStartDateStr;  // 변환된 필드
    private String licenseEndDateStr;    // 변환된 필드
    private int licenseStatus;
}
