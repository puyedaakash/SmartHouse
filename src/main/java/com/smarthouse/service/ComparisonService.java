package com.smarthouse.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.smarthouse.entity.House;

import jakarta.servlet.http.HttpSession;

@Service
public class ComparisonService {

    private static final String COMPARISON_SESSION_KEY =
            "comparisonHouseIds";

    private static final int MAX_COMPARISON_PROPERTIES = 3;

    private final HouseService houseService;

    public ComparisonService(HouseService houseService) {
        this.houseService = houseService;
    }

    @SuppressWarnings("unchecked")
    private List<Long> getComparisonIds(HttpSession session) {

        List<Long> houseIds =
                (List<Long>) session.getAttribute(
                        COMPARISON_SESSION_KEY);

        if (houseIds == null) {
            houseIds = new ArrayList<>();

            session.setAttribute(
                    COMPARISON_SESSION_KEY,
                    houseIds);
        }

        return houseIds;
    }

    public boolean addToComparison(
            HttpSession session,
            Long houseId) {

        if (houseId == null) {
            throw new IllegalArgumentException(
                    "Property ID is required.");
        }

        House house = houseService.getHouseById(houseId);

        List<Long> houseIds =
                getComparisonIds(session);

        if (houseIds.contains(houseId)) {
            return false;
        }

        if (houseIds.size() >= MAX_COMPARISON_PROPERTIES) {
            throw new IllegalArgumentException(
                    "You can compare a maximum of 3 properties.");
        }

        houseIds.add(houseId);

        return true;
    }

    public boolean removeFromComparison(
            HttpSession session,
            Long houseId) {

        if (houseId == null) {
            return false;
        }

        List<Long> houseIds =
                getComparisonIds(session);

        return houseIds.remove(houseId);
    }

    public void clearComparison(
            HttpSession session) {

        session.removeAttribute(
                COMPARISON_SESSION_KEY);
    }

    public boolean isInComparison(
            HttpSession session,
            Long houseId) {

        if (houseId == null) {
            return false;
        }

        List<Long> houseIds =
                getComparisonIds(session);

        return houseIds.contains(houseId);
    }

    public List<House> getComparisonProperties(
            HttpSession session) {

        List<Long> houseIds =
                getComparisonIds(session);

        List<House> houses =
                new ArrayList<>();

        for (Long houseId : houseIds) {

            try {
                House house =
                        houseService.getHouseById(houseId);

                houses.add(house);

            } catch (IllegalArgumentException e) {
                // Ignore properties that no longer exist.
            }
        }

        return houses;
    }

    public int getComparisonCount(
            HttpSession session) {

        return getComparisonIds(session).size();
    }

    public int getMaximumComparisonProperties() {

        return MAX_COMPARISON_PROPERTIES;
    }
}