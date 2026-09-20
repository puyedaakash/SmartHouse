package com.smarthouse.dto;

public class AdminDashboardStats {

    private long totalUsers;
    private long totalProperties;
    private long totalPredictions;
    private long totalFavorites;

    private double averagePropertyPrice;
    private double highestPropertyPrice;
    private double lowestPropertyPrice;

    public AdminDashboardStats() {
    }

    public AdminDashboardStats(
            long totalUsers,
            long totalProperties,
            long totalPredictions,
            long totalFavorites,
            double averagePropertyPrice,
            double highestPropertyPrice,
            double lowestPropertyPrice) {

        this.totalUsers = totalUsers;
        this.totalProperties = totalProperties;
        this.totalPredictions = totalPredictions;
        this.totalFavorites = totalFavorites;
        this.averagePropertyPrice = averagePropertyPrice;
        this.highestPropertyPrice = highestPropertyPrice;
        this.lowestPropertyPrice = lowestPropertyPrice;
    }

    public long getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(long totalUsers) {
        this.totalUsers = totalUsers;
    }

    public long getTotalProperties() {
        return totalProperties;
    }

    public void setTotalProperties(long totalProperties) {
        this.totalProperties = totalProperties;
    }

    public long getTotalPredictions() {
        return totalPredictions;
    }

    public void setTotalPredictions(long totalPredictions) {
        this.totalPredictions = totalPredictions;
    }

    public long getTotalFavorites() {
        return totalFavorites;
    }

    public void setTotalFavorites(long totalFavorites) {
        this.totalFavorites = totalFavorites;
    }

    public double getAveragePropertyPrice() {
        return averagePropertyPrice;
    }

    public void setAveragePropertyPrice(double averagePropertyPrice) {
        this.averagePropertyPrice = averagePropertyPrice;
    }

    public double getHighestPropertyPrice() {
        return highestPropertyPrice;
    }

    public void setHighestPropertyPrice(double highestPropertyPrice) {
        this.highestPropertyPrice = highestPropertyPrice;
    }

    public double getLowestPropertyPrice() {
        return lowestPropertyPrice;
    }

    public void setLowestPropertyPrice(double lowestPropertyPrice) {
        this.lowestPropertyPrice = lowestPropertyPrice;
    }
}