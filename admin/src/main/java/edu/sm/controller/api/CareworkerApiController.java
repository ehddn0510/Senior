package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.service.CareworkerService;
import edu.sm.model.Careworker;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
public class CareworkerApiController {

    private final CareworkerService careworkerService;

    @PostMapping("/api/careworker/update")
    public ResponseDto<Integer> updateCareworker(@ModelAttribute Careworker careworker) {
        log.info("Received Careworker data: {}", careworker); // Careworker 객체의 내용 확인
        try {
            careworkerService.modifyById(careworker.getCwId(), careworker);
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 응답
        } catch (IllegalArgumentException e) {
            log.error("잘못된 입력 값입니다.", e);
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), 0); // 잘못된 입력 값 응답
        } catch (Exception e) {
            log.error("예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0); // 서버 오류 응답
        }
    }


    @PostMapping("/api/careworker/approve")
    public ResponseDto<Integer> approveCareworker(@RequestParam("id") Integer cwId) {
        log.info("Received Careworker ID: {}", cwId);
        try {
            careworkerService.activateCareworker(cwId); // 상태를 active로 변경
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 응답
        } catch (Exception e) {
            log.error("Error approving careworker", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0); // 실패 응답
        }
    }
}
