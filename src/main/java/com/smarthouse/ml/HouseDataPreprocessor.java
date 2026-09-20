package com.smarthouse.ml;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Service;

@Service
public class HouseDataPreprocessor {

    private final Set<String> districts =
            new LinkedHashSet<>();

    private final Set<String> cities =
            new LinkedHashSet<>();

    private final Set<String> locations =
            new LinkedHashSet<>();

    private final Set<String> propertyTypes =
            new LinkedHashSet<>();

    private final Set<String> furnishingTypes =
            new LinkedHashSet<>();


    public void learnCategories(
            List<HouseTrainingData> dataset) {

        districts.clear();
        cities.clear();
        locations.clear();
        propertyTypes.clear();
        furnishingTypes.clear();


        for (HouseTrainingData data : dataset) {

            districts.add(
                    normalize(data.getDistrict())
            );

            cities.add(
                    normalize(data.getCity())
            );

            locations.add(
                    normalize(data.getLocation())
            );

            propertyTypes.add(
                    normalize(data.getPropertyType())
            );

            furnishingTypes.add(
                    normalize(data.getFurnishing())
            );
        }
    }


    public List<HouseFeatureVector> transform(
            List<HouseTrainingData> dataset) {

        List<HouseFeatureVector> result =
                new ArrayList<>();


        for (HouseTrainingData data : dataset) {

            result.add(
                    new HouseFeatureVector(
                            createFeatureVector(data),
                            data.getPrice()
                    )
            );
        }


        return result;
    }


    public double[] createFeatureVector(
            HouseTrainingData data) {

        List<Double> featureList =
                new ArrayList<>();


        /*
         * Numerical Features
         */

        featureList.add(data.getArea());

        featureList.add(
                (double) data.getBedrooms()
        );

        featureList.add(
                (double) data.getBathrooms()
        );

        featureList.add(
                (double) data.getFloors()
        );

        featureList.add(
                (double) data.getAge()
        );


        /*
         * Geographic Features
         */

        addOneHotFeatures(
                featureList,
                normalize(data.getDistrict()),
                districts
        );


        addOneHotFeatures(
                featureList,
                normalize(data.getCity()),
                cities
        );


        addOneHotFeatures(
                featureList,
                normalize(data.getLocation()),
                locations
        );


        /*
         * Property Type
         */

        addOneHotFeatures(
                featureList,
                normalize(data.getPropertyType()),
                propertyTypes
        );


        /*
         * Furnishing
         */

        addOneHotFeatures(
                featureList,
                normalize(data.getFurnishing()),
                furnishingTypes
        );


        double[] features =
                new double[featureList.size()];


        for (int i = 0;
             i < featureList.size();
             i++) {

            features[i] =
                    featureList.get(i);
        }


        return features;
    }


    private void addOneHotFeatures(
            List<Double> featureList,
            String selectedCategory,
            Set<String> categories) {

        boolean firstCategory = true;


        for (String category : categories) {

            /*
             * First category is the baseline.
             */
            if (firstCategory) {

                firstCategory = false;

                continue;
            }


            if (selectedCategory.equals(category)) {

                featureList.add(1.0);

            } else {

                featureList.add(0.0);
            }
        }
    }


    private String normalize(String value) {

        if (value == null) {

            return "";
        }


        return value
                .trim()
                .toLowerCase();
    }


    public Set<String> getDistricts() {

        return districts;
    }


    public Set<String> getCities() {

        return cities;
    }


    public Set<String> getLocations() {

        return locations;
    }


    public Set<String> getPropertyTypes() {

        return propertyTypes;
    }


    public Set<String> getFurnishingTypes() {

        return furnishingTypes;
    }
}