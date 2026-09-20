package com.smarthouse.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smarthouse.ml.HouseTrainingData;
import com.smarthouse.ml.HouseTrainingDataLoader;

@Controller
@RequestMapping("/ml")
public class MlTestController {

    private final HouseTrainingDataLoader dataLoader;

    public MlTestController(
            HouseTrainingDataLoader dataLoader) {

        this.dataLoader = dataLoader;
    }

    @GetMapping("/dataset")
    public String testDataset(Model model) {

        List<HouseTrainingData> dataset =
                dataLoader.loadDataset();

        model.addAttribute(
                "recordCount",
                dataset.size()
        );

        /*
         * Display first 10 records instead of
         * only 5 so we can inspect the dataset
         * more easily.
         */
        int displayCount =
                Math.min(10, dataset.size());

        model.addAttribute(
                "records",
                dataset.subList(0, displayCount)
        );

        return "ml/dataset";
    }
}