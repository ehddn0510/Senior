package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Senior;
import edu.sm.model.User;
import edu.sm.service.SeniorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/senior")
public class SeniorApiController {

    private final SeniorService seniorService;

    @PostMapping("/insert")
    public ResponseDto<String> save(@ModelAttribute Senior senior) throws Exception {
        try {
            senior.setSeniorProfile(senior.getSeniorProfileFile().getOriginalFilename());
            seniorService.add(senior);
            return new ResponseDto<>(HttpStatus.OK.value(), "1");
        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage());
        }
    }

    @PutMapping("/update/{id}")
    public ResponseDto<Integer> update(@PathVariable Integer id, @RequestBody Senior senior) throws Exception {
        seniorService.modifyById(id, senior);
        return new ResponseDto<>(HttpStatus.OK.value(), 1);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseDto<Integer> delete(@PathVariable Integer id) throws Exception {
        seniorService.updateStatusToInactive(id); // 상태를 inactive로 변경
        return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 1 반환
    }

    @GetMapping("/{id}")
    public ResponseDto<Senior> get(@PathVariable Integer id) throws Exception {
        Senior senior = seniorService.get(id);
        return new ResponseDto<>(HttpStatus.OK.value(), senior); // 조회된 시니어 정보 반환
    }
}