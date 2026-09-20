package com.smarthouse.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smarthouse.entity.Prediction;

public interface PredictionRepository extends JpaRepository<Prediction, Long> {

    List<Prediction> findByUserIdOrderByPredictedAtDesc(Long userId);

}