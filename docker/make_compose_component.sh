#!/usr/bin/env bash

#-------------------------------------------------------------
# Automated solution for integrating continuous monitoring systems Prometheus
# "Ready to go; the example configuration is set up to use Docker-compose
# Comprehensive guide available at: 
# https://alexsonar.github.io/en/continuous-processes/monitoring/prometheus_inegration
# docker-compose version: "3.8"
# For full details on what each version includes and how to upgrade, see: 
# Compose and Docker compatibility matrix
# https://docs.docker.com/compose/compose-file/
#
# Copyleft (c) by Alex Sonar 2021
#-------------------------------------------------------------



# Check for required tools
declare -a req_tools=("sudo" "docker" "docker-compose" "sed" "curl" "jq")
for tool in "${req_tools[@]}"; do
  if ! command -v "$tool" > /dev/null; then
    fail "It looks like '${tool}' is not installed; please install it and run this setup script again."
    exit 1
  fi
done

# Set up an interrupt handler so we can exit gracefully
interrupt_count=0
interrupt_handler() {
  ((interrupt_count += 1))

  echo ""
  if [[ $interrupt_count -eq 1 ]]; then
    fail "Really quit? Hit ctrl-c again to confirm."
  else
    echo "Goodbye!"
    exit
  fi
}
trap interrupt_handler SIGINT SIGTERM

cat << info
docker compose start
info

function set_env_vars_default {
echo "set_env_vars_default"
sudo chmod +x -Rfv *
. ./set_env_vars_default.sh
}

function set_env_vars_default2 {
echo "set_env_vars_default 2"
sudo chmod +x -Rfv docker/*
. docker/set_env_vars_default.sh
}

[ -f set_env_vars_default.sh ] && set_env_vars_default || set_env_vars_default2


function make_compose { 
docker-compose -f docker-compose.yml up -d
sleep 3
docker-compose ps
}

function make_compose2 {
  # cat docker/docker-compose.yml
  cat $PWD/docker/docker-compose.yml
  docker-compose -f $PWD/docker/docker-compose.yml up -d 
  sleep 3
  docker-compose -f $PWD/docker/docker-compose.yml ps
} 

[ -f docker-compose.yml ] && echo "starts the containers in detached mode "; make_compose || echo "the containers started in detached mode";  make_compose2

# docker-compose up -d


sleep 6

# docker exec -d docker_web_1 bash /etc/prometheus/installers/install_base_tools.sh
docker exec -d docker_web_1 bash /etc/prometheus/installers/install_base_tools.sh
sleep 3
# curl -s -o /dev/null -w "%{http_code}" 0.0.0.0:9

if [[ $interrupt_count -eq 1 ]]; then
    fail "Really quit? Hit ctrl-c again to confirm."
  else
    echo "No interruptions count!"    
fi

function services_availability_tests {
  . ./services_availability_tests.sh
  }

function services_availability_tests2 {
  . docker/services_availability_tests.sh
  }

[ -f ./services_availability_tests.sh ] && services_availability_tests || services_availability_tests2

echo "visit to ${PROMETHEUS_NGINX_HOST_URI}:9090/graph"

docker exec docker_web_1 service --status-all


exit
# function has_yum {
#   [[ -n "$(command -v yum)" ]]
# }

# function has_apt_get {
#   [[ -n "$(command -v apt-get)" ]]
# }

# function install_dependencies {
#   # log_info "Installing dependencies"

#   if $(has_apt_get); then
#     # sudo apt-get update -y
#     # sudo DEBIAN_FRONTEND=noninteractive apt-get install -y awscli curl unzip jq libcap2-bin
#     echo "it is use apt-get"
#   elif $(has_yum); then
#     # sudo yum update -y
#     # sudo yum install -y awscli curl unzip jq
#     echo "it is use yum"
#   else
#     log_error "Could not find apt-get or yum. Cannot install dependencies on this OS."
#     exit 1
#   fi
# }

# install_dependencies
