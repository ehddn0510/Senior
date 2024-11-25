package edu.sm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class HealthInfo {
    private Integer healthinfoId;
    private String diseaseName;
    private String diseaseDescription;
    private Integer seniorId;
}
