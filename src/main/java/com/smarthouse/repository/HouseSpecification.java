package com.smarthouse.repository;

import jakarta.persistence.criteria.Expression;

import org.springframework.data.jpa.domain.Specification;

import com.smarthouse.entity.House;

public class HouseSpecification {

    private HouseSpecification() {
    }

    // =========================================================
    // SEARCH BY KEYWORD
    // Supports: 3BHK and 3 BHK
    // =========================================================

    public static Specification<House> hasKeyword(String keyword) {

        return (root, query, criteriaBuilder) -> {

            if (keyword == null || keyword.trim().isEmpty()) {
                return null;
            }

            String searchKeyword = keyword
                    .trim()
                    .toLowerCase()
                    .replaceAll("\\s+", "");

            Expression<String> normalizedTitle =
                    criteriaBuilder.function(
                            "replace",
                            String.class,
                            criteriaBuilder.lower(
                                    root.get("title")
                            ),
                            criteriaBuilder.literal(" "),
                            criteriaBuilder.literal("")
                    );

            return criteriaBuilder.like(
                    normalizedTitle,
                    "%" + searchKeyword + "%"
            );
        };
    }

    // =========================================================
    // FILTER BY PROPERTY TYPE
    // =========================================================

    public static Specification<House> hasPropertyType(
            Long propertyTypeId) {

        return (root, query, criteriaBuilder) -> {

            if (propertyTypeId == null) {
                return null;
            }

            return criteriaBuilder.equal(
                    root.get("propertyType").get("id"),
                    propertyTypeId
            );
        };
    }

    // =========================================================
    // FILTER BY LOCATION
    // =========================================================

    public static Specification<House> hasLocation(
            Long locationId) {

        return (root, query, criteriaBuilder) -> {

            if (locationId == null) {
                return null;
            }

            return criteriaBuilder.equal(
                    root.get("location").get("id"),
                    locationId
            );
        };
    }

    // =========================================================
    // FILTER BY MINIMUM PRICE
    // =========================================================

    public static Specification<House> priceGreaterThanOrEqual(
            Double minPrice) {

        return (root, query, criteriaBuilder) -> {

            if (minPrice == null) {
                return null;
            }

            return criteriaBuilder.greaterThanOrEqualTo(
                    root.get("price"),
                    minPrice
            );
        };
    }

    // =========================================================
    // FILTER BY MAXIMUM PRICE
    // =========================================================

    public static Specification<House> priceLessThanOrEqual(
            Double maxPrice) {

        return (root, query, criteriaBuilder) -> {

            if (maxPrice == null) {
                return null;
            }

            return criteriaBuilder.lessThanOrEqualTo(
                    root.get("price"),
                    maxPrice
            );
        };
    }

    // =========================================================
    // FILTER BY BEDROOMS
    // =========================================================

    public static Specification<House> bedroomsGreaterThanOrEqual(
            Integer bedrooms) {

        return (root, query, criteriaBuilder) -> {

            if (bedrooms == null) {
                return null;
            }

            return criteriaBuilder.greaterThanOrEqualTo(
                    root.get("bedrooms"),
                    bedrooms
            );
        };
    }
}