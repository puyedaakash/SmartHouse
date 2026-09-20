package com.smarthouse.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.smarthouse.entity.House;

public interface HouseRepository
        extends JpaRepository<House, Long>,
                JpaSpecificationExecutor<House> {

    List<House> findByTitleContainingIgnoreCase(String keyword);

    @Query("""
        SELECT h.propertyType.name,
               COUNT(h),
               COALESCE(AVG(h.price), 0)
        FROM House h
        GROUP BY h.propertyType.name
        ORDER BY COUNT(h) DESC
    """)
    List<Object[]> getPropertyTypeAnalytics();


    @Query("""
        SELECT h.location.city.name,
               COUNT(h),
               COALESCE(AVG(h.price), 0)
        FROM House h
        GROUP BY h.location.city.name
        ORDER BY COUNT(h) DESC
    """)
    List<Object[]> getCityAnalytics();


    @Query("""
        SELECT h.location.city.district.name,
               COUNT(h),
               COALESCE(AVG(h.price), 0)
        FROM House h
        GROUP BY h.location.city.district.name
        ORDER BY COUNT(h) DESC
    """)
    List<Object[]> getDistrictAnalytics();


    @Query("""
        SELECT h.location.city.district.state.name,
               COUNT(h),
               COALESCE(AVG(h.price), 0)
        FROM House h
        GROUP BY h.location.city.district.state.name
        ORDER BY COUNT(h) DESC
    """)
    List<Object[]> getStateAnalytics();

}