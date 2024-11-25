package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/senior")
public class SeniorController {

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
}
