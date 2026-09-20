package com.smarthouse.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smarthouse.entity.District;

public interface DistrictRepository
        extends JpaRepository<District, Long> {

    List<District> findByStateId(Long stateId);

    Optional<District> findByNameIgnoreCaseAndStateId(
            String name,
            Long stateId
    );

    boolean existsByNameIgnoreCaseAndStateId(
            String name,
            Long stateId
    );
}