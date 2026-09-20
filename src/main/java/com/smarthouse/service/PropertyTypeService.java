package com.smarthouse.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smarthouse.entity.PropertyType;
import com.smarthouse.repository.PropertyTypeRepository;

@Service
public class PropertyTypeService {

    private final PropertyTypeRepository propertyTypeRepository;

    public PropertyTypeService(
            PropertyTypeRepository propertyTypeRepository) {

        this.propertyTypeRepository = propertyTypeRepository;
    }

    public List<PropertyType> getAllPropertyTypes() {

        return propertyTypeRepository.findAll();
    }

    public PropertyType getPropertyTypeById(Long id) {

        return propertyTypeRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Property type not found with ID: " + id));
    }

    public void savePropertyType(PropertyType propertyType) {

        if (propertyType.getName() == null ||
                propertyType.getName().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Property type name is required.");
        }

        String name = propertyType.getName().trim();

        if (propertyType.getId() == null &&
                propertyTypeRepository.existsByName(name)) {

            throw new IllegalArgumentException(
                    "Property type already exists.");
        }

        propertyType.setName(name);

        propertyTypeRepository.save(propertyType);
    }

    public void deletePropertyType(Long id) {

        if (!propertyTypeRepository.existsById(id)) {

            throw new IllegalArgumentException(
                    "Property type not found.");
        }

        propertyTypeRepository.deleteById(id);
    }
}