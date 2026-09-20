package com.smarthouse.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smarthouse.entity.State;
import com.smarthouse.service.StateService;

@Controller
@RequestMapping("/admin/states")
public class StateController {

    private final StateService stateService;

    public StateController(StateService stateService) {
        this.stateService = stateService;
    }

    // View all states
    @GetMapping
    public String listStates(Model model) {

        model.addAttribute(
                "states",
                stateService.getAllStates()
        );

        return "admin/state-list";
    }

    // Show add form
    @GetMapping("/new")
    public String showCreateForm(Model model) {

        model.addAttribute(
                "state",
                new State()
        );

        return "admin/state-form";
    }

    // Save new state
    @PostMapping("/save")
    public String saveState(
            @ModelAttribute("state") State state,
            RedirectAttributes redirectAttributes) {

        try {

            stateService.saveState(state);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "State saved successfully."
            );

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage()
            );
        }

        return "redirect:/admin/states";
    }

    // Show edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(
            @PathVariable Long id,
            Model model) {

        model.addAttribute(
                "state",
                stateService.getStateById(id)
        );

        return "admin/state-form";
    }

    // Delete state
    @PostMapping("/delete/{id}")
    public String deleteState(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        try {

            stateService.deleteState(id);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "State deleted successfully."
            );

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    e.getMessage()
            );
        }

        return "redirect:/admin/states";
    }
}