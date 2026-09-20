
package com.smarthouse.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.smarthouse.dto.PropertyAnalytics;
import com.smarthouse.entity.Amenity;
import com.smarthouse.entity.House;
import com.smarthouse.entity.Location;
import com.smarthouse.entity.PropertyOwner;
import com.smarthouse.entity.PropertyType;
import com.smarthouse.repository.AmenityRepository;
import com.smarthouse.repository.HouseRepository;
import com.smarthouse.repository.HouseSpecification;
import com.smarthouse.repository.LocationRepository;
import com.smarthouse.repository.PropertyTypeRepository;

@Service
public class HouseService {

    private final HouseRepository houseRepository;
    private final LocationRepository locationRepository;
    private final PropertyTypeRepository propertyTypeRepository;
    private final AmenityRepository amenityRepository;
    private final FileStorageService fileStorageService;

    public HouseService(
            HouseRepository houseRepository,
            LocationRepository locationRepository,
            PropertyTypeRepository propertyTypeRepository,
            AmenityRepository amenityRepository,
            FileStorageService fileStorageService) {

        this.houseRepository = houseRepository;
        this.locationRepository = locationRepository;
        this.propertyTypeRepository = propertyTypeRepository;
        this.amenityRepository = amenityRepository;
        this.fileStorageService = fileStorageService;
    }

    public List<House> getAllHouses() {
        return houseRepository.findAll();
    }

    public House getHouseById(Long id) {
        return houseRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException(
                        "House not found with ID: " + id));
    }

    public List<Location> getAllLocations() {
        return locationRepository.findAll();
    }

    public List<PropertyType> getAllPropertyTypes() {
        return propertyTypeRepository.findAll();
    }

    public List<Amenity> getAllAmenities() {
        return amenityRepository.findAll();
    }

    @Transactional
    public void saveHouse(
            House house,
            Long locationId,
            Long propertyTypeId,
            Long[] amenityIds,
            MultipartFile imageFile) {

        if (house == null) {
            throw new IllegalArgumentException(
                    "House information is required.");
        }

        /*
         * For updates, load the managed house from the database.
         * Do not save the detached object received directly from the form.
         */
        House houseToSave;

        String oldImagePath = null;

        if (house.getId() != null) {

            houseToSave = houseRepository.findById(house.getId())
                    .orElseThrow(() -> new IllegalArgumentException(
                            "House not found with ID: " + house.getId()));

            oldImagePath = houseToSave.getImagePath();

            // Update ordinary fields only
            houseToSave.setTitle(house.getTitle());
            houseToSave.setPrice(house.getPrice());
            houseToSave.setArea(house.getArea());
            houseToSave.setBedrooms(house.getBedrooms());
            houseToSave.setBathrooms(house.getBathrooms());
            houseToSave.setFloors(house.getFloors());
            houseToSave.setFurnishing(house.getFurnishing());
            houseToSave.setDescription(house.getDescription());

            // Keep the existing owner.
            // Do not assign house.getOwner() here.

        } else {

            houseToSave = new House();

            houseToSave.setTitle(house.getTitle());
            houseToSave.setPrice(house.getPrice());
            houseToSave.setArea(house.getArea());
            houseToSave.setBedrooms(house.getBedrooms());
            houseToSave.setBathrooms(house.getBathrooms());
            houseToSave.setFloors(house.getFloors());
            houseToSave.setFurnishing(house.getFurnishing());
            houseToSave.setDescription(house.getDescription());

            /*
             * For a new property, the owner must be an existing
             * persistent PropertyOwner. The owner should be assigned
             * by your form/service using a valid owner ID.
             */
            if (house.getOwner() == null ||
                    house.getOwner().getId() == null) {

                throw new IllegalArgumentException(
                        "Please select an existing property owner.");
            }

            PropertyOwner existingOwner = new PropertyOwner();
            existingOwner.setId(house.getOwner().getId());

            houseToSave.setOwner(existingOwner);
        }

        validateHouse(houseToSave);

        if (locationId == null) {
            throw new IllegalArgumentException(
                    "Location is required.");
        }

        Location location = locationRepository.findById(locationId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Invalid location selected."));

        if (propertyTypeId == null) {
            throw new IllegalArgumentException(
                    "Property type is required.");
        }

        PropertyType propertyType = propertyTypeRepository
                .findById(propertyTypeId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Invalid property type selected."));

        houseToSave.setLocation(location);
        houseToSave.setPropertyType(propertyType);

        Set<Amenity> amenities = new HashSet<>();

        if (amenityIds != null) {
            for (Long amenityId : amenityIds) {

                if (amenityId == null) {
                    continue;
                }

                Amenity amenity = amenityRepository.findById(amenityId)
                        .orElseThrow(() -> new IllegalArgumentException(
                                "Invalid amenity selected."));

                amenities.add(amenity);
            }
        }

        houseToSave.setAmenities(amenities);

        String newImagePath = null;

        if (imageFile != null && !imageFile.isEmpty()) {

            newImagePath = fileStorageService.storeImage(imageFile);

            houseToSave.setImagePath(newImagePath);
        }

        houseRepository.save(houseToSave);

        if (newImagePath != null &&
                oldImagePath != null &&
                !oldImagePath.equals(newImagePath)) {

            fileStorageService.deleteImage(oldImagePath);
        }
    }

    private void validateHouse(House house) {

        if (house.getTitle() == null ||
                house.getTitle().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Property title is required.");
        }

        if (house.getTitle().trim().length() > 150) {
            throw new IllegalArgumentException(
                    "Property title cannot exceed 150 characters.");
        }

        if (house.getPrice() == null || house.getPrice() <= 0) {
            throw new IllegalArgumentException(
                    "Property price must be greater than zero.");
        }

        if (house.getArea() == null || house.getArea() <= 0) {
            throw new IllegalArgumentException(
                    "Property area must be greater than zero.");
        }

        if (house.getBedrooms() == null || house.getBedrooms() < 0) {
            throw new IllegalArgumentException(
                    "Bedrooms cannot be negative.");
        }

        if (house.getBathrooms() == null || house.getBathrooms() < 0) {
            throw new IllegalArgumentException(
                    "Bathrooms cannot be negative.");
        }

        if (house.getFloors() == null || house.getFloors() <= 0) {
            throw new IllegalArgumentException(
                    "Floors must be greater than zero.");
        }

        if (house.getFurnishing() == null ||
                house.getFurnishing().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Furnishing information is required.");
        }

        if (house.getOwner() == null ||
                house.getOwner().getId() == null) {

            throw new IllegalArgumentException(
                    "Please select a valid property owner.");
        }
    }

    @Transactional
    public void deleteHouse(Long id) {

        if (id == null) {
            throw new IllegalArgumentException(
                    "House ID is required.");
        }

        House house = houseRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException(
                        "House not found with ID: " + id));

        String imagePath = house.getImagePath();

        houseRepository.delete(house);

        if (imagePath != null && !imagePath.trim().isEmpty()) {
            fileStorageService.deleteImage(imagePath);
        }
    }

    public List<House> searchByTitle(String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {
            return houseRepository.findAll();
        }

        return houseRepository.findByTitleContainingIgnoreCase(
                keyword.trim());
    }

    public List<House> searchProperties(
            String keyword,
            Long propertyTypeId,
            Long locationId,
            Double minPrice,
            Double maxPrice,
            Integer bedrooms) {

        Specification<House> specification = Specification.allOf(
                HouseSpecification.hasKeyword(keyword),
                HouseSpecification.hasPropertyType(propertyTypeId),
                HouseSpecification.hasLocation(locationId),
                HouseSpecification.priceGreaterThanOrEqual(minPrice),
                HouseSpecification.priceLessThanOrEqual(maxPrice),
                HouseSpecification.bedroomsGreaterThanOrEqual(bedrooms)
        );

        return houseRepository.findAll(specification);
    }

    public List<PropertyAnalytics> getPropertyTypeAnalytics() {

        List<Object[]> results =
                houseRepository.getPropertyTypeAnalytics();

        List<PropertyAnalytics> analytics = new ArrayList<>();

        for (Object[] row : results) {

            String name = (String) row[0];
            long count = ((Number) row[1]).longValue();
            double averagePrice = ((Number) row[2]).doubleValue();

            analytics.add(new PropertyAnalytics(
                    name,
                    count,
                    averagePrice
            ));
        }

        return analytics;
    }

    public List<PropertyAnalytics> getCityAnalytics() {

        List<Object[]> results =
                houseRepository.getCityAnalytics();

        List<PropertyAnalytics> analytics = new ArrayList<>();

        for (Object[] row : results) {

            String name = (String) row[0];
            long count = ((Number) row[1]).longValue();
            double averagePrice = ((Number) row[2]).doubleValue();

            analytics.add(new PropertyAnalytics(
                    name,
                    count,
                    averagePrice
            ));
        }

        return analytics;
    }

    public List<PropertyAnalytics> getDistrictAnalytics() {

        List<Object[]> results =
                houseRepository.getDistrictAnalytics();

        List<PropertyAnalytics> analytics = new ArrayList<>();

        for (Object[] row : results) {

            String name = (String) row[0];
            long count = ((Number) row[1]).longValue();
            double averagePrice = ((Number) row[2]).doubleValue();

            analytics.add(new PropertyAnalytics(
                    name,
                    count,
                    averagePrice
            ));
        }

        return analytics;
    }

    public List<PropertyAnalytics> getStateAnalytics() {

        List<Object[]> results =
                houseRepository.getStateAnalytics();

        List<PropertyAnalytics> analytics = new ArrayList<>();

        for (Object[] row : results) {

            String name = (String) row[0];
            long count = ((Number) row[1]).longValue();
            double averagePrice = ((Number) row[2]).doubleValue();

            analytics.add(new PropertyAnalytics(
                    name,
                    count,
                    averagePrice
            ));
        }

        return analytics;
    }
}