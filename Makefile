all : up
up :
	@docker-compose -f  ./srcs/docker-compose.yaml up
build :
	@docker-compose -f  ./srcs/docker-compose.yaml build
down :
	@docker-compose -f ./srcs/docker-compose.yaml down
stop :
	@docker-compose -f ./srcs/docker-compose.yaml stop
start :
	@docker-compose -f ./srcs/docker-compose.yaml start
clean :
	@docker-compose -f ./srcs/docker-compose.yaml down --volumes
	@rm -rf /Users/snouae/data/mariadb/*
	@rm -rf /Users/snouae/data/wordpress/*
	@docker image rm $$(docker image ls -q)
