package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class License {
    private int licenseId;             // Primary Key
    private String licenseName;        // 자격증 이름
    private LocalDateTime licenseStartDate; // 자격증 시작 날짜
    private LocalDateTime licenseEndDate;   // 자격증 종료 날짜
    private String licenseStatus;     // 자격증 상태 (1: 활성, 0: 비활성)
    private int cwId;                  // Careworker ID (Foreign Key)
}
