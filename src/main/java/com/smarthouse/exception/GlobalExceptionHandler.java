package com.smarthouse.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(IllegalArgumentException.class)
    public String handleIllegalArgumentException(
            IllegalArgumentException exception,
            Model model) {

        String message = exception.getMessage();

        if (message == null || message.trim().isEmpty()) {
            message = "Invalid request.";
        }

        model.addAttribute(
                "errorMessage",
                message
        );

        return "common/error";
    }


    @ExceptionHandler(Exception.class)
    public String handleGeneralException(
            Exception exception,
            Model model) {

        model.addAttribute(
                "errorMessage",
                "Something went wrong while processing your request."
        );

        return "common/error";
    }
}