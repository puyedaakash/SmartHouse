package com.smarthouse.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smarthouse.entity.Amenity;

public interface AmenityRepository
        extends JpaRepository<Amenity, Long> {

    Optional<Amenity> findByName(String name);

    boolean existsByName(String name);
}