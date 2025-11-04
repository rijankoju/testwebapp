FROM gradle:8.10.0-jdk17-alpine AS build
WORKDIR /app
COPY build.gradle settings.gradle ./
COPY src ./src
RUN gradle bootJar --no-daemon -x test

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/test-app.jar test-app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "test-app.jar"]
