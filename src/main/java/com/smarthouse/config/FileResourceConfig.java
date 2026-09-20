package com.smarthouse.config;

import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class FileResourceConfig implements WebMvcConfigurer {

    @Value("${smarthouse.upload.directory:${user.dir}/uploads/properties}")
    private String uploadDirectory;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        String uploadPath = Paths
                .get(uploadDirectory)
                .toAbsolutePath()
                .normalize()
                .toUri()
                .toString();

        registry.addResourceHandler("/uploads/properties/**")
                .addResourceLocations(uploadPath);
    }
}