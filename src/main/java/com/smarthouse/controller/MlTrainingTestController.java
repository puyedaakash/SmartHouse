package com.smarthouse.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smarthouse.ml.LinearRegressionModel;
import com.smarthouse.ml.LinearRegressionTrainer;

@RestController
@RequestMapping("/ml")
public class MlTrainingTestController {

    private final LinearRegressionTrainer trainer;

    public MlTrainingTestController(
            LinearRegressionTrainer trainer) {

        this.trainer = trainer;
    }

    @GetMapping("/train")
    public String trainModel() {

        LinearRegressionModel model =
                trainer.train();

        StringBuilder response =
                new StringBuilder();

        response.append(
                "Linear Regression Model Trained Successfully!\n\n");

        response.append(
                "Training Records: ")
                .append(model.getTrainingRecords())
                .append("\n");

        response.append(
                "R² Score: ")
                .append(model.getR2Score())
                .append("\n");

        response.append(
                "MAE: ₹")
                .append(
                        String.format(
                                "%.2f",
                                model.getMae()))
                .append("\n");

        response.append(
                "RMSE: ₹")
                .append(
                        String.format(
                                "%.2f",
                                model.getRmse()))
                .append("\n");

        response.append(
                "\nIntercept: ")
                .append(model.getIntercept());

        return response.toString();
    }
}