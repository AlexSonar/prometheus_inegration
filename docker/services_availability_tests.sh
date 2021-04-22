#!/bin/bash

#-------------------------------------------------------------
# Automated solution for integrating continuous monitoring systems Prometheus
# "Ready to go; the example configuration is set up to use Docker-compose
# Comprehensive guide available at: 
# https://alexsonar.github.io/en/continuous-processes/monitoring/prometheus_inegration
#
# Copyleft (c) by Alex Sonar 2021
#-------------------------------------------------------------

# cat << info
# nginx_test
# prometheys_http
# prometheys_http
# info


# url check list 
declare -a req_url=(
  "http://${PROMETHEUS_NGINX_HOST_URI}" #80
  "http://${PROMETHEUS_NGINX_HOST_URI}:${PROMETHEUS_PORT_MONITORING_ALT_SERVER}/" # 9090
  "https://${PROMETHEUS_NGINX_HOST_URI}:${PROMETHEUS_PORT_WEB_PROX_LTS}/"
  ) # 443

function serices_availability_check {
  for url in "${req_url[@]}"; do
  status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
  if [[ "$status" = 200 ]]; then
    echo  status : $status "for the:" $url "service is available"
  else
    echo status : $status "for the:" $url "< service is not available"
  fi
  done
}

serices_availability_check

# exit