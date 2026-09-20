package com.smarthouse.controller;



import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smarthouse.service.PredictionHistoryService;

@Controller
@RequestMapping("/user/prediction-history")
public class PredictionHistoryController {

    private final PredictionHistoryService predictionHistoryService;

    public PredictionHistoryController(
            PredictionHistoryService predictionHistoryService) {

        this.predictionHistoryService =
                predictionHistoryService;
    }

    @GetMapping
    public String predictionHistory(
            Principal principal,
            Model model) {

        model.addAttribute(
                "predictions",
                predictionHistoryService
                        .getUserPredictions(
                                principal.getName()));

        return "user/prediction-history";
    }
}