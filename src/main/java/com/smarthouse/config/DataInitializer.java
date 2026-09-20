package com.smarthouse.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.smarthouse.entity.Role;
import com.smarthouse.repository.RoleRepository;

@Configuration
public class DataInitializer {

    @Bean
    CommandLineRunner initializeRoles(RoleRepository roleRepository) {

        return args -> {

            if (roleRepository.findByName("USER").isEmpty()) {
                roleRepository.save(new Role("USER"));
            }

            if (roleRepository.findByName("ADMIN").isEmpty()) {
                roleRepository.save(new Role("ADMIN"));
            }
        };
    }
}