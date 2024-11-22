package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Careworker;
import edu.sm.service.CareworkerService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/careworkers")
public class CareworkerApiController {

    private final CareworkerService careworkerService;

    @PostMapping("/signup")
    public ResponseDto<String> save(@ModelAttribute Careworker careworker) {
        try {
            careworker.setCwProfile(careworker.getCwProfileFile().getOriginalFilename());
            careworkerService.add(careworker);
            return new ResponseDto<>(HttpStatus.OK.value(), "1");
        } catch (IllegalArgumentException e) {
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        } catch (Exception e) {
            log.info(e.getMessage());
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "예기치 않은 오류 발생");
        }
    }

    @PostMapping("/login")
    public ResponseDto<String> login(@RequestBody Careworker careworker, HttpSession session) {
        try {
            Careworker principal = careworkerService.login(careworker);
            session.setAttribute("principal", principal.getCwId());
            session.setAttribute("role", "CAREWORKER");
            return new ResponseDto<>(HttpStatus.OK.value(), "1");
        } catch (IllegalArgumentException e) {
            return new ResponseDto<>(HttpStatus.UNAUTHORIZED.value(), e.getMessage());
        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "예기치 않은 오류 발생");
        }
    }
}
