# From gumball-v2.1
all: clean

clean:
	mvn clean

compile:
	mvn compile

run: compile
	mvn spring-boot:run

build:
	mvn package

run-jar: build
	java -jar target/spring-payments-1.0.jar

# Docker

docker-build: build
	docker build -t spring-payments-1.0 .
	docker images

docker-run: docker-build
	docker run --name spring-payments-1.0 -td -p 80:8080 spring-payments-1.0
	docker ps

docker-clean:
	docker stop spring-payments-1.0
	docker rm spring-payments-1.0
	docker rmi spring-payments-1.0

docker-shell:
	docker exec -it spring-payments-1.0 bash

docker-push:
	docker login
	docker build -t $(account)/spring-payments:v1 .
	docker push $(account)/spring-payments:v1

# Compose

network-ls:
	docker network ls 

network-create:
	docker network create --driver bridge ${network}

network-prune:
	docker network prune

compose-up:
	docker-compose up --scale payments=2 -d

compose-down:
	docker-compose down 	

lb-stats:
	echo "user = admin | password = admin"
	open http://localhost:1936

lb-test:
	open http://localhost





