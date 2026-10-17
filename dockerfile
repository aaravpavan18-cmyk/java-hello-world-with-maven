# Step 1: Use an official, lightweight Java 21 JRE runtime environment based on Alpine Linux
FROM azul-zulu:21-jre-alpine
RUN mkdir -p /app

# Requirement 5: Declare the build argument to receive the upstream build number passed from Jenkins
ARG APP_VERSION=unknown
# Persist the value as an environment variable so your Java application can read it at runtime
ENV DEPLOYED_VERSION=${APP_VERSION}

# Step 2: Set a secure, dedicated execution directory inside the container
WORKDIR /app

# Step 3: Copy the fat JAR compiled by your Maven Shade stage into the container
COPY target/*.jar /app/

# Step 4: Define the container execution command to run your hello.HelloWorld application
ENTRYPOINT ["java", "-jar", "/app/jb-hello-world-maven-0.2.0.jar"]

