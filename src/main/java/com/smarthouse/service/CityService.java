package com.smarthouse.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smarthouse.entity.City;
import com.smarthouse.entity.District;
import com.smarthouse.repository.CityRepository;
import com.smarthouse.repository.DistrictRepository;

@Service
public class CityService {

    private final CityRepository cityRepository;

    private final DistrictRepository districtRepository;


    public CityService(
            CityRepository cityRepository,
            DistrictRepository districtRepository) {

        this.cityRepository = cityRepository;
        this.districtRepository = districtRepository;
    }


    /*
     * Get all cities.
     */
    public List<City> getAllCities() {

        return cityRepository.findAll();
    }


    /*
     * Get cities belonging to a particular district.
     */
    public List<City> getCitiesByDistrict(
            Long districtId) {

        return cityRepository.findByDistrictId(
                districtId
        );
    }


    /*
     * Get city by ID.
     */
    public City getCityById(Long id) {

        return cityRepository.findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "City not found."
                        )
                );
    }


    /*
     * Save city.
     */
    public void saveCity(
            String name,
            Long districtId) {

        /*
         * Validate city name.
         */
        if (name == null || name.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "City name is required."
            );
        }


        /*
         * Validate district.
         */
        if (districtId == null) {

            throw new IllegalArgumentException(
                    "District is required."
            );
        }


        /*
         * Find selected district.
         */
        District district =
                districtRepository.findById(districtId)
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "Selected district does not exist."
                                )
                        );


        String cityName = name.trim();


        /*
         * Check duplicate city
         * inside the same district.
         */
        if (cityRepository
                .existsByNameIgnoreCaseAndDistrictId(
                        cityName,
                        districtId)) {

            throw new IllegalArgumentException(
                    "City already exists in this district."
            );
        }


        /*
         * Create city.
         */
        City city =
                new City(
                        cityName,
                        district
                );


        cityRepository.save(city);
    }


    /*
     * Delete city.
     */
    public void deleteCity(Long id) {

        if (!cityRepository.existsById(id)) {

            throw new IllegalArgumentException(
                    "City not found."
            );
        }


        cityRepository.deleteById(id);
    }
}