package edu.sm.controller;

import edu.sm.model.Senior;
import edu.sm.model.User;
import edu.sm.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.fasterxml.jackson.databind.ObjectMapper;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class UserController {

    final UserService userService;
    String dir = "user/";

    @RequestMapping("/customer-list")
    public String list(Model model, HttpSession session) throws Exception {
        // 전체 유저 리스트 가져오기
        List<User> user = userService.get();
        // 신규 가입자 추이 데이터 가져오기
        List<Map<String, Object>> signupTrends = userService.getMonthlySignupStats();

        // 현재 시점부터 12개월 데이터 생성
        LocalDate currentMonth = LocalDate.now().withDayOfMonth(1); // 현재 달의 시작
        List<Map<String, Object>> last12Months = new ArrayList<>();

        for (int i = 0; i < 12; i++) {
            String month = currentMonth.minusMonths(11 - i).format(DateTimeFormatter.ofPattern("yyyy-MM"));
            Map<String, Object> monthData = signupTrends.stream()
                    .filter(data -> month.equals(data.get("signup_month")))
                    .findFirst()
                    .orElse(Map.of("signup_month", month, "signup_count", 0)); // 없는 달은 0으로 채움
            last12Months.add(monthData);
        }

        // 현재 active/inactive 비율 데이터 가져오기
        List<Map<String, Object>> userStatusRatio = userService.getUserStatusCount();

        // ObjectMapper를 사용하여 JSON 형식으로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        String signupTrendsJson = objectMapper.writeValueAsString(last12Months);
        String userStatusRatioJson = objectMapper.writeValueAsString(userStatusRatio);

        // JSON 로그 출력
        log.info("Signup Trends (JSON): {}", signupTrendsJson);
        log.info("User Status Ratio (JSON): {}", userStatusRatioJson);

        // Model에 데이터 추가
        model.addAttribute("user", user);
        model.addAttribute("signupTrends", signupTrendsJson);
        model.addAttribute("userStatusRatio", userStatusRatioJson);

        // Center 페이지 설정
        model.addAttribute("center", dir + "userList");

        return "index";
    }


    @RequestMapping("/customer-detail")
    public String detail(Model model, @RequestParam("id") Integer userId) throws Exception {
        User user = userService.get(userId);
        List<Senior> senior = userService.getSeniorsByUserId(userId);
        model.addAttribute("user", user);
        model.addAttribute("senior", senior);
        model.addAttribute("center", dir + "userDetail");
        // 이 위로는 건들지 않는다 ㅇㅋ?

        // 서비스 호출 (변환 전 데이터 로그)
        List<Map<String, Object>> totalContractAmount = userService.getTotalContractAmountByUserId();
        List<Map<String, Object>> seniorCount = userService.getSeniorCountByUserId();
        List<Map<String, Object>> contractRenewalCount = userService.getContractRenewalCountByUserId();

        log.info("Before JSON Conversion - Total Contract Amount: {}", totalContractAmount);
        log.info("Before JSON Conversion - Senior Count: {}", seniorCount);
        log.info("Before JSON Conversion - Contract Renewal Count: {}", contractRenewalCount);

        // ObjectMapper를 사용하여 JSON으로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        String totalContractAmountJson = objectMapper.writeValueAsString(totalContractAmount);
        String seniorCountJson = objectMapper.writeValueAsString(seniorCount);
        String contractRenewalCountJson = objectMapper.writeValueAsString(contractRenewalCount);

        // 변환 후 데이터 로그
        log.info("After JSON Conversion - Total Contract Amount (JSON): {}", totalContractAmountJson);
        log.info("After JSON Conversion - Senior Count (JSON): {}", seniorCountJson);
        log.info("After JSON Conversion - Contract Renewal Count (JSON): {}", contractRenewalCountJson);

        // JSON 데이터를 모델에 추가
        model.addAttribute("totalContractAmount", totalContractAmountJson);
        model.addAttribute("seniorCount", seniorCountJson);
        model.addAttribute("contractRenewalCount", contractRenewalCountJson);

        return "index";
    }

}
