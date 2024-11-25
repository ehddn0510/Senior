package edu.sm.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SignalingMessage {
    private String type;
    private Object data; // For simplicity, we use Object here. You can define a specific model class for each type.

    // getters and setters
}