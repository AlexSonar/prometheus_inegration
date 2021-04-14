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

directory=$PWD
export PROMETHEUS_VOL_DATA=$directory/../../prometheus

# ports:
export PORT_PROMETHEUS_MONITORING_SERVER="9000"
export PORT_PROMETHEUS_MONITORING_ALT_SERVER="9090"
export PORT_PROMETHEUS_NODE_EXPORTER="100"
export PORT_PROMETHEUS_ALERT_MANAGER="9093"
export PORT_PROMETHEUS_BASE_CLUSTER_N0="5000"
export PORT_PROMETHEUS_BASE_CLUSTER_N1="5001"
export PORT_PROMETHEUS_BASE_CLUSTER_N2="5002"
export PORT_PROMETHEUS_GRAFANA="3000"
export PORT_PROMETHEUS_WEB_PROX="80"
export PORT_PROMETHEUS_WEB_PROX_LTS="443"
export PORT_PROMETHEUS_SSH="22"

# volumes:
export PROMETHEUS_VOL_CORE="/etc/prometheus/"
export PROMETHEUS_VOL_DATA="/prometheus"
export PROMETHEUS_VOL_PROX="/etc/nginx/"

# environment:
export PROMETHEUS_ENV="dev"
export PROMETHEUS_URI="prometheus-monnitoring"
export PROMETHEUS_NGINX_HOST="${PROMETHEUS_URI}.${PROMETHEUS_ENV}.net"
export PROMETHEUS_NGINX_PORT="80"
export PROMETHEUS_TARGET_HEAP_SIZE="524288000"
export PROMETHEUS_CONFIG_FILE="/etc/prometheus/prometheus.yml"
export PROMETHEUS_STORAGE_ON_SERVER="/prometheus"

# labels:
export PROMETHEUS_SERVICE_TITLE="prometheus_service"

# networks:
export PROMETHEUS_NETWORK_TYPE="bridge"

ls $PROMETHEUS_VOL_DATA
echo $PROMETHEUS_VOL_DATA
