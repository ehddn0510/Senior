package edu.sm.controller;

import edu.sm.model.Careworker;
import edu.sm.model.License;
import edu.sm.service.CareworkerService;
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
public class CareworkerController {
    final CareworkerService careworkerService;
    String dir = "careworker/";

    // 상태가 waiting 이 아닌 보호사 목록
    @RequestMapping("/careworker-list")
    public String list(Model model, HttpSession session) throws Exception {
        List<Careworker> user = careworkerService.get();
        log.info(user.toString());
        model.addAttribute("user", user);
        model.addAttribute("center", dir + "careworkerList");
        return "index";
    }

    @RequestMapping("/careworker-waitinglist")
    public String waitlist(Model model, HttpSession session) throws Exception {
        // 서비스에서 waiting 상태 보호사와 자격증 데이터를 가져옴
        List<Careworker> careworkers = careworkerService.findWaitingWithLicenses();
        log.info("Waiting Careworkers with Licenses: {}", careworkers);

        // 모델에 데이터 추가
        model.addAttribute("careworkers", careworkers);

        // center에 JSP 경로 지정
        model.addAttribute("center", dir + "careworkerWaitingList");
        return "index";
    }

    @RequestMapping("/careworker-detail")
    public String detail(Model model, @RequestParam("id") Integer cwId) throws Exception {
        Careworker careworker = careworkerService.get(cwId);
        List<License> licenses = careworkerService.getLicensesByCareworkerId(cwId);

        model.addAttribute("user", careworker);
        model.addAttribute("licenses", licenses);

        model.addAttribute("center", dir + "careworkerDetail");
        return "index";
    }

    @RequestMapping("/careworker-approval")
    public String approval(Model model, @RequestParam("id") Integer cwId) throws Exception {
        Careworker careworker = careworkerService.get(cwId);
        List<License> licenses = careworkerService.getLicensesByCareworkerId(cwId);
        log.info("Careworker Approval: " + careworker.toString());
        log.info("Licenses: " + licenses.toString());
        model.addAttribute("user", careworker);
        model.addAttribute("licenses", licenses);
        // 승인 페이지로 연결
        model.addAttribute("center", dir + "careworkerApproval");
        return "index";
    }

}
