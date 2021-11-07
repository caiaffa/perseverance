.PHONY: test stop build run iex
PROJECT_NAME = perseverance

stop:
	@docker stop ${PROJECT_NAME} || true && docker rm ${PROJECT_NAME}|| true
	@docker-compose down

build: stop
	@docker-compose build
	
run: stop
	@docker-compose up -d

test:
	@docker-compose exec --env MIX_ENV=test ${PROJECT_NAME} mix test

logs:
	@docker logs ${PROJECT_NAME} -f 

iex:
	@docker-compose exec ${PROJECT_NAME} iex --erl "-kernel shell_history enabled" -S mix
	
restart_app:
	@docker-compose stop ${PROJECT_NAME} && docker-compose up -d ${PROJECT_NAME}