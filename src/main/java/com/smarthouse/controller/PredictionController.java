package com.smarthouse.controller;

import java.security.Principal;

import jakarta.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smarthouse.dto.PredictionRequest;
import com.smarthouse.entity.Location;
import com.smarthouse.entity.PropertyType;
import com.smarthouse.service.HouseService;
import com.smarthouse.service.PredictionHistoryService;
import com.smarthouse.service.PredictionService;

@Controller
@RequestMapping("/user/prediction")
public class PredictionController {

    private final HouseService houseService;

    private final PredictionService predictionService;

    private final PredictionHistoryService predictionHistoryService;


    public PredictionController(
            HouseService houseService,
            PredictionService predictionService,
            PredictionHistoryService predictionHistoryService) {

        this.houseService = houseService;

        this.predictionService = predictionService;

        this.predictionHistoryService = predictionHistoryService;
    }


    // =========================================================
    // SHOW PREDICTION FORM
    // =========================================================

    @GetMapping
    public String showPredictionForm(Model model) {

        model.addAttribute(
                "predictionRequest",
                new PredictionRequest()
        );

        preparePredictionForm(model);

        return "user/prediction-form";
    }


    // =========================================================
    // PROCESS PREDICTION
    // =========================================================

    @PostMapping
    public String predictPrice(

            @Valid
            @ModelAttribute("predictionRequest")
            PredictionRequest predictionRequest,

            BindingResult bindingResult,

            Model model,

            Principal principal) {


        // -----------------------------------------------------
        // VALIDATION
        // -----------------------------------------------------

        if (bindingResult.hasErrors()) {

            preparePredictionForm(model);

            return "user/prediction-form";
        }


        try {

            // -------------------------------------------------
            // GENERATE PRICE PREDICTION
            // -------------------------------------------------

            Double predictedPrice =
                    predictionService.predictPrice(
                            predictionRequest
                    );


            // -------------------------------------------------
            // FIND SELECTED PROPERTY TYPE
            // -------------------------------------------------

            PropertyType propertyType =
                    houseService.getAllPropertyTypes()
                            .stream()
                            .filter(
                                pt -> pt.getId().equals(
                                    predictionRequest
                                        .getPropertyTypeId()
                                )
                            )
                            .findFirst()
                            .orElseThrow(
                                () -> new IllegalArgumentException(
                                    "Selected property type was not found."
                                )
                            );


            // -------------------------------------------------
            // FIND SELECTED LOCATION
            // -------------------------------------------------

            Location location =
                    houseService.getAllLocations()
                            .stream()
                            .filter(
                                loc -> loc.getId().equals(
                                    predictionRequest
                                        .getLocationId()
                                )
                            )
                            .findFirst()
                            .orElseThrow(
                                () -> new IllegalArgumentException(
                                    "Selected location was not found."
                                )
                            );


            // -------------------------------------------------
            // SAVE PREDICTION HISTORY
            // -------------------------------------------------

            predictionHistoryService.savePrediction(
                    predictionRequest,
                    predictedPrice,
                    principal.getName()
            );


            // -------------------------------------------------
            // SEND DATA TO RESULT PAGE
            // -------------------------------------------------

            model.addAttribute(
                    "predictedPrice",
                    predictedPrice
            );

            model.addAttribute(
                    "predictionRequest",
                    predictionRequest
            );

            model.addAttribute(
                    "propertyType",
                    propertyType
            );

            model.addAttribute(
                    "location",
                    location
            );


            // -------------------------------------------------
            // SHOW RESULT
            // -------------------------------------------------

            return "user/prediction-result";


        } catch (IllegalArgumentException exception) {


            // -------------------------------------------------
            // BUSINESS ERROR
            // -------------------------------------------------

            preparePredictionForm(model);

            model.addAttribute(
                    "predictionError",
                    exception.getMessage()
            );

            return "user/prediction-form";
        }
    }


    // =========================================================
    // LOAD FORM DATA
    // =========================================================

    private void preparePredictionForm(Model model) {

        model.addAttribute(
                "propertyTypes",
                houseService.getAllPropertyTypes()
        );


        model.addAttribute(
                "locations",
                houseService.getAllLocations()
        );
    }
}