#!/bin/bash
docker stop $(docker ps -aq)
docker rm $(docker ps -qa)
docker volume rm $(docker volume ls -q)
docker network rm $(docker network ls -q) 2>/dev/null
docker image rm $(docker image ls -q)
        
sudo rm -rf /home/snouae/Desktop/data/mariadb/*
sudo rm -rf /home/snouae/Desktop/data/wordpress/*