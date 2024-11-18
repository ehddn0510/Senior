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
    private Integer licenseId;
    private String licenseName;
    private LocalDateTime licenseStartDate;
    private LocalDateTime licenseEndDate;
    private Integer licenseStatus;
}
