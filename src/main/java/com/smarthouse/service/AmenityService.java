package com.smarthouse.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smarthouse.entity.Amenity;
import com.smarthouse.repository.AmenityRepository;

@Service
public class AmenityService {

    private final AmenityRepository amenityRepository;

    public AmenityService(AmenityRepository amenityRepository) {
        this.amenityRepository = amenityRepository;
    }

    public List<Amenity> getAllAmenities() {

        return amenityRepository.findAll();
    }

    public Amenity getAmenityById(Long id) {

        return amenityRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Amenity not found with ID: " + id));
    }

    public void saveAmenity(Amenity amenity) {

        if (amenity.getName() == null ||
                amenity.getName().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Amenity name is required.");
        }

        String name = amenity.getName().trim();

        if (amenity.getId() == null &&
                amenityRepository.existsByName(name)) {

            throw new IllegalArgumentException(
                    "Amenity already exists.");
        }

        amenity.setName(name);

        amenityRepository.save(amenity);
    }

    public void deleteAmenity(Long id) {

        if (!amenityRepository.existsById(id)) {

            throw new IllegalArgumentException(
                    "Amenity not found.");
        }

        amenityRepository.deleteById(id);
    }
}