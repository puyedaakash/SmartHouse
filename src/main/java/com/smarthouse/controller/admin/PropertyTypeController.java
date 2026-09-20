package com.smarthouse.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smarthouse.entity.PropertyType;
import com.smarthouse.service.PropertyTypeService;

@Controller
@RequestMapping("/admin/property-types")
public class PropertyTypeController {

    private final PropertyTypeService propertyTypeService;

    public PropertyTypeController(
            PropertyTypeService propertyTypeService) {

        this.propertyTypeService = propertyTypeService;
    }

    @GetMapping
    public String listPropertyTypes(Model model) {

        model.addAttribute(
                "propertyTypes",
                propertyTypeService.getAllPropertyTypes());

        return "admin/property-type-list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {

        model.addAttribute(
                "propertyType",
                new PropertyType());

        return "admin/property-type-form";
    }

    @PostMapping("/save")
    public String savePropertyType(
            @ModelAttribute("propertyType")
            PropertyType propertyType,
            RedirectAttributes redirectAttributes) {

        try {

            propertyTypeService.savePropertyType(propertyType);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Property type saved successfully.");

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage());
        }

        return "redirect:/admin/property-types";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(
            @PathVariable Long id,
            Model model) {

        model.addAttribute(
                "propertyType",
                propertyTypeService.getPropertyTypeById(id));

        return "admin/property-type-form";
    }

    @PostMapping("/delete/{id}")
    public String deletePropertyType(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        try {

            propertyTypeService.deletePropertyType(id);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Property type deleted successfully.");

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage());
        }

        return "redirect:/admin/property-types";
    }
}