STACK=jenkins
COMPOSE_FILE=docker-compose.yml
CONTAINER=${STACK}_jenkins_1

start:
	docker-compose -f ${COMPOSE_FILE} -p ${STACK} up -d
stop:
	docker-compose -p ${STACK} stop
remove:
	docker-compose -p ${STACK} down
logs:
	docker-compose -p ${STACK} logs -f
shell:
	docker exec -it ${CONTAINER} bash

build:
	docker-compose -f ${COMPOSE_FILE} build
rebuild:
	docker-compose -f ${COMPOSE_FILE} build --no-cache

config:
	docker cp ./jenkins/id_rsa jenkins_jenkins_1:/var/jenkins_home/.ssh/id_rsa
