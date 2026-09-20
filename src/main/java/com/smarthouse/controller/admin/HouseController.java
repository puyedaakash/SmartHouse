package com.smarthouse.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smarthouse.entity.House;
import com.smarthouse.service.HouseService;

@Controller
@RequestMapping("/admin/houses")
public class HouseController {

    private final HouseService houseService;

    public HouseController(HouseService houseService) {
        this.houseService = houseService;
    }

    // Display all houses
    @GetMapping
    public String listHouses(Model model) {

        model.addAttribute(
                "houses",
                houseService.getAllHouses()
        );

        return "admin/house-list";
    }

    // Display add-property form
    @GetMapping("/new")
    public String showCreateForm(Model model) {

        House house = new House();

        loadFormData(model);
        model.addAttribute("house", house);

        return "admin/house-form";
    }

    // Save or update property
    @PostMapping("/save")
    public String saveHouse(
            @ModelAttribute("house") House house,

            @RequestParam(value = "locationId", required = false)
            Long locationId,

            @RequestParam(value = "propertyTypeId", required = false)
            Long propertyTypeId,

            @RequestParam(value = "amenityIds", required = false)
            Long[] amenityIds,

            @RequestParam(value = "imageFile", required = false)
            MultipartFile imageFile,

            RedirectAttributes redirectAttributes) {

        try {

            houseService.saveHouse(
                    house,
                    locationId,
                    propertyTypeId,
                    amenityIds,
                    imageFile
            );

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Property saved successfully."
            );

        } catch (Exception e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    "Error while saving property: " + e.getMessage()
            );
        }

        return "redirect:/admin/houses";
    }

    // Display edit-property form
    @GetMapping("/edit/{id}")
    public String showEditForm(
            @PathVariable("id") Long id,
            Model model,
            RedirectAttributes redirectAttributes) {

        try {

            House house = houseService.getHouseById(id);

            if (house == null) {

                redirectAttributes.addFlashAttribute(
                        "errorMessage",
                        "Property not found with ID: " + id
                );

                return "redirect:/admin/houses";
            }

            /*
             * Do not create a new PropertyOwner here.
             * Keep the existing owner loaded from the database.
             */

            loadFormData(model);
            model.addAttribute("house", house);

            return "admin/house-form";

        } catch (Exception e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    "Unable to edit property: " + e.getMessage()
            );

            return "redirect:/admin/houses";
        }
    }

    // Delete property
    @PostMapping("/delete/{id}")
    public String deleteHouse(
            @PathVariable("id") Long id,
            RedirectAttributes redirectAttributes) {

        try {

            houseService.deleteHouse(id);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Property deleted successfully."
            );

        } catch (Exception e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    "Error while deleting property: " + e.getMessage()
            );
        }

        return "redirect:/admin/houses";
    }

    // Load dropdown and amenity data
    private void loadFormData(Model model) {

        model.addAttribute(
                "locations",
                houseService.getAllLocations()
        );

        model.addAttribute(
                "propertyTypes",
                houseService.getAllPropertyTypes()
        );

        model.addAttribute(
                "amenities",
                houseService.getAllAmenities()
        );
    }
}