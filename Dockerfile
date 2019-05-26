FROM maven as base

COPY pom.xml /opt/pom.xml
WORKDIR /opt
RUN mvn dependency:resolve
COPY . /opt/
RUN mvn package

FROM openjdk:13-alpine
COPY --from=base /opt/target/spring-boot-docker-0.1.0.jar /app.jar
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
