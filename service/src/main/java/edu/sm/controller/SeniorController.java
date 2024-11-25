package edu.sm.controller;

import edu.sm.model.HealthInfo;
import edu.sm.model.Senior;
import edu.sm.service.HealthinfoService;
import edu.sm.service.SeniorService;
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
@RequestMapping("/senior")
public class SeniorController {
    private final SeniorService seniorService;
    private final HealthinfoService healthinfoService;

    @RequestMapping({"/", ""})
    public String senior(Model model) {
        model.addAttribute("center", "senior/list");
        return "index";
    }

    @RequestMapping("/insert")
    public String list(Model model) {
        model.addAttribute("center", "senior/insert");
        return "index";
    }

    @RequestMapping("/{id}")
    public String detail(@PathVariable Integer id, Model model) {
        Senior senior = null;
        List<HealthInfo> healthinfo = null;
        try {
            senior = seniorService.get(id);
            log.info("Senior: {}", senior);
            healthinfo = healthinfoService.getHealthInfoBySeniorId(id);
            log.info("HealthInfo: {}", healthinfo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        model.addAttribute("center", "senior/detail");
        model.addAttribute("senior", senior);
        model.addAttribute("healthinfo", healthinfo);
        return "index";
    }

}
