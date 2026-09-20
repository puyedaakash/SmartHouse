package com.smarthouse.service;

import org.springframework.stereotype.Service;

import com.smarthouse.dto.PredictionRequest;
import com.smarthouse.entity.Location;
import com.smarthouse.entity.PropertyType;
import com.smarthouse.ml.HouseDataPreprocessor;
import com.smarthouse.ml.HouseTrainingData;
import com.smarthouse.ml.LinearRegressionModel;
import com.smarthouse.ml.LinearRegressionTrainer;
import com.smarthouse.repository.LocationRepository;
import com.smarthouse.repository.PropertyTypeRepository;

import java.util.List;

@Service
public class PredictionService {

    private final LocationRepository locationRepository;

    private final PropertyTypeRepository propertyTypeRepository;

    private final LinearRegressionTrainer trainer;

    private final HouseDataPreprocessor preprocessor;

    public PredictionService(
            LocationRepository locationRepository,
            PropertyTypeRepository propertyTypeRepository,
            LinearRegressionTrainer trainer,
            HouseDataPreprocessor preprocessor) {

        this.locationRepository =
                locationRepository;

        this.propertyTypeRepository =
                propertyTypeRepository;

        this.trainer =
                trainer;

        this.preprocessor =
                preprocessor;
    }

    public Double predictPrice(
            PredictionRequest request) {

        /*
         * Find selected location
         */

        Location location =
                locationRepository
                        .findById(
                                request.getLocationId())
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "Selected location does not exist."
                                ));

        /*
         * Find selected property type
         */

        PropertyType propertyType =
                propertyTypeRepository
                        .findById(
                                request.getPropertyTypeId())
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "Selected property type does not exist."
                                ));

        /*
         * Train model if necessary.
         */

        LinearRegressionModel model;

        try {

            model =
                    trainer.getTrainedModel();

        } catch (IllegalStateException e) {

            model =
                    trainer.train();
        }

        /*
         * IMPORTANT:
         *
         * Current bootstrap dataset uses city
         * as its location category.
         *
         * Therefore we use the city of the
         * selected SmartHouse location.
         */

        String cityName =
                location.getCity()
                        .getName();

        /*
         * Create temporary training-data object
         * so we can reuse exactly the same
         * preprocessing logic.
         */

        HouseTrainingData input =
                new HouseTrainingData();

        input.setArea(
                request.getArea());

        input.setBedrooms(
                request.getBedrooms());

        input.setBathrooms(
                request.getBathrooms());

        input.setFloors(
                request.getFloors());

        input.setAge(
                request.getAge());

        input.setLocation(
                cityName);

        input.setPropertyType(
                propertyType.getName());

        input.setFurnishing(
                request.getFurnishing());

        /*
         * Convert input into ML features.
         */

        double[] features =
                preprocessor.createFeatureVector(
                        input);

        /*
         * Ask trained Linear Regression model
         * for prediction.
         */

        double predictedPrice =
                model.predict(features);

        /*
         * Prevent negative prices.
         */

        if (predictedPrice < 0) {

            predictedPrice = 0;
        }

        /*
         * Round to nearest rupee.
         */

        return (double)
                Math.round(predictedPrice);
    }
}