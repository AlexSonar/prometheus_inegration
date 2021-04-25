#!/usr/bin/env bash

#-------------------------------------------------------------
# Automated solution for integrating continuous monitoring systems Prometheus
# Comprehensive guide available at: 
# https://alexsonar.github.io/en/continuous-processes/monitoring/prometheus_inegration 
# docker-compose version: "3.8"
# For full details on what each version includes and how to upgrade, see: 
# Compose and Docker compatibility matrix
# https://docs.docker.com/compose/compose-file/
#
#
#
# Copyleft (c) by Alex Sonar 2021
#-------------------------------------------------------------


# ports:
export PROMETHEUS_PORT_MONITORING_SERVER="9000"
export PROMETHEUS_PORT_MONITORING_ALT_SERVER="9090"
export PROMETHEUS_PORT_NODE_EXPORTER="100"
export PROMETHEUS_PORT_ALERT_MANAGER="9093"
export PROMETHEUS_PORT_BASE_CLUSTER_N0="5000"
export PROMETHEUS_PORT_BASE_CLUSTER_N1="5001"
export PROMETHEUS_PORT_BASE_CLUSTER_N2="5002"
export PROMETHEUS_PORT_GRAFANA="3000"
export PROMETHEUS_PORT_WEB_PROX="80"
export PROMETHEUS_PORT_NGINX_PORT="80"
export PROMETHEUS_PORT_WEB_PROX_LTS="443"
export PROMETHEUS_PORT_SSH="7922"

# volumes:
directory=$PWD
export PROMETHEUS_VOL_CORE="/etc/prometheus/"
export PROMETHEUS_VOL_DATA=$directory/prometheus
export PROMETHEUS_VOL_PROX="/etc/nginx/"

# environment:
export PROMETHEUS_ENV="-dev"
export PROMETHEUS_DOMAIN_NAME="prometheus-monnitoring"
export PROMETHEUS_DOMAIN_ZONE="net"
export PROMETHEUS_NGINX_HOST_URI="${PROMETHEUS_DOMAIN_NAME}${PROMETHEUS_ENV}.${PROMETHEUS_DOMAIN_ZONE}"

export PROMETHEUS_TARGET_HEAP_SIZE="524288000"
export PROMETHEUS_CONFIG_FILE="/etc/prometheus/prometheus.yml"
export PROMETHEUS_STORAGE_ON_SERVER="/prometheus"

# labels:
export PROMETHEUS_SERVICE_TITLE="prometheus_service"

# networks:
export PROMETHEUS_NETWORK_TYPE="bridge"

echo "var $SERVER"
ls $PROMETHEUS_VOL_DATA
echo $PROMETHEUS_VOL_DATA

