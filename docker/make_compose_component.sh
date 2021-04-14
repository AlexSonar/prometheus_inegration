#!/usr/bin/env bash

#-------------------------------------------------------------
# Automated solution for integrating continuous monitoring systems Prometheus
# Comprehensive guide available at: 
# https://octoops.github.io/en/continuing-processes/monitoring/prometheus/integration/prometheus-integration#top  
# docker-compose version: "3.8"
# For full details on what each version includes and how to upgrade, see: 
# Compose and Docker compatibility matrix
# https://docs.docker.com/compose/compose-file/
#
# Copyleft (c) by Alex Sonar 2021
#-------------------------------------------------------------

cat << info
docker compose start
info

./variables_default.sh

docker-compose up -d

sleep 3
docker-compose ps

docker exec -d docker_web_1  bash /etc/prometheus/installers/install_sudo_on_debian.sh
