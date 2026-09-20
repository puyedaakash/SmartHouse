package com.smarthouse.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.smarthouse.service.ComparisonService;
import com.smarthouse.service.FavoriteService;
import com.smarthouse.service.HouseService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/properties")
public class PropertyController {

    private final HouseService houseService;
    private final FavoriteService favoriteService;
    private final ComparisonService comparisonService;

    public PropertyController(
            HouseService houseService,
            FavoriteService favoriteService,
            ComparisonService comparisonService) {

        this.houseService = houseService;
        this.favoriteService = favoriteService;
        this.comparisonService = comparisonService;
    }

    @GetMapping
    public String listProperties(Model model) {

        prepareFilterData(model);

        model.addAttribute(
                "houses",
                houseService.getAllHouses());

        return "home/property-list";
    }

    @GetMapping("/search")
    public String searchProperties(
            @RequestParam(value = "keyword", required = false)
            String keyword,

            @RequestParam(value = "propertyTypeId", required = false)
            Long propertyTypeId,

            @RequestParam(value = "locationId", required = false)
            Long locationId,

            @RequestParam(value = "minPrice", required = false)
            Double minPrice,

            @RequestParam(value = "maxPrice", required = false)
            Double maxPrice,

            @RequestParam(value = "bedrooms", required = false)
            Integer bedrooms,

            Model model) {

        model.addAttribute(
                "houses",
                houseService.searchProperties(
                        keyword,
                        propertyTypeId,
                        locationId,
                        minPrice,
                        maxPrice,
                        bedrooms));

        model.addAttribute("keyword", keyword);
        model.addAttribute("propertyTypeId", propertyTypeId);
        model.addAttribute("locationId", locationId);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("bedrooms", bedrooms);

        prepareFilterData(model);

        return "home/property-list";
    }

    @GetMapping("/{id}")
    public String propertyDetails(
            @PathVariable Long id,
            Model model,
            Principal principal,
            HttpSession session) {

        model.addAttribute(
                "house",
                houseService.getHouseById(id));

        boolean isFavorite = false;
        boolean isInComparison = false;

        if (principal != null) {

            isFavorite =
                    favoriteService.isFavorite(
                            principal.getName(),
                            id);

            isInComparison =
                    comparisonService.isInComparison(
                            session,
                            id);
        }

        model.addAttribute(
                "isFavorite",
                isFavorite);

        model.addAttribute(
                "isInComparison",
                isInComparison);

        return "home/property-details";
    }

    private void prepareFilterData(Model model) {

        model.addAttribute(
                "propertyTypes",
                houseService.getAllPropertyTypes());

        model.addAttribute(
                "locations",
                houseService.getAllLocations());
    }
}