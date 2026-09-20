package com.smarthouse.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smarthouse.entity.District;
import com.smarthouse.entity.State;
import com.smarthouse.repository.DistrictRepository;
import com.smarthouse.repository.StateRepository;

@Service
public class DistrictService {

    private final DistrictRepository districtRepository;
    private final StateRepository stateRepository;

    public DistrictService(
            DistrictRepository districtRepository,
            StateRepository stateRepository) {

        this.districtRepository = districtRepository;
        this.stateRepository = stateRepository;
    }

    public List<District> getAllDistricts() {
        return districtRepository.findAll();
    }

    public List<District> getDistrictsByState(Long stateId) {

        return districtRepository.findByStateId(stateId);
    }

    public District getDistrictById(Long id) {

        return districtRepository.findById(id)
                .orElseThrow(() ->
                    new IllegalArgumentException(
                        "District not found."
                    )
                );
    }

    public void saveDistrict(
            String name,
            Long stateId) {

        if (name == null || name.trim().isEmpty()) {

            throw new IllegalArgumentException(
                "District name is required."
            );
        }

        State state = stateRepository.findById(stateId)
                .orElseThrow(() ->
                    new IllegalArgumentException(
                        "Selected state does not exist."
                    )
                );

        String districtName = name.trim();

        if (districtRepository
                .existsByNameIgnoreCaseAndStateId(
                    districtName,
                    stateId)) {

            throw new IllegalArgumentException(
                "District already exists in this state."
            );
        }

        District district =
                new District(
                    districtName,
                    state
                );

        districtRepository.save(district);
    }

    public void deleteDistrict(Long id) {

        if (!districtRepository.existsById(id)) {

            throw new IllegalArgumentException(
                "District not found."
            );
        }

        districtRepository.deleteById(id);
    }
}