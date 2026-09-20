package com.smarthouse.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smarthouse.service.FavoriteService;

@Controller
@RequestMapping("/user/favorites")
public class FavoriteController {

    private final FavoriteService favoriteService;

    public FavoriteController(FavoriteService favoriteService) {
        this.favoriteService = favoriteService;
    }

    // Display user's favorite properties
    @GetMapping
    public String showFavorites(Principal principal, Model model) {

        model.addAttribute(
                "favorites",
                favoriteService.getUserFavorites(principal.getName())
        );

        return "user/favorites";
    }

    // Add or remove a property from favorites
    @PostMapping("/toggle/{houseId}")
    public String toggleFavorite(
            @PathVariable("houseId") Long houseId,
            Principal principal,
            RedirectAttributes redirectAttributes) {

        try {
            favoriteService.toggleFavorite(
                    principal.getName(),
                    houseId
            );

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Favorite updated successfully."
            );

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage()
            );
        }

        return "redirect:/user/favorites";
    }
}