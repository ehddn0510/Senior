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
    private Integer healthinfoId;         // PK, Auto Increment
    private String diseaseName;          // 질병 이름
    private String diseaseDescription;   // 질병 설명
    private Integer seniorId;            // Foreign Key (senior 테이블 참조)
}
