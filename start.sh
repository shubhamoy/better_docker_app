#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

CHECK_REDIS_IMAGE=$(docker images -q redis:latest 2> /dev/null)
CHECK_REDIS_CONTAINER=$(docker ps -a | grep redis1 2> /dev/null)

if [ -z "$CHECK_REDIS_IMAGE" ]; then
  printf "${GREEN}=============================================================\n"
  printf "\t${RED}Redis Image Not Found. ${YELLOW}Trying to Pull from Hub.\n"
  printf "${GREEN}=============================================================\n"
  docker pull redis
fi

if [ -z "$CHECK_REDIS_CONTAINER" ]; then
  printf "${GREEN}=============================================================\n"
  printf "\t\t${BLUE}Creating Redis Container\n"
  printf "${GREEN}=============================================================\n"
  docker run -d --name redis1 redis
else
  printf "${GREEN}=============================================================\n"
  printf "\t\t${BLUE}Starting Redis Container\n"
  printf "${GREEN}=============================================================\n"
  docker start redis1
fi

REDIS_HOST=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' redis1)

CHECK_BACKEND_IMAGE=$(docker images -q shubhamoy/backend_docker_app:latest 2> /dev/null)
CHECK_BACK_CONTAINER=$(docker ps -a | grep smoy_back 2> /dev/null)

if [ -z "$CHECK_BACKEND_IMAGE" ]; then
  printf "${GREEN}=============================================================\n"
  printf "\t${RED}Backend Image Not Found. ${YELLOW}Trying to Pull from Hub.\n"
  printf "${GREEN}=============================================================\n"
  docker pull shubhamoy/backend_docker_app
fi

if [ -z "$CHECK_BACK_CONTAINER" ]; then
  printf "${GREEN}=============================================================\n"
  printf "\t\t${BLUE}Creating Backend Container\n"
  printf "${GREEN}=============================================================\n"
  docker run -d -e REDIS_HOST=${REDIS_HOST} --link redis1:redis --name smoy_back shubhamoy/backend_docker_app
else
  printf "${GREEN}=============================================================\n"
  printf "\t\t${BLUE}Starting Backend Container\n"
  printf "${GREEN}=============================================================\n"
  docker start smoy_back
fi

CHECK_FRONTEND_IMAGE=$(docker images -q shubhamoy/frontend_docker_app:latest 2> /dev/null)
CHECK_FRONT_CONTAINER=$(docker ps -a | grep smoy_front 2> /dev/null)

if [ -z "$CHECK_FRONTEND_IMAGE" ]; then
  printf "${GREEN}=============================================================\n"
  printf "\t${RED}Frontend Image Not Found. ${YELLOW}Trying to Pull from Hub.\n"
  printf "${GREEN}=============================================================\n"
  docker pull shubhamoy/frontend_docker_app
fi

if [ -z "$CHECK_FRONT_CONTAINER" ]; then
  printf "${GREEN}=============================================================\n"
  printf "\t\t${BLUE}Creating Frontend Container\n"
  printf "${GREEN}=============================================================\n"
  docker run -d -p 3000:3000 -e REDIS_HOST=${REDIS_HOST} --link redis1:redis --name smoy_front shubhamoy/frontend_docker_app
else
  printf "${GREEN}=============================================================\n"
  printf "\t\t${BLUE}Starting Frontend Container\n"
  printf "${GREEN}=============================================================\n"
  docker start smoy_front
fi

printf "${GREEN}=============================================================\n"
printf "\t${BLUE}Point your browser to http://127.0.0.1:3000\n"
printf "${GREEN}=============================================================\n"