package com.smarthouse.config;

import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SessionConfig {

    @Bean
    public ServletContextInitializer sessionTimeoutInitializer() {
        return servletContext -> {
            // Session timeout: 15 minute for testing
            servletContext.setSessionTimeout(15);
        };
    }
}