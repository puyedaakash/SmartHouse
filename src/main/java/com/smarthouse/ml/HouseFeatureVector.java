package com.smarthouse.ml;

public class HouseFeatureVector {

    private double[] features;
    private double targetPrice;

    public HouseFeatureVector(
            double[] features,
            double targetPrice) {

        this.features = features;
        this.targetPrice = targetPrice;
    }

    public double[] getFeatures() {
        return features;
    }

    public double getTargetPrice() {
        return targetPrice;
    }
}