package com.smarthouse.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smarthouse.entity.Favorite;

public interface FavoriteRepository extends JpaRepository<Favorite, Long> {

    List<Favorite> findByUserId(Long userId);

    Optional<Favorite> findByUserIdAndHouseId(Long userId, Long houseId);

    boolean existsByUserIdAndHouseId(Long userId, Long houseId);

    void deleteByUserIdAndHouseId(Long userId, Long houseId);

}