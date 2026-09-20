package com.smarthouse.controller.admin;

import com.smarthouse.repository.UserRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    private final UserRepository userRepository;

    public AdminController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping("/admin/dashboard")
    public String dashboard(Model model) {

        model.addAttribute("pageTitle", "Admin Dashboard");

        return "admin/dashboard";
    }

    @GetMapping("/admin/users")
    public String manageUsers(Model model) {

        model.addAttribute("pageTitle", "Manage Users");

        model.addAttribute(
                "users",
                userRepository.findAll()
        );

        return "admin/manage-users";
    }
}