package com.smarthouse.ml;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

import org.springframework.stereotype.Service;

@Service
public class HouseTrainingDataLoader {

    private static final String DATASET_PATH =
            "/ml/house_price_training.csv";

    public List<HouseTrainingData> loadDataset() {

        List<HouseTrainingData> dataset = new ArrayList<>();

        try {

            InputStream inputStream =
                    getClass().getResourceAsStream(DATASET_PATH);

            if (inputStream == null) {

                throw new IllegalStateException(
                        "Training dataset not found at: "
                                + DATASET_PATH);
            }

            try (BufferedReader reader =
                         new BufferedReader(
                                 new InputStreamReader(
                                         inputStream,
                                         StandardCharsets.UTF_8));

                 CSVParser csvParser =
                         CSVFormat.DEFAULT.builder()
                                 .setHeader()
                                 .setSkipHeaderRecord(true)
                                 .setIgnoreEmptyLines(true)
                                 .setTrim(true)
                                 .build()
                                 .parse(reader)) {

                for (CSVRecord record : csvParser) {

                    HouseTrainingData data =
                            new HouseTrainingData();

                    data.setArea(
                            Double.parseDouble(
                                    record.get("area_sqft")));

                    data.setBedrooms(
                            Integer.parseInt(
                                    record.get("bedrooms")));

                    data.setBathrooms(
                            Integer.parseInt(
                                    record.get("bathrooms")));

                    data.setFloors(
                            Integer.parseInt(
                                    record.get("floor")));

                    data.setAge(
                            Integer.parseInt(
                                    record.get("age_years")));

                    data.setLocation(
                            record.get("city"));

                    data.setPropertyType(
                            record.get("property_type"));

                    data.setFurnishing(
                            record.get("furnishing"));

                    data.setPrice(
                            Double.parseDouble(
                                    record.get("estimated_price")));

                    dataset.add(data);
                }
            }

        } catch (Exception e) {

            throw new IllegalStateException(
                    "Unable to load house price training dataset.",
                    e);
        }

        return dataset;
    }
}