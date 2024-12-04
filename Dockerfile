#  # Step 1: Specify the base image
# FROM openjdk:19-jdk-alpine3.16

# # Step 2: Add a label
# LABEL maintainer="thisarak943@gmail.com"

# # Step 3: Copy the Spring Boot JAR file into the container
# ARG JAR_FILE=target/*.jar
# COPY ${JAR_FILE} app.jar

# # Step 4: Expose the application port
# EXPOSE 8080

# # Step 5: Run the application
# ENTRYPOINT ["java", "-jar", "/app.jar"]  



# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:19-jdk-alpine3.16
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

