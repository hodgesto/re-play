FROM openjdk:8-alpine

COPY target/uberjar/re-play.jar /re-play/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/re-play/app.jar"]
