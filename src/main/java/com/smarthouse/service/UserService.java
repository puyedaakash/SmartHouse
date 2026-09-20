package com.smarthouse.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.smarthouse.dto.RegistrationRequest;
import com.smarthouse.entity.Role;
import com.smarthouse.entity.User;
import com.smarthouse.repository.RoleRepository;
import com.smarthouse.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;

    private final RoleRepository roleRepository;

    private final PasswordEncoder passwordEncoder;


    public UserService(
            UserRepository userRepository,
            RoleRepository roleRepository,
            PasswordEncoder passwordEncoder) {

        this.userRepository = userRepository;

        this.roleRepository = roleRepository;

        this.passwordEncoder = passwordEncoder;
    }


    // =========================================================
    // CHECK EMAIL
    // =========================================================

    public boolean existsByEmail(String email) {

        return userRepository.existsByEmail(email);
    }


    // =========================================================
    // REGISTER USER
    // =========================================================

    public User registerUser(
            RegistrationRequest registrationRequest) {

        if (userRepository.existsByEmail(
                registrationRequest.getEmail())) {

            throw new IllegalArgumentException(
                    "An account with this email already exists."
            );
        }


        User user = new User();


        user.setName(
                registrationRequest.getName()
        );


        user.setEmail(
                registrationRequest.getEmail()
        );


        user.setPassword(
                passwordEncoder.encode(
                        registrationRequest.getPassword()
                )
        );


        user.setEnabled(true);


        // -----------------------------------------------------
        // DEFAULT USER ROLE
        // -----------------------------------------------------

        Role userRole =
                roleRepository.findByName("USER")
                        .orElseThrow(
                                () -> new IllegalArgumentException(
                                        "USER role was not found."
                                )
                        );


        user.getRoles().add(userRole);


        return userRepository.save(user);
    }


    // =========================================================
    // FIND USER BY EMAIL
    // =========================================================

    public User getUserByEmail(String email) {

        return userRepository.findByEmail(email)
                .orElseThrow(
                        () -> new IllegalArgumentException(
                                "User not found."
                        )
                );
    }


    // =========================================================
    // UPDATE USER NAME
    // =========================================================

    public void updateName(
            String email,
            String name) {

        User user =
                getUserByEmail(email);


        if (name == null ||
                name.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Name cannot be empty."
            );
        }


        String updatedName =
                name.trim();


        if (updatedName.length() < 2) {

            throw new IllegalArgumentException(
                    "Name must contain at least 2 characters."
            );
        }


        if (updatedName.length() > 100) {

            throw new IllegalArgumentException(
                    "Name cannot exceed 100 characters."
            );
        }


        user.setName(updatedName);


        userRepository.save(user);
    }


    // =========================================================
    // CHANGE PASSWORD
    // =========================================================

    public void changePassword(
            String email,
            String currentPassword,
            String newPassword,
            String confirmPassword) {


        User user =
                getUserByEmail(email);


        // -----------------------------------------------------
        // CURRENT PASSWORD
        // -----------------------------------------------------

        if (currentPassword == null ||
                currentPassword.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Current password is required."
            );
        }


        // -----------------------------------------------------
        // VERIFY CURRENT PASSWORD
        // -----------------------------------------------------

        if (!passwordEncoder.matches(
                currentPassword,
                user.getPassword())) {

            throw new IllegalArgumentException(
                    "Current password is incorrect."
            );
        }


        // -----------------------------------------------------
        // NEW PASSWORD
        // -----------------------------------------------------

        if (newPassword == null ||
                newPassword.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "New password is required."
            );
        }


        if (newPassword.length() < 8) {

            throw new IllegalArgumentException(
                    "New password must contain at least 8 characters."
            );
        }


        // -----------------------------------------------------
        // CONFIRM PASSWORD
        // -----------------------------------------------------

        if (confirmPassword == null ||
                confirmPassword.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Please confirm your new password."
            );
        }


        if (!newPassword.equals(confirmPassword)) {

            throw new IllegalArgumentException(
                    "New password and confirm password must match."
            );
        }


        // -----------------------------------------------------
        // PREVENT SAME PASSWORD
        // -----------------------------------------------------

        if (passwordEncoder.matches(
                newPassword,
                user.getPassword())) {

            throw new IllegalArgumentException(
                    "New password must be different from your current password."
            );
        }


        // -----------------------------------------------------
        // SAVE NEW PASSWORD
        // -----------------------------------------------------

        user.setPassword(
                passwordEncoder.encode(newPassword)
        );


        userRepository.save(user);
    }
}