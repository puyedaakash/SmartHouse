package com.smarthouse.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smarthouse.entity.Location;

public interface LocationRepository extends JpaRepository<Location, Long> {

    List<Location> findByCityId(Long cityId);

    boolean existsByNameIgnoreCaseAndCityId(
            String name,
            Long cityId
    );

    Optional<Location> findByNameIgnoreCaseAndCityId(
            String name,
            Long cityId
    );
}