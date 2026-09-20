package com.smarthouse.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.smarthouse.dto.PredictionRequest;
import com.smarthouse.entity.Location;
import com.smarthouse.entity.Prediction;
import com.smarthouse.entity.PropertyType;
import com.smarthouse.entity.User;
import com.smarthouse.repository.LocationRepository;
import com.smarthouse.repository.PredictionRepository;
import com.smarthouse.repository.PropertyTypeRepository;
import com.smarthouse.repository.UserRepository;

@Service
public class PredictionHistoryService {

    private final PredictionRepository predictionRepository;
    private final UserRepository userRepository;
    private final LocationRepository locationRepository;
    private final PropertyTypeRepository propertyTypeRepository;

    public PredictionHistoryService(
            PredictionRepository predictionRepository,
            UserRepository userRepository,
            LocationRepository locationRepository,
            PropertyTypeRepository propertyTypeRepository) {

        this.predictionRepository = predictionRepository;
        this.userRepository = userRepository;
        this.locationRepository = locationRepository;
        this.propertyTypeRepository = propertyTypeRepository;
    }

    public void savePrediction(
            PredictionRequest request,
            Double predictedPrice,
            String email) {

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException(
                        "User account not found."));

        Location location = locationRepository
                .findById(request.getLocationId())
                .orElseThrow(() -> new IllegalArgumentException(
                        "Selected location does not exist."));

        PropertyType propertyType = propertyTypeRepository
                .findById(request.getPropertyTypeId())
                .orElseThrow(() -> new IllegalArgumentException(
                        "Selected property type does not exist."));

        Prediction prediction = new Prediction();

        prediction.setArea(request.getArea());
        prediction.setBedrooms(request.getBedrooms());
        prediction.setBathrooms(request.getBathrooms());
        prediction.setFloors(request.getFloors());
        prediction.setFurnishing(request.getFurnishing());

        prediction.setPredictedPrice(predictedPrice);

        prediction.setPredictedAt(LocalDateTime.now());

        prediction.setUser(user);
        prediction.setLocation(location);
        prediction.setPropertyType(propertyType);

        predictionRepository.save(prediction);
    }

    public List<Prediction> getUserPredictions(String email) {

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException(
                        "User account not found."));

        return predictionRepository
                .findByUserIdOrderByPredictedAtDesc(user.getId());
    }
}