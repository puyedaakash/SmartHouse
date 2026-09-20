package com.smarthouse.util;

import java.util.Locale;

public final class PriceFormatter {

    private PriceFormatter() {
    }

    public static String format(double price) {

        if (price < 0) {
            return "₹0";
        }

        if (price >= 10_000_000) {

            double crore = price / 10_000_000.0;

            return String.format(
                    Locale.US,
                    "₹%.2f Crore",
                    crore
            );
        }

        if (price >= 100_000) {

            double lakh = price / 100_000.0;

            return String.format(
                    Locale.US,
                    "₹%.2f Lakh",
                    lakh
            );
        }

        return String.format(
                Locale.US,
                "₹%,.0f",
                price
        );
    }
}