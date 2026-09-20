package com.smarthouse.service;

import org.springframework.stereotype.Service;

import com.smarthouse.dto.AdminDashboardStats;
import com.smarthouse.repository.FavoriteRepository;
import com.smarthouse.repository.HouseRepository;
import com.smarthouse.repository.PredictionRepository;
import com.smarthouse.repository.UserRepository;

@Service
public class AdminAnalyticsService {

    private final UserRepository userRepository;
    private final HouseRepository houseRepository;
    private final PredictionRepository predictionRepository;
    private final FavoriteRepository favoriteRepository;

    public AdminAnalyticsService(
            UserRepository userRepository,
            HouseRepository houseRepository,
            PredictionRepository predictionRepository,
            FavoriteRepository favoriteRepository) {

        this.userRepository = userRepository;
        this.houseRepository = houseRepository;
        this.predictionRepository = predictionRepository;
        this.favoriteRepository = favoriteRepository;
    }

    public AdminDashboardStats getDashboardStats() {

        long totalUsers = userRepository.count();

        long totalProperties = houseRepository.count();

        long totalPredictions = predictionRepository.count();

        long totalFavorites = favoriteRepository.count();

        double averagePropertyPrice = 0.0;
        double highestPropertyPrice = 0.0;
        double lowestPropertyPrice = 0.0;

        if (totalProperties > 0) {

            var houses = houseRepository.findAll();

            double totalPrice = 0.0;

            highestPropertyPrice = Double.MIN_VALUE;
            lowestPropertyPrice = Double.MAX_VALUE;

            for (var house : houses) {

                if (house.getPrice() != null) {

                    double price = house.getPrice();

                    totalPrice += price;

                    if (price > highestPropertyPrice) {
                        highestPropertyPrice = price;
                    }

                    if (price < lowestPropertyPrice) {
                        lowestPropertyPrice = price;
                    }
                }
            }

            averagePropertyPrice = totalPrice / totalProperties;

        }

        return new AdminDashboardStats(
                totalUsers,
                totalProperties,
                totalPredictions,
                totalFavorites,
                averagePropertyPrice,
                highestPropertyPrice,
                lowestPropertyPrice
        );
    }
}