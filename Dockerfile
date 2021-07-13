#
# Build stage
#
FROM maven:3.8.1-openjdk-11-slim AS build
WORKDIR /home/ec2-user/eurekaserver
COPY ./ ./
RUN mvn -v
RUN mvn clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/ec2-user/eurekaserver/target/eurekaserver-0.0.1-SNAPSHOT.jar /usr/local/lib/eurekaserver.jar
EXPOSE 8090
ENTRYPOINT ["java","-jar","/usr/local/lib/eurekaserver.jar"]