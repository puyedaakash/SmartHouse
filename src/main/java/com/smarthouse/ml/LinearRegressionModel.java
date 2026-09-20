package com.smarthouse.ml;

public class LinearRegressionModel {

    private double[] coefficients;

    private double intercept;

    private double r2Score;

    private double mae;

    private double rmse;

    private int trainingRecords;

    public double predict(double[] features) {

        if (coefficients == null) {
            throw new IllegalStateException(
                    "Model has not been trained yet.");
        }

        if (features.length != coefficients.length) {
            throw new IllegalArgumentException(
                    "Feature count does not match model.");
        }

        double prediction = intercept;

        for (int i = 0; i < features.length; i++) {

            prediction +=
                    coefficients[i] * features[i];
        }

        return prediction;
    }

    public double[] getCoefficients() {
        return coefficients;
    }

    public void setCoefficients(
            double[] coefficients) {

        this.coefficients = coefficients;
    }

    public double getIntercept() {
        return intercept;
    }

    public void setIntercept(double intercept) {
        this.intercept = intercept;
    }

    public double getR2Score() {
        return r2Score;
    }

    public void setR2Score(double r2Score) {
        this.r2Score = r2Score;
    }

    public double getMae() {
        return mae;
    }

    public void setMae(double mae) {
        this.mae = mae;
    }

    public double getRmse() {
        return rmse;
    }

    public void setRmse(double rmse) {
        this.rmse = rmse;
    }

    public int getTrainingRecords() {
        return trainingRecords;
    }

    public void setTrainingRecords(
            int trainingRecords) {

        this.trainingRecords = trainingRecords;
    }
}