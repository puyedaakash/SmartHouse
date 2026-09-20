package com.smarthouse.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.smarthouse.service.DistrictService;
import com.smarthouse.service.StateService;

@Controller
@RequestMapping("/admin/districts")
public class DistrictController {

    private final DistrictService districtService;
    private final StateService stateService;

    public DistrictController(
            DistrictService districtService,
            StateService stateService) {

        this.districtService = districtService;
        this.stateService = stateService;
    }

    @GetMapping
    public String listDistricts(Model model) {

        model.addAttribute(
            "districts",
            districtService.getAllDistricts()
        );

        model.addAttribute(
            "states",
            stateService.getAllStates()
        );

        return "admin/districts";
    }

    @PostMapping("/save")
    public String saveDistrict(
            @RequestParam String name,
            @RequestParam Long stateId,
            Model model) {

        try {

            districtService.saveDistrict(
                name,
                stateId
            );

            return "redirect:/admin/districts?success=true";

        } catch (IllegalArgumentException e) {

            model.addAttribute(
                "error",
                e.getMessage()
            );

            model.addAttribute(
                "districts",
                districtService.getAllDistricts()
            );

            model.addAttribute(
                "states",
                stateService.getAllStates()
            );

            return "admin/districts";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteDistrict(
            @PathVariable Long id) {

        try {

            districtService.deleteDistrict(id);

            return "redirect:/admin/districts?deleted=true";

        } catch (IllegalArgumentException e) {

            return "redirect:/admin/districts?error=true";
        }
    }
}