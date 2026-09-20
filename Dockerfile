# =========================
# Stage 1: Build the project
# =========================
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copy Maven configuration
COPY pom.xml .

# Copy source code
COPY src ./src

# Build the Spring Boot WAR file
RUN mvn clean package -DskipTests

# Rename the generated WAR file
RUN cp target/*.war app.war


# =========================
# Stage 2: Run the application
# =========================
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the WAR file from the build stage
COPY --from=build /app/app.war app.war

# Render provides the PORT environment variable
EXPOSE 8080

# Start the Spring Boot application
ENTRYPOINT ["sh", "-c", "java -jar app.war --server.port=${PORT:-8080}"]