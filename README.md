# Read Me First


1. Current Docker File expects jar file generated in target folder, So using maven Command;
mvn clean install -DskipTests
2. Use command this syntax to generate Docker image: "docker build -t image-name:tag ."
        docker build -t simple-spring:1.0.0 .
3. Run Using Following Command or From Docker Desktop, Set port as needed
        docker run --rm -p 7001:7001 ilfs3-backend:latest