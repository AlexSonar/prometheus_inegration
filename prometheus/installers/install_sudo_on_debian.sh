#!/usr/bin/env bash
#-------------------------------------------------------------
# Automated solution for integrating continuous monitoring systems Prometheus
# Comprehensive guide available at: 
# https://octoops.github.io/en/continuing-processes/monitoring/prometheus/integration/prometheus-integration#top  
#
# This script will be executed on the container side
# By default sudo might not installed on Debian adn return the "-bash: sudo: command not found", but you can install it. 
# First enable su-mode: su -
#
# Copyleft (c) by Alex Sonar 2021
#-------------------------------------------------------------

apt-get update
apt-get install sudo wget curl nano mc htop vi open-ssh net-tools iputils-ping -y
cp /etc/prometheus/installers/.bashrc /root
wget -O /etc/prometheus/installers/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.26.0/prometheus-2.26.0.linux-amd64.tar.gz
mkdir /etc/prometheus/installers/bin/
tar xvfz /etc/prometheus/installers/prometheus*.tar.gz -C /etc/prometheus/installers/bin/

