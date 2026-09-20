package com.smarthouse.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.smarthouse.entity.State;
import com.smarthouse.repository.StateRepository;

@Service
public class StateService {

    private final StateRepository stateRepository;

    public StateService(StateRepository stateRepository) {
        this.stateRepository = stateRepository;
    }

    public List<State> getAllStates() {
        return stateRepository.findAll();
    }

    public State getStateById(Long id) {

        return stateRepository.findById(id)
                .orElseThrow(() ->
                    new IllegalArgumentException(
                        "State not found with ID: " + id
                    )
                );
    }

    public void saveState(State state) {

        if (state.getName() == null ||
                state.getName().trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "State name is required."
            );
        }

        String stateName = state.getName().trim();

        if (state.getId() == null &&
                stateRepository.existsByName(stateName)) {

            throw new IllegalArgumentException(
                    "State already exists."
            );
        }

        state.setName(stateName);

        stateRepository.save(state);
    }

    public void deleteState(Long id) {

        if (!stateRepository.existsById(id)) {

            throw new IllegalArgumentException(
                    "State not found."
            );
        }

        stateRepository.deleteById(id);
    }
}