package com.smarthouse.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smarthouse.entity.State;

public interface StateRepository extends JpaRepository<State, Long> {

    Optional<State> findByName(String name);

    boolean existsByName(String name);
}