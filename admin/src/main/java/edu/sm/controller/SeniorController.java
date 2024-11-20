package edu.sm.controller;

import edu.sm.model.HealthInfo;
import edu.sm.model.Senior;
import edu.sm.service.SeniorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class SeniorController {

    final SeniorService seniorService;
    String dir = "senior/";

    @RequestMapping("/senior-list")
    public String list(Model model, HttpSession session) throws Exception {
        List<Senior> seniors = seniorService.get();
        model.addAttribute("seniors", seniors);
        model.addAttribute("center", dir + "seniorList");
        return "index";
    }

    @RequestMapping("/senior-detail")
    public String detail(Model model, @RequestParam("id") Integer seniorId) throws Exception {
        Senior senior = seniorService.get(seniorId);
        List<HealthInfo> healthInfo = seniorService.getHealthInfoBySeniorId(seniorId);
        log.info(senior.toString());
        log.info("여기 : " + healthInfo.toString());
        model.addAttribute("senior", senior);
        model.addAttribute("healthInfo", healthInfo);
        model.addAttribute("center", dir + "seniorDetail");
        return "index";
    }
}
