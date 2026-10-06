# Step 1: Use an official, lightweight Java 21 JRE runtime environment based on Alpine Linux
FROM eclipse-temurin:21-jre-alpine

# Step 2: Set a secure, dedicated execution directory inside the container
WORKDIR /app

# Step 3: Copy the fat JAR compiled by your Maven Shade stage into the container
# This automatically catches 'jb-hello-world-maven-0.2.0.jar' and renames it cleanly
COPY target/*.jar app.jar

# Step 4: Define the container execution command to run your hello.HelloWorld application
ENTRYPOINT ["java", "-jar", "app.jar"]
