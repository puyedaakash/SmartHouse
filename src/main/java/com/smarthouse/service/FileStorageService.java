package com.smarthouse.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileStorageService {

    private final Path uploadDirectory;
    private final long maximumFileSize;

    private static final Set<String> ALLOWED_EXTENSIONS =
            Set.of("jpg", "jpeg", "png", "webp");

    private static final Set<String> ALLOWED_CONTENT_TYPES =
            Set.of("image/jpeg", "image/png", "image/webp");

    public FileStorageService(
            @Value("${smarthouse.upload.directory}") String directory,
            @Value("${smarthouse.upload.max-size-bytes:5242880}") long maximumFileSize) {

        this.uploadDirectory = Paths.get(directory)
                .toAbsolutePath()
                .normalize();

        this.maximumFileSize = maximumFileSize;

        try {
            Files.createDirectories(this.uploadDirectory);
        } catch (IOException e) {
            throw new IllegalStateException(
                    "Unable to create image upload directory.", e);
        }
    }

    public String storeImage(MultipartFile file) {

        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException(
                    "Please select a property image.");
        }

        if (file.getSize() > maximumFileSize) {
            throw new IllegalArgumentException(
                    "Image size must not exceed 5 MB.");
        }

        String contentType = file.getContentType();

        if (contentType == null ||
                !ALLOWED_CONTENT_TYPES.contains(contentType.toLowerCase())) {

            throw new IllegalArgumentException(
                    "Only JPG, JPEG, PNG and WEBP images are allowed.");
        }

        String originalFilename = file.getOriginalFilename();

        if (!StringUtils.hasText(originalFilename)) {
            throw new IllegalArgumentException(
                    "Invalid image filename.");
        }

        String extension = StringUtils
                .getFilenameExtension(originalFilename);

        if (extension == null) {
            throw new IllegalArgumentException(
                    "Image extension is missing.");
        }

        extension = extension.toLowerCase();

        if (!ALLOWED_EXTENSIONS.contains(extension)) {
            throw new IllegalArgumentException(
                    "Only JPG, JPEG, PNG and WEBP images are allowed.");
        }

        String generatedFilename =
                UUID.randomUUID() + "." + extension;

        Path targetPath = uploadDirectory
                .resolve(generatedFilename)
                .normalize();

        if (!targetPath.startsWith(uploadDirectory)) {
            throw new IllegalArgumentException(
                    "Invalid image path.");
        }

        try {
            Files.copy(file.getInputStream(), targetPath);

            return generatedFilename;

        } catch (IOException e) {
            throw new IllegalArgumentException(
                    "Unable to save the property image.", e);
        }
    }

    public void deleteImage(String filename) {

        if (!StringUtils.hasText(filename)) {
            return;
        }

        try {
            Path imagePath = uploadDirectory
                    .resolve(filename)
                    .normalize();

            if (!imagePath.startsWith(uploadDirectory)) {
                return;
            }

            Files.deleteIfExists(imagePath);

        } catch (IOException e) {
            // Do not stop property deletion if image deletion fails.
            System.err.println(
                    "Unable to delete image: " + filename);
        }
    }
}