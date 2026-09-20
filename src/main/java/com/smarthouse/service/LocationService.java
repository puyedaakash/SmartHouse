package com.smarthouse.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smarthouse.entity.City;
import com.smarthouse.entity.Location;
import com.smarthouse.repository.CityRepository;
import com.smarthouse.repository.LocationRepository;

@Service
public class LocationService {

    private final LocationRepository locationRepository;
    private final CityRepository cityRepository;

    public LocationService(
            LocationRepository locationRepository,
            CityRepository cityRepository) {

        this.locationRepository = locationRepository;
        this.cityRepository = cityRepository;
    }

    public List<Location> getAllLocations() {

        return locationRepository.findAll();
    }

    public List<Location> getLocationsByCity(Long cityId) {

        return locationRepository.findByCityId(cityId);
    }

    public Location getLocationById(Long id) {

        return locationRepository.findById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Location not found."
                        )
                );
    }

    public void saveLocation(
            String name,
            Long cityId) {

        if (name == null || name.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Location name is required."
            );
        }

        if (cityId == null) {

            throw new IllegalArgumentException(
                    "City is required."
            );
        }

        City city =
                cityRepository.findById(cityId)
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "Selected city does not exist."
                                )
                        );

        String locationName = name.trim();

        if (locationRepository
                .existsByNameIgnoreCaseAndCityId(
                        locationName,
                        cityId)) {

            throw new IllegalArgumentException(
                    "Location already exists in this city."
            );
        }

        Location location =
                new Location();

        location.setName(locationName);
        location.setCity(city);

        locationRepository.save(location);
    }

    public void deleteLocation(Long id) {

        if (!locationRepository.existsById(id)) {

            throw new IllegalArgumentException(
                    "Location not found."
            );
        }

        locationRepository.deleteById(id);
    }
}