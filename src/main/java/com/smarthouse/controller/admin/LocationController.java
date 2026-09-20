package com.smarthouse.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smarthouse.service.CityService;
import com.smarthouse.service.LocationService;

@Controller
@RequestMapping("/admin/locations")
public class LocationController {

    private final LocationService locationService;
    private final CityService cityService;

    public LocationController(
            LocationService locationService,
            CityService cityService) {

        this.locationService = locationService;
        this.cityService = cityService;
    }


    @GetMapping
    public String listLocations(Model model) {

        model.addAttribute(
                "locations",
                locationService.getAllLocations()
        );

        model.addAttribute(
                "cities",
                cityService.getAllCities()
        );

        return "admin/location-list";
    }


    @PostMapping("/save")
    public String saveLocation(
            @RequestParam String name,
            @RequestParam Long cityId,
            Model model) {

        try {

            locationService.saveLocation(
                    name,
                    cityId
            );

            return "redirect:/admin/locations?success=true";

        } catch (IllegalArgumentException e) {

            model.addAttribute(
                    "error",
                    e.getMessage()
            );

            model.addAttribute(
                    "locations",
                    locationService.getAllLocations()
            );

            model.addAttribute(
                    "cities",
                    cityService.getAllCities()
            );

            return "admin/location-list";
        }
    }


    @GetMapping("/delete/{id}")
    public String deleteLocation(
            @PathVariable Long id) {

        try {

            locationService.deleteLocation(id);

            return "redirect:/admin/locations?deleted=true";

        } catch (IllegalArgumentException e) {

            return "redirect:/admin/locations?error=true";
        }
    }
}