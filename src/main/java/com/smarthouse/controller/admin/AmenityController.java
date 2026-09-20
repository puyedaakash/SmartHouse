package com.smarthouse.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smarthouse.entity.Amenity;
import com.smarthouse.service.AmenityService;

@Controller
@RequestMapping("/admin/amenities")
public class AmenityController {

    private final AmenityService amenityService;

    public AmenityController(AmenityService amenityService) {
        this.amenityService = amenityService;
    }

    @GetMapping
    public String listAmenities(Model model) {

        model.addAttribute(
                "amenities",
                amenityService.getAllAmenities());

        return "admin/amenity-list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {

        model.addAttribute(
                "amenity",
                new Amenity());

        return "admin/amenity-form";
    }

    @PostMapping("/save")
    public String saveAmenity(
            @ModelAttribute("amenity") Amenity amenity,
            RedirectAttributes redirectAttributes) {

        try {

            amenityService.saveAmenity(amenity);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Amenity saved successfully.");

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage());
        }

        return "redirect:/admin/amenities";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(
            @PathVariable Long id,
            Model model) {

        model.addAttribute(
                "amenity",
                amenityService.getAmenityById(id));

        return "admin/amenity-form";
    }

    @PostMapping("/delete/{id}")
    public String deleteAmenity(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        try {

            amenityService.deleteAmenity(id);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Amenity deleted successfully.");

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage());
        }

        return "redirect:/admin/amenities";
    }
}