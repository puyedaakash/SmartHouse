package com.smarthouse.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public class PredictionRequest {

    @NotNull(message = "Area is required.")
    @DecimalMin(
        value = "100.0",
        message = "Area must be at least 100 sq.ft."
    )
    private Double area;


    @NotNull(message = "Bedrooms are required.")
    @Min(
        value = 1,
        message = "Bedrooms must be at least 1."
    )
    @Max(
        value = 20,
        message = "Bedrooms cannot exceed 20."
    )
    private Integer bedrooms;


    @NotNull(message = "Bathrooms are required.")
    @Min(
        value = 1,
        message = "Bathrooms must be at least 1."
    )
    @Max(
        value = 20,
        message = "Bathrooms cannot exceed 20."
    )
    private Integer bathrooms;


    @NotNull(message = "Number of floors is required.")
    @Min(
        value = 1,
        message = "Floors must be at least 1."
    )
    @Max(
        value = 100,
        message = "Floors cannot exceed 100."
    )
    private Integer floors;


    @NotNull(message = "Property age is required.")
    @Min(
        value = 0,
        message = "Property age cannot be negative."
    )
    @Max(
        value = 200,
        message = "Please enter a valid property age."
    )
    private Integer age;


    @NotNull(message = "Please select a property type.")
    private Long propertyTypeId;


    @NotNull(message = "Please select a location.")
    private Long locationId;


    @NotNull(message = "Please select furnishing status.")
    private String furnishing;


    public PredictionRequest() {
    }


    public Double getArea() {
        return area;
    }


    public void setArea(Double area) {
        this.area = area;
    }


    public Integer getBedrooms() {
        return bedrooms;
    }


    public void setBedrooms(Integer bedrooms) {
        this.bedrooms = bedrooms;
    }


    public Integer getBathrooms() {
        return bathrooms;
    }


    public void setBathrooms(Integer bathrooms) {
        this.bathrooms = bathrooms;
    }


    public Integer getFloors() {
        return floors;
    }


    public void setFloors(Integer floors) {
        this.floors = floors;
    }


    public Integer getAge() {
        return age;
    }


    public void setAge(Integer age) {
        this.age = age;
    }


    public Long getPropertyTypeId() {
        return propertyTypeId;
    }


    public void setPropertyTypeId(Long propertyTypeId) {
        this.propertyTypeId = propertyTypeId;
    }


    public Long getLocationId() {
        return locationId;
    }


    public void setLocationId(Long locationId) {
        this.locationId = locationId;
    }


    public String getFurnishing() {
        return furnishing;
    }


    public void setFurnishing(String furnishing) {
        this.furnishing = furnishing;
    }
}