package com.smarthouse.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.smarthouse.entity.Favorite;
import com.smarthouse.entity.House;
import com.smarthouse.entity.User;
import com.smarthouse.repository.FavoriteRepository;
import com.smarthouse.repository.HouseRepository;
import com.smarthouse.repository.UserRepository;

@Service
public class FavoriteService {

    private final FavoriteRepository favoriteRepository;
    private final UserRepository userRepository;
    private final HouseRepository houseRepository;

    public FavoriteService(
            FavoriteRepository favoriteRepository,
            UserRepository userRepository,
            HouseRepository houseRepository) {

        this.favoriteRepository = favoriteRepository;
        this.userRepository = userRepository;
        this.houseRepository = houseRepository;
    }

    public List<Favorite> getUserFavorites(String email) {

        User user = userRepository.findByEmail(email)
                .orElseThrow(() ->
                        new IllegalArgumentException("User not found."));

        return favoriteRepository.findByUserId(user.getId());
    }

    public boolean isFavorite(String email, Long houseId) {

        User user = userRepository.findByEmail(email)
                .orElseThrow(() ->
                        new IllegalArgumentException("User not found."));

        return favoriteRepository
                .existsByUserIdAndHouseId(user.getId(), houseId);
    }

    @Transactional
    public void addFavorite(String email, Long houseId) {

        User user = userRepository.findByEmail(email)
                .orElseThrow(() ->
                        new IllegalArgumentException("User not found."));

        House house = houseRepository.findById(houseId)
                .orElseThrow(() ->
                        new IllegalArgumentException("House not found."));

        boolean alreadyFavorite =
                favoriteRepository.existsByUserIdAndHouseId(
                        user.getId(),
                        houseId);

        if (alreadyFavorite) {
            return;
        }

        Favorite favorite = new Favorite(user, house);

        favoriteRepository.save(favorite);
    }

    @Transactional
    public void removeFavorite(String email, Long houseId) {

        User user = userRepository.findByEmail(email)
                .orElseThrow(() ->
                        new IllegalArgumentException("User not found."));

        favoriteRepository.deleteByUserIdAndHouseId(
                user.getId(),
                houseId);
    }

    @Transactional
    public void toggleFavorite(String email, Long houseId) {

        if (isFavorite(email, houseId)) {
            removeFavorite(email, houseId);
        } else {
            addFavorite(email, houseId);
        }
    }
}