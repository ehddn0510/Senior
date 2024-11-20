package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j

@RequestMapping("/careworker")
public class CareworkerController {

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



}
