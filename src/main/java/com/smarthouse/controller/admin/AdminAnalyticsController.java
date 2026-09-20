package com.smarthouse.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smarthouse.dto.AdminDashboardStats;
import com.smarthouse.service.AdminAnalyticsService;
import com.smarthouse.service.HouseService;
import com.smarthouse.util.PriceFormatter;

@Controller
@RequestMapping("/admin")
public class AdminAnalyticsController {

    private final AdminAnalyticsService adminAnalyticsService;
    private final HouseService houseService;

    public AdminAnalyticsController(
            AdminAnalyticsService adminAnalyticsService,
            HouseService houseService) {

        this.adminAnalyticsService = adminAnalyticsService;
        this.houseService = houseService;
    }

    @GetMapping("/analytics")
    public String showAnalytics(Model model) {

        // Get dashboard statistics
        AdminDashboardStats stats =
                adminAnalyticsService.getDashboardStats();

        model.addAttribute("stats", stats);

        // Format property prices
        model.addAttribute(
                "averagePropertyPriceFormatted",
                PriceFormatter.format(
                        stats.getAveragePropertyPrice()
                )
        );

        model.addAttribute(
                "highestPropertyPriceFormatted",
                PriceFormatter.format(
                        stats.getHighestPropertyPrice()
                )
        );

        model.addAttribute(
                "lowestPropertyPriceFormatted",
                PriceFormatter.format(
                        stats.getLowestPropertyPrice()
                )
        );

        // Property analytics
        model.addAttribute(
                "propertyTypeAnalytics",
                houseService.getPropertyTypeAnalytics()
        );

        model.addAttribute(
                "cityAnalytics",
                houseService.getCityAnalytics()
        );

        model.addAttribute(
                "districtAnalytics",
                houseService.getDistrictAnalytics()
        );

        model.addAttribute(
                "stateAnalytics",
                houseService.getStateAnalytics()
        );

        return "admin/analytics";
    }
}