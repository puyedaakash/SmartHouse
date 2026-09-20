package com.smarthouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    @GetMapping("/user/dashboard")
    public String dashboard(Model model) {

        model.addAttribute(
                "pageTitle",
                "User Dashboard"
        );

        return "user/dashboard";
    }
}