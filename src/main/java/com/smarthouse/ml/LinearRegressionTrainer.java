package com.smarthouse.ml;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.commons.math3.linear.Array2DRowRealMatrix;
import org.apache.commons.math3.linear.ArrayRealVector;
import org.apache.commons.math3.linear.RealMatrix;
import org.apache.commons.math3.linear.RealVector;
import org.apache.commons.math3.linear.SingularValueDecomposition;
import org.springframework.stereotype.Service;

@Service
public class LinearRegressionTrainer {

    private final HouseTrainingDataLoader dataLoader;
    private final HouseDataPreprocessor preprocessor;

    private LinearRegressionModel model;

    public LinearRegressionTrainer(
            HouseTrainingDataLoader dataLoader,
            HouseDataPreprocessor preprocessor) {

        this.dataLoader = dataLoader;
        this.preprocessor = preprocessor;
    }

    public LinearRegressionModel train() {

        List<HouseTrainingData> dataset =
                dataLoader.loadDataset();

        if (dataset.size() < 20) {

            throw new IllegalStateException(
                    "At least 20 training records are required."
            );
        }

        /*
         * Learn all categorical values so that
         * training and prediction use exactly
         * the same feature structure.
         */
        preprocessor.learnCategories(dataset);

        /*
         * Shuffle before train/test split.
         */
        List<HouseTrainingData> shuffledDataset =
                new ArrayList<>(dataset);

        Collections.shuffle(shuffledDataset);

        /*
         * 80% Training
         * 20% Testing
         */
        int trainingSize =
                (int) (shuffledDataset.size() * 0.80);

        if (trainingSize < 2) {

            throw new IllegalStateException(
                    "Not enough training records."
            );
        }

        List<HouseTrainingData> trainingData =
                shuffledDataset.subList(
                        0,
                        trainingSize
                );

        List<HouseTrainingData> testData =
                shuffledDataset.subList(
                        trainingSize,
                        shuffledDataset.size()
                );

        /*
         * Convert training data into feature vectors.
         */
        List<HouseFeatureVector> trainingVectors =
                preprocessor.transform(trainingData);

        if (trainingVectors.isEmpty()) {

            throw new IllegalStateException(
                    "Training dataset produced no feature vectors."
            );
        }

        int featureCount =
                trainingVectors
                        .get(0)
                        .getFeatures()
                        .length;

        int sampleCount =
                trainingVectors.size();

        /*
         * Build X matrix.
         *
         * We add an intercept column as column 0.
         *
         * X =
         *
         * [1 x1 x2 x3 ...]
         * [1 x1 x2 x3 ...]
         * [1 x1 x2 x3 ...]
         */
        double[][] designData =
                new double[sampleCount][featureCount + 1];

        double[] targetData =
                new double[sampleCount];

        for (int i = 0;
             i < sampleCount;
             i++) {

            double[] features =
                    trainingVectors
                            .get(i)
                            .getFeatures();

            /*
             * Intercept.
             */
            designData[i][0] = 1.0;

            /*
             * Remaining feature columns.
             */
            System.arraycopy(
                    features,
                    0,
                    designData[i],
                    1,
                    features.length
            );

            targetData[i] =
                    trainingVectors
                            .get(i)
                            .getTargetPrice();
        }

        /*
         * ============================================
         * TRAIN USING SVD
         * ============================================
         *
         * SVD is more robust than directly solving
         * (X^T X)^-1 X^T y.
         *
         * It can handle redundant or highly correlated
         * features without throwing:
         *
         * "matrix is singular"
         */
        RealMatrix xMatrix =
                new Array2DRowRealMatrix(
                        designData,
                        false
                );

        RealVector yVector =
                new ArrayRealVector(
                        targetData,
                        false
                );

        SingularValueDecomposition svd =
                new SingularValueDecomposition(
                        xMatrix
                );

        RealVector parameterVector =
                svd.getSolver()
                        .solve(yVector);

        double[] parameters =
                parameterVector.toArray();

        /*
         * First parameter is the intercept.
         */
        double intercept =
                parameters[0];

        /*
         * Remaining parameters are feature
         * coefficients.
         */
        double[] coefficients =
                new double[parameters.length - 1];

        System.arraycopy(
                parameters,
                1,
                coefficients,
                0,
                coefficients.length
        );

        /*
         * ============================================
         * TEST MODEL ON UNSEEN DATA
         * ============================================
         */

        List<HouseFeatureVector> testVectors =
                preprocessor.transform(testData);

        List<Double> actualValues =
                new ArrayList<>();

        List<Double> predictedValues =
                new ArrayList<>();

        for (HouseFeatureVector vector :
                testVectors) {

            double prediction =
                    intercept;

            double[] features =
                    vector.getFeatures();

            for (int j = 0;
                 j < coefficients.length;
                 j++) {

                prediction +=
                        coefficients[j]
                        * features[j];
            }

            actualValues.add(
                    vector.getTargetPrice()
            );

            predictedValues.add(
                    prediction
            );
        }

        /*
         * ============================================
         * EVALUATION METRICS
         * ============================================
         */

        double r2 =
                calculateR2(
                        actualValues,
                        predictedValues
                );

        double mae =
                calculateMAE(
                        actualValues,
                        predictedValues
                );

        double rmse =
                calculateRMSE(
                        actualValues,
                        predictedValues
                );

        /*
         * ============================================
         * CREATE MODEL
         * ============================================
         */

        LinearRegressionModel trainedModel =
                new LinearRegressionModel();

        trainedModel.setIntercept(
                intercept
        );

        trainedModel.setCoefficients(
                coefficients
        );

        trainedModel.setR2Score(
                r2
        );

        trainedModel.setMae(
                mae
        );

        trainedModel.setRmse(
                rmse
        );

        /*
         * Store total available dataset records.
         */
        trainedModel.setTrainingRecords(
                dataset.size()
        );

        /*
         * Keep trained model in memory.
         */
        this.model =
                trainedModel;

        return trainedModel;
    }


    /*
     * ================================================
     * PREDICT
     * ================================================
     */

    public double predict(double[] features) {

        if (model == null) {

            train();
        }

        return model.predict(
                features
        );
    }


    /*
     * ================================================
     * GET TRAINED MODEL
     * ================================================
     */

    public LinearRegressionModel getTrainedModel() {

        if (model == null) {

            throw new IllegalStateException(
                    "Model has not been trained yet."
            );
        }

        return model;
    }


    /*
     * ================================================
     * MAE
     * ================================================
     */

    private double calculateMAE(
            List<Double> actual,
            List<Double> predicted) {

        if (actual.isEmpty()) {

            return 0.0;
        }

        double totalError =
                0.0;

        for (int i = 0;
             i < actual.size();
             i++) {

            totalError +=
                    Math.abs(
                            actual.get(i)
                                    - predicted.get(i)
                    );
        }

        return totalError /
                actual.size();
    }


    /*
     * ================================================
     * RMSE
     * ================================================
     */

    private double calculateRMSE(
            List<Double> actual,
            List<Double> predicted) {

        if (actual.isEmpty()) {

            return 0.0;
        }

        double totalSquaredError =
                0.0;

        for (int i = 0;
             i < actual.size();
             i++) {

            double error =
                    actual.get(i)
                            - predicted.get(i);

            totalSquaredError +=
                    error * error;
        }

        return Math.sqrt(
                totalSquaredError /
                        actual.size()
        );
    }


    /*
     * ================================================
     * R2
     * ================================================
     */

    private double calculateR2(
            List<Double> actual,
            List<Double> predicted) {

        if (actual.isEmpty()) {

            return 0.0;
        }

        double mean =
                0.0;

        for (double value : actual) {

            mean += value;
        }

        mean /=
                actual.size();

        double totalSumOfSquares =
                0.0;

        double residualSumOfSquares =
                0.0;

        for (int i = 0;
             i < actual.size();
             i++) {

            double actualValue =
                    actual.get(i);

            double predictedValue =
                    predicted.get(i);

            totalSumOfSquares +=
                    Math.pow(
                            actualValue - mean,
                            2
                    );

            residualSumOfSquares +=
                    Math.pow(
                            actualValue - predictedValue,
                            2
                    );
        }

        if (totalSumOfSquares == 0.0) {

            return 0.0;
        }

        return 1.0 -
                (
                    residualSumOfSquares /
                    totalSumOfSquares
                );
    }
}