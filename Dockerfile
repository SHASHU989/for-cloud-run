FROM maven:3.8-jdk-11 as builder
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B package --file pom.xml -DskipTests 
#FROM openjdk:14-slim
FROM openjdk:11.0.12
ENV JAVA_OPTS -Dsecurerandom.source=file:/stage/urandom 
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","app.jar"]



