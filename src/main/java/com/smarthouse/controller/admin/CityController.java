package com.smarthouse.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smarthouse.service.CityService;
import com.smarthouse.service.DistrictService;

@Controller
@RequestMapping("/admin/cities")
public class CityController {

    private final CityService cityService;
    private final DistrictService districtService;

    public CityController(
            CityService cityService,
            DistrictService districtService) {

        this.cityService = cityService;
        this.districtService = districtService;
    }


    @GetMapping
    public String listCities(Model model) {

        model.addAttribute(
                "cities",
                cityService.getAllCities()
        );

        model.addAttribute(
                "districts",
                districtService.getAllDistricts()
        );

        return "admin/city-list";
    }


    @PostMapping("/save")
    public String saveCity(
            @RequestParam String name,
            @RequestParam Long districtId,
            Model model) {

        try {

            cityService.saveCity(
                    name,
                    districtId
            );

            return "redirect:/admin/cities?success=true";

        } catch (IllegalArgumentException e) {

            model.addAttribute(
                    "error",
                    e.getMessage()
            );

            model.addAttribute(
                    "cities",
                    cityService.getAllCities()
            );

            model.addAttribute(
                    "districts",
                    districtService.getAllDistricts()
            );

            return "admin/city-list";
        }
    }


    @GetMapping("/delete/{id}")
    public String deleteCity(
            @PathVariable Long id) {

        try {

            cityService.deleteCity(id);

            return "redirect:/admin/cities?deleted=true";

        } catch (IllegalArgumentException e) {

            return "redirect:/admin/cities?error=true";
        }
    }
}