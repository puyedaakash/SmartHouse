package com.smarthouse.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smarthouse.entity.PropertyOwner;

public interface PropertyOwnerRepository extends JpaRepository<PropertyOwner, Long> {

}