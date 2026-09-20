package com.smarthouse.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smarthouse.entity.User;
import com.smarthouse.service.UserService;

@Controller
@RequestMapping("/user/profile")
public class UserProfileController {

    private final UserService userService;

    public UserProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public String showProfile(
            Principal principal,
            Model model) {

        User user =
                userService.getUserByEmail(
                        principal.getName());

        model.addAttribute(
                "user",
                user);

        return "user/profile";
    }

    @PostMapping("/update-name")
    public String updateName(
            @RequestParam("name") String name,
            Principal principal,
            RedirectAttributes redirectAttributes) {

        try {

            userService.updateName(
                    principal.getName(),
                    name);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Profile name updated successfully.");

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage());
        }

        return "redirect:/user/profile";
    }

    @PostMapping("/change-password")
    public String changePassword(
            @RequestParam("currentPassword")
            String currentPassword,

            @RequestParam("newPassword")
            String newPassword,

            @RequestParam("confirmPassword")
            String confirmPassword,

            Principal principal,
            RedirectAttributes redirectAttributes) {

        try {

            userService.changePassword(
                    principal.getName(),
                    currentPassword,
                    newPassword,
                    confirmPassword);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Password changed successfully.");

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage());
        }

        return "redirect:/user/profile";
    }
}