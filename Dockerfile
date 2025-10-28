# ---------- Build stage :::: If We Want to Build Jar File Also ----------
#FROM maven:3.9-eclipse-temurin-21 AS build
#WORKDIR /src
#COPY pom.xml .
#RUN --mount=type=cache,target=/root/.m2 mvn -q -DskipTests dependency:go-offline
#COPY src ./src
#RUN --mount=type=cache,target=/root/.m2 mvn -q -DskipTests package

# ---------- Runtime stage ----------

#1: Download JDK
#FROM openjdk:21-jdk      ::: Old, New Recommendation is to Use Eclipse Temurin
FROM eclipse-temurin:21-jre-alpine

#2 [Optional But important security hardening step]
# By default, Docker containers run as root, which means:
#    By default, Docker containers run as root, which means:
#    Any code compromise (RCE, exploit, etc.) gets root access inside the container.
#    If the container is misconfigured (e.g., --privileged, writable volumes), the attacker could potentially escape or modify the host.
#    all subsequent commands (including the app startup) run without root privileges.
RUN addgroup -S spring && adduser -S spring -G spring

#3 Set Workdirectory
WORKDIR /opt/app

#ENV TZ=Asia/Dubai
#RUN apk add --no-cache tzdata && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setting Certificates
# Cert ARGs with valid names
#ARG CERT_TAHSEEL_STG=cert/certificate1.crt
#ARG CERT_PROXY=cert/Proxy1.cer
#ARG CERT_LDAP_TEST=cert/EXT-AD-Test-2023.cer
#
#COPY cert/ ./cert/
#RUN set -eux; cd "$JAVA_HOME/lib/security"; \
#  for P in \
#    "$CERT_TAHSEEL_STG|services.tahseel.stg" \
#    "$CERT_PROXY|proxy.cert" \
#    "$CERT_LDAP_TEST|ldap.test" \
#  ; do \
#    FILE="${P%%|*}"; ALIAS="${P##*|}"; \
#    if [ -f "/opt/app/$FILE" ]; then \
#      keytool -keystore cacerts -storepass changeit -noprompt -trustcacerts \
#        -importcert -alias "$ALIAS" -file "/opt/app/$FILE"; \
#    fi; \
#  done; \
#  rm -rf /opt/app/cert

#COPY --from=build /src/target/*.jar /opt/app/app.jar ::: Use In Case We enabled Build phase above,
COPY target/*.jar /opt/app/app.jar

ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75 -Duser.timezone=Asia/Dubai"
EXPOSE 7001
USER spring

#ENTRYPOINT ["java", "-Xms2g", "-Xmx4g" , "-XX:+UseG1GC" , "-XX:MaxGCPauseMillis=200" ,"-jar","/opt/workdir/ILFS3-Backend.jar"]

ENTRYPOINT ["java","-jar","/opt/app/app.jar"]
