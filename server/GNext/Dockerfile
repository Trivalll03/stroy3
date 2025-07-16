FROM openjdk:17-jdk-slim
VOLUME /tmp
COPY target/builder_chat-3.2.0.jar app.jar
COPY firebase.json /app/firebase.json
ENV GOOGLE_APPLICATION_CREDENTIALS=/app/firebase.json
ENTRYPOINT ["java","-jar","/app.jar"]
