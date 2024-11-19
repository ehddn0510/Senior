package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Senior;
import edu.sm.service.SeniorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
public class SeniorApiController {

    private final SeniorService seniorService;

    @PostMapping("/api/senior/updateSenior")
    public ResponseDto<Integer> updateSenior(@ModelAttribute Senior senior) {
        log.info("Received Senior data: {}", senior); // Senior 객체의 내용 확인
        try {
            seniorService.modifyById(senior.getSeniorId(), senior);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (IllegalArgumentException e) {
            log.error("잘못된 입력 값입니다.", e);
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), 0);
        } catch (Exception e) {
            log.error("예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }
}
