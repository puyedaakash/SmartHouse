package com.smarthouse.controller;

import jakarta.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smarthouse.dto.RegistrationRequest;
import com.smarthouse.service.UserService;

@Controller
@RequestMapping("/")
public class AuthController {

    private final UserService userService;


    public AuthController(UserService userService) {
        this.userService = userService;
    }


    @GetMapping("/register")
    public String showRegistrationForm(Model model) {

        if (!model.containsAttribute("registrationRequest")) {

            model.addAttribute(
                    "registrationRequest",
                    new RegistrationRequest()
            );
        }

        return "auth/register";
    }


    @PostMapping("/register")
    public String registerUser(
            @Valid
            @ModelAttribute("registrationRequest")
            RegistrationRequest registrationRequest,

            BindingResult bindingResult,

            Model model) {


        /*
         * Stop processing when field validation fails.
         */

        if (bindingResult.hasErrors()) {

            return "auth/register";
        }


        /*
         * Password confirmation.
         */

        if (!registrationRequest.getPassword()
                .equals(registrationRequest.getConfirmPassword())) {

            model.addAttribute(
                    "registrationError",
                    "Password and confirm password must match."
            );

            return "auth/register";
        }


        /*
         * Check duplicate email.
         */

        if (userService.existsByEmail(
                registrationRequest.getEmail())) {

            model.addAttribute(
                    "registrationError",
                    "An account with this email already exists."
            );

            return "auth/register";
        }


        /*
         * Create user.
         */

        userService.registerUser(registrationRequest);


        /*
         * Registration successful.
         */

        return "redirect:/login?registered=true";
    }
}