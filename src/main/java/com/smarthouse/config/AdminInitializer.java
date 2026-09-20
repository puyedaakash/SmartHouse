package com.smarthouse.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.smarthouse.entity.Role;
import com.smarthouse.entity.User;
import com.smarthouse.repository.RoleRepository;
import com.smarthouse.repository.UserRepository;

@Configuration
public class AdminInitializer {

    @Value("${smarthouse.admin.email}")
    private String adminEmail;

    @Value("${smarthouse.admin.password}")
    private String adminPassword;

    @Bean
    CommandLineRunner initializeAdmin(
            UserRepository userRepository,
            RoleRepository roleRepository,
            PasswordEncoder passwordEncoder) {

        return args -> {

           Role adminRole = roleRepository.findByName("ADMIN")
        .orElseGet(() -> {
            Role newRole = new Role();
            newRole.setName("ADMIN");
            return roleRepository.save(newRole);
        });

            User adminUser = userRepository
                    .findByEmail(adminEmail)
                    .orElse(null);

            if (adminUser == null) {

                adminUser = new User();

                adminUser.setName("SmartHouse Admin");
                adminUser.setEmail(adminEmail);

                adminUser.setPassword(
                        passwordEncoder.encode(adminPassword)
                );

                adminUser.setEnabled(true);

                adminUser.getRoles().add(adminRole);

                userRepository.save(adminUser);

                System.out.println(
                        "=========================================="
                );

                System.out.println(
                        "Initial ADMIN account created."
                );

                System.out.println(
                        "Email: " + adminEmail
                );

                System.out.println(
                        "=========================================="
                );

            } else {

                // Assign ADMIN role if the user does not already have it
                if (adminUser.getRoles().stream()
                        .noneMatch(role ->
                                role.getName().equals("ADMIN"))) {

                    adminUser.getRoles().add(adminRole);
                }

                // Update the existing admin password
                adminUser.setPassword(
                        passwordEncoder.encode(adminPassword)
                );

                userRepository.save(adminUser);

                System.out.println(
                        "=========================================="
                );

                System.out.println(
                        "Admin password updated successfully."
                );

                System.out.println(
                        "Email: " + adminEmail
                );

                System.out.println(
                        "=========================================="
                );
            }
        };
    }
}