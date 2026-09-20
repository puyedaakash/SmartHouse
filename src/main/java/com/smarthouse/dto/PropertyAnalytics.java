package com.smarthouse.dto;

import com.smarthouse.util.PriceFormatter;

public class PropertyAnalytics {

    private String name;

    private long count;

    private double averagePrice;


    public PropertyAnalytics() {

    }


    public PropertyAnalytics(
            String name,
            long count,
            double averagePrice) {

        this.name = name;

        this.count = count;

        this.averagePrice = averagePrice;
    }


    public String getName() {

        return name;
    }


    public void setName(String name) {

        this.name = name;
    }


    public long getCount() {

        return count;
    }


    public void setCount(long count) {

        this.count = count;
    }


    public double getAveragePrice() {

        return averagePrice;
    }


    public void setAveragePrice(double averagePrice) {

        this.averagePrice = averagePrice;
    }


    /*
     * Returns the average property price
     * in a user-friendly Indian currency format.
     *
     * Example:
     *
     * 11525000 → ₹1.15 Crore
     * 5650000  → ₹56.50 Lakh
     */
    public String getAveragePriceFormatted() {

        return PriceFormatter.format(averagePrice);
    }

}