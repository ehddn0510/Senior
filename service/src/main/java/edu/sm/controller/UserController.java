package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j

@RequestMapping("/user")
public class UserController {

    @RequestMapping("/video")
    public String video(Model model) {
        model.addAttribute("center", "user/video");
        return "index";
    }



}
