package edu.sm.controller;

import edu.sm.model.Careworker;
import edu.sm.model.Senior;
import edu.sm.service.CareworkerService;
import edu.sm.service.SeniorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/careworker")
public class CareworkerController {
    private final SeniorService seniorService;
    private final CareworkerService careworkerService;

    @RequestMapping("/")
    public String careworker(Model model) {
        model.addAttribute("center", "careworker/list");
        return "index";
    }

    @RequestMapping("/search")
    public String searchPage(Model model) {
        model.addAttribute("center", "careworker/search");
        return "index";
    }

    @RequestMapping("/mypage")
    public String Mypage(HttpSession session, Model model) {
        Integer cwId = (Integer) session.getAttribute("principal"); // 세션에서 principal 가져오기
        if (cwId == null) {
            log.warn("No principal found in session. Redirecting to login.");
            return "redirect:/login/careworker";
        }
        model.addAttribute("cwId", cwId); // JSP에서 사용할 cwId 추가
        model.addAttribute("center", "careworker/mypage");
        return "index";
    }



    @RequestMapping("/careworkers")
    public String careworkerList(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user";
        }

        try {
            List<Senior> seniors = seniorService.getSeniorsByUserId(userId);

            model.addAttribute("seniors", seniors);
            model.addAttribute("center", "user/careworker/careworkerlist");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "index";
    }

    @RequestMapping("/careworkers/{id}")
    public String cwDetail(@PathVariable Integer id, HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        log.info("sessoionId: {}", userId);
        if (userId == null) {
            log.info("session is null");
            return "redirect:/";
        }

        try {
            Careworker careworker = careworkerService.get(id);
            if (careworker == null) {
                return "redirect:/";
            }

            log.info("careworker: {}", careworker);

            model.addAttribute("careworker", careworker);
            model.addAttribute("center", "user/careworker/detail");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }
}
