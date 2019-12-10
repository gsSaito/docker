STACK=gitlab
COMPOSE_FILE=docker-compose.yml
CONTAINER=${STACK}_gitlab_1

start:
	docker-compose -f ${COMPOSE_FILE} -p ${STACK} up -d
stop:
	docker-compose -p ${STACK} stop
remove:
	docker-compose -p ${STACK} down
logs:
	docker-compose -p ${STACK} logs -f
shell:
	winpty docker exec -it ${CONTAINER} bash

	
backup:
	docker exec ${STACK}_volumerize_1 backup
backupfull:
	docker exec ${STACK}_volumerize_1 backupFull
restore:
	docker exec ${STACK}_volumerize_1 restore
backup_shell:
	docker exec -it ${STACK}_volumerize_1 bash
