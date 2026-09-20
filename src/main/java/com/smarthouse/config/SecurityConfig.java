package com.smarthouse.config;

import jakarta.servlet.DispatcherType;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.smarthouse.security.RoleBasedAuthenticationSuccessHandler;

@Configuration
public class SecurityConfig {

    private final RoleBasedAuthenticationSuccessHandler
            authenticationSuccessHandler;

    public SecurityConfig(
            RoleBasedAuthenticationSuccessHandler authenticationSuccessHandler) {

        this.authenticationSuccessHandler = authenticationSuccessHandler;
    }

    // =========================================================
    // PASSWORD ENCODER
    // =========================================================

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // =========================================================
    // SECURITY FILTER CHAIN
    // =========================================================

    @Bean
    public SecurityFilterChain securityFilterChain(
            HttpSecurity http) throws Exception {

        http

            // =================================================
            // CSRF PROTECTION
            // =================================================

            .csrf(csrf -> {
                // CSRF protection is enabled.
                // JSP POST forms must include the CSRF token.
            })

            // =================================================
            // AUTHORIZATION
            // =================================================

            .authorizeHttpRequests(auth -> auth

                .dispatcherTypeMatchers(
                    DispatcherType.FORWARD,
                    DispatcherType.ERROR
                )
                .permitAll()

                .requestMatchers(
                    "/",
                    "/home/**",
                    "/login",
                    "/register",
                    "/error",
                    "/access-denied",
                    "/properties/**",
                    "/css/**",
                    "/js/**",
                    "/images/**",
                    "/fonts/**"
                )
                .permitAll()

                .requestMatchers("/user/**")
                .hasRole("USER")

                .requestMatchers("/admin/**")
                .hasRole("ADMIN")

                .anyRequest()
                .authenticated()
            )

            // =================================================
            // LOGIN
            // =================================================

            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .successHandler(authenticationSuccessHandler)
                .failureUrl("/login?error=true")
                .permitAll()
            )

            // =================================================
            // SESSION MANAGEMENT
            // =================================================

            .sessionManagement(session -> session

                // Handle an invalid or expired session ID
                .invalidSessionUrl("/login?sessionExpired=true")

                // Protect against session fixation
                .sessionFixation(sessionFixation ->
                    sessionFixation.migrateSession()
                )

                // Allow only one active session per user
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
            )

            // =================================================
            // ACCESS DENIED
            // =================================================

            .exceptionHandling(exception -> exception
                .accessDeniedPage("/access-denied")
            )

            // =================================================
            // LOGOUT
            // =================================================

            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .clearAuthentication(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            );

        return http.build();
    }
}