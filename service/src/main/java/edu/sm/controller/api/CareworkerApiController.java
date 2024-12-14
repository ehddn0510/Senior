package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Careworker;
import edu.sm.model.License;
import edu.sm.model.User;
import edu.sm.service.CareworkerService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/careworkers")
public class CareworkerApiController {

    private final CareworkerService careworkerService;

    // 사용자 정보 조회 API 엔드포인트
    @GetMapping("/{cwId}")
    public ResponseDto<Careworker> getUser(@PathVariable int cwId) {
        try {
            log.info("Careworker 요청 ID: {}", cwId);
            Careworker careworker = careworkerService.get(cwId);
            log.info("조회된 Careworker: {}", careworker);
            return new ResponseDto<>(HttpStatus.OK.value(), careworker);
        } catch (Exception e) {
            log.error("사용자 조회 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), null);
        }
    }


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
            session.setAttribute("name", principal.getCwName());
            session.setAttribute("principal", principal.getCwId()); // 세션에 Careworker ID 저장
            session.setAttribute("role", "CAREWORKER"); // 역할 정보 저장
            return new ResponseDto<>(HttpStatus.OK.value(), "1");
        } catch (IllegalArgumentException e) {
            return new ResponseDto<>(HttpStatus.UNAUTHORIZED.value(), e.getMessage());
        } catch (Exception e) {
            log.error("로그인 중 예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "예기치 않은 오류 발생");
        }
    }

    @GetMapping("/nearby")
    public List<Careworker> findNearbyCareworkers(
            @RequestParam Double latitude,
            @RequestParam Double longitude,
            @RequestParam Double radius
    ) {
        List<Careworker> careworkers = null;
        try {
            careworkers = careworkerService.getCareworkersWithinRadius(latitude, longitude, radius);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        log.info(careworkers.toString());
        return careworkers;
    }

    // 회원 정보 수정 (비밀번호 제외)
    @PutMapping("/update/{id}")
    public ResponseDto<Integer> updatecwInfo(@PathVariable Integer id, @RequestBody Careworker careworker) {
        try {
            log.info("수정 요청 데이터: {}", careworker);
            careworkerService.modifyById(id, careworker);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            log.error("회원 정보 수정 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    //비밀번호 변경
    @PutMapping("/update/password/{id}")
    public ResponseDto<Integer> updatePassword(@PathVariable Integer id, @RequestBody String newPassword) {
        try {
            log.info(newPassword);
            careworkerService.updatePassword(id, newPassword); // 비밀번호 수정 서비스 호출
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            log.error("비밀번호 수정 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 유저 상태를 inactive로 설정하여 "소프트 삭제" 처리
    @DeleteMapping("/delete/{id}")
    public ResponseDto<Integer> delete(@PathVariable Integer id) {
        try {
            careworkerService.del(id); // 상태를 inactive로 변경
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 1 반환
        } catch (Exception e) {
            log.error("유저 소프트 삭제 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 특정 Careworker의 자격증 목록 조회
    @GetMapping("/{cwId}/licenses")
    public ResponseDto<List<License>> getLicensesByCareworkerId(@PathVariable int cwId) {
        try {
            log.info("Careworker ID로 자격증 조회 요청: {}", cwId);

            List<License> licenses = careworkerService.getLicensesByCareworkerId(cwId);

            if (licenses == null || licenses.isEmpty()) {
                log.info("Careworker ID {}에 대한 자격증이 없습니다.", cwId);
                return new ResponseDto<>(HttpStatus.OK.value(), new ArrayList<>()); // 빈 리스트 반환
            }

            log.info("조회된 자격증 목록: {}", licenses);
            return new ResponseDto<>(HttpStatus.OK.value(), licenses);

        } catch (Exception e) {
            log.error("자격증 조회 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), null);
        }
    }

    // Careworker에 자격증 추가
    @PostMapping("/{cwId}/licenses")
    public ResponseDto<String> addLicense(@PathVariable int cwId, @RequestBody License license) {
        try {
            license.setCwId(cwId); // Careworker ID 설정
            careworkerService.addLicense(license); // 서비스에서 자격증 추가
            log.info("자격증 추가 완료: {}", license);
            return new ResponseDto<>(HttpStatus.OK.value(), "자격증이 성공적으로 추가되었습니다.");
        } catch (IllegalArgumentException e) {
            log.error("자격증 추가 중 잘못된 요청: {}", e.getMessage());
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        } catch (Exception e) {
            log.error("자격증 추가 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "자격증 추가 중 오류가 발생했습니다.");
        }
    }
}
