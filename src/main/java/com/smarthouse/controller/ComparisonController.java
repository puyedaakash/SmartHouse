package com.smarthouse.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smarthouse.entity.House;
import com.smarthouse.service.ComparisonService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/user/compare")
public class ComparisonController {

    private final ComparisonService comparisonService;

    public ComparisonController(ComparisonService comparisonService) {
        this.comparisonService = comparisonService;
    }

    // Add property to comparison
    @PostMapping("/add/{houseId}")
    public String addToComparison(
            @PathVariable("houseId") Long houseId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        try {
            boolean added = comparisonService.addToComparison(
                    session,
                    houseId
            );

            if (added) {
                redirectAttributes.addFlashAttribute(
                        "successMessage",
                        "Property added to comparison."
                );
            } else {
                redirectAttributes.addFlashAttribute(
                        "infoMessage",
                        "This property is already in your comparison."
                );
            }

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage()
            );
        }

        return "redirect:/properties/" + houseId;
    }

    // Remove property from comparison
    @PostMapping("/remove")
    public String removeFromComparison(
            @RequestParam("houseId") Long houseId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        boolean removed = comparisonService.removeFromComparison(
                session,
                houseId
        );

        if (removed) {
            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Property removed from comparison."
            );
        } else {
            redirectAttributes.addFlashAttribute(
                    "infoMessage",
                    "Property was not in comparison."
            );
        }

        return "redirect:/user/compare";
    }

    // Clear comparison list
    @PostMapping("/clear")
    public String clearComparison(
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        comparisonService.clearComparison(session);

        redirectAttributes.addFlashAttribute(
                "successMessage",
                "Comparison list cleared."
        );

        return "redirect:/user/compare";
    }

    // Display comparison page
    @GetMapping
    public String showComparison(
            HttpSession session,
            Model model) {

        List<House> houses =
                comparisonService.getComparisonProperties(session);

        model.addAttribute("houses", houses);

        model.addAttribute(
                "comparisonCount",
                houses.size()
        );

        model.addAttribute(
                "maxComparisonProperties",
                comparisonService.getMaximumComparisonProperties()
        );

        return "user/compare";
    }
}