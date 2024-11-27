package edu.sm.controller;

import edu.sm.model.Senior;
import edu.sm.model.User;
import edu.sm.service.SeniorService;
import edu.sm.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
    private final UserService userService;
    private final SeniorService seniorService;

    @GetMapping("/seniors")
    public String seniors(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");

        if (userId == null) {
            return "redirect:/login/user"; // 로그인 페이지로 리다이렉트
        }

        List<Senior> seniors = null;
        try {
            seniors = seniorService.getSeniorsByUserId(userId);
        }catch (Exception e) {
            throw new RuntimeException(e);
        }
        model.addAttribute("seniors", seniors);
        model.addAttribute("center", "user/seniorlist");
        return "index";
    }

    @RequestMapping("/video")
    public String video(Model model) {
        model.addAttribute("center", "user/video");
        return "index";
    }



}
