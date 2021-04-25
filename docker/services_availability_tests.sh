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

function serices_availability_check {

   PROMETHEUS_NGINX_HOST_URI="$1"
   PROMETHEUS_PORT_MONITORING_ALT_SERVER="$2"
   PROMETHEUS_PORT_WEB_PROX_LTS="$3"

   printf "It is check for:\n NGINX HOST URI=%s\n PORT FOR MONITORING ALT SERVER=%s\n PORT WEB PROX LTS=%s\n" "$PROMETHEUS_NGINX_HOST_URI" "$PROMETHEUS_PORT_MONITORING_ALT_SERVER" "$PROMETHEUS_PORT_WEB_PROX_LTS"

  AVAILABILITY_STATUS=false

  # url check list 
  declare -a req_url=(
    "http://${PROMETHEUS_NGINX_HOST_URI}" #80
    "http://${PROMETHEUS_NGINX_HOST_URI}:${PROMETHEUS_PORT_MONITORING_ALT_SERVER}/" # 9090
    "https://${PROMETHEUS_NGINX_HOST_URI}:${PROMETHEUS_PORT_WEB_PROX_LTS}/"
  ) # 443

  function serices_availability_check_test {
    for url in "${req_url[@]}"; do
      status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
      if [[ "$status" = 200 ]]; then
        echo  status : $status "for the:" $url "service is available"
       else
        echo status : $status "for the:" $url "< service is not available"
        AVAILABILITY_STATUS=true
      fi
    done
  }

  serices_availability_check_test
  echo $AVAILABILITY_STATUS
  [ "$AVAILABILITY_STATUS" = true ] && echo "WARNING! there are one or more unavailable resources." || echo "All services are available."
}




# exit