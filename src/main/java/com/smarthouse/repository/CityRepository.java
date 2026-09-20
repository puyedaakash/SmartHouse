package com.smarthouse.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smarthouse.entity.City;

public interface CityRepository extends JpaRepository<City, Long> {

    /*
     * Find all cities belonging to a district.
     */
    List<City> findByDistrictId(Long districtId);


    /*
     * Check whether a city already exists
     * inside the selected district.
     */
    boolean existsByNameIgnoreCaseAndDistrictId(
            String name,
            Long districtId
    );


    /*
     * Find a city by name inside a district.
     */
    Optional<City> findByNameIgnoreCaseAndDistrictId(
            String name,
            Long districtId
    );
}