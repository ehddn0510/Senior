package edu.sm.controller;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
public class MainController {

    @RequestMapping("/")
    public String main(Model model) {
        log.info("Start Main");
        return "index"; // 메인 페이지로 이동
    }

    @RequestMapping("/login/user")
    public String loginUser(Model model) {
        model.addAttribute("center", "auth/login/user");
        return "index";
    }


    @RequestMapping("/login/careworker")
    public String loginCareworker(Model model) {
        model.addAttribute("center", "auth/login/careworker");
        return "index";
    }

    @RequestMapping("/signup/user")
    public String signupUser(Model model) {
        model.addAttribute("center", "auth/signup/user");
        return "index";
    }

    @RequestMapping("/signup/careworker")
    public String signupCareworker(Model model) {
        model.addAttribute("center", "auth/signup/careworker");
        return "index";
    }

    @RequestMapping("/user/mypage")
    public String Mypage(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user";
        }
        model.addAttribute("userId", userId); // userId 모델 추가
        model.addAttribute("center", "user/mypage"); // center 속성 추가
        return "index";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 초기화 (로그아웃 처리)
        return "redirect:/"; // 메인 페이지로 리다이렉트
    }

    @RequestMapping("/senior/manage")
    public String seniorManage(HttpSession session, Model model) {
        // 로그인 여부 확인
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user"; // 로그인 페이지로 리다이렉트
        }

        // 모델에 데이터 추가
        model.addAttribute("userId", userId); // 사용자 ID를 모델에 추가
        model.addAttribute("center", "senior/manage"); // center 속성 추가

        return "index"; // 메인 레이아웃 JSP 반환
    }

    @RequestMapping("/senior/info")
    public String seniorInfo(Model model) {
        model.addAttribute("center", "senior/info");
        return "index";
    }

    @RequestMapping("/about")
    public String about(Model model) {
        return "about"; // About 페이지로 이동
    }

    @RequestMapping("/contact")
    public String contact(Model model) {
        return "contact"; // Contact 페이지로 이동
    }

    @RequestMapping("/team")
    public String team(Model model) {
        return "team"; // Team 페이지로 이동
    }

    @RequestMapping("/why")
    public String why(Model model) {
        return "why"; // Why Choose Us 페이지로 이동
    }

    @RequestMapping("/client")
    public String client(Model model) {
        return "client";
    }
}
