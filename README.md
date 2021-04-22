# Prometheus Inegration

## Description

What:  | Automated solution for the integration of Prometheus
--|--
Which: | Prometheus, ENV, NGINX
When:  | There is a need for continuous monitoring systems.
Whom:  | DevOps, Developrer, QA Atomation teams.
Where: | Locally or on instance in Docker or on AWS Cloud ENV.
Why:   | Imagine the task when you need to quickly deploy an application.

## Intro & Project philosophy

The main idea was the decision **NOT to take a ready-made solution out of the box** in the form of a ready-made and pre-configured container.
Build your one on your side, but nevertheless do it fully automatic with the possibility of a wide custom configuration.
Or if you intended to make it quick and easy by running one entry-point file.

[Comprehensive guide](https://alexsonar.github.io/en/continuous-processes/monitoring/prometheus_inegration#top)


## Prerequisites

local hosted        | cloud hosted
--------------------|-------------
OS Debian or Ubuntu | IMA credentials
Bash                | Bash
[docker]()          | Terraform 
[docker-compose]()  | 

## Project structure

### Entry-point 
/docker/make_compose_component.sh

### The main executable file on the container side (autostarted)
prometheus/installers/install_base_tools.sh

### (autostarted)
docker/services_availability_tests.sh

## Roadmap

Before you start please:

1. Take a look on roject rerequisites;
2. Take a look on [Docker-compose compatibility doc]();
3. Take a look on /docker/set_env_vars_default.sh you may want to customize many of the variables like ports; environment; labels networks; ext.
(**Caution!** the "volumes" has an inverse relationship in the project components)
4. run /docker/make_compose_component.sh

## Running tests
The theme contains a minimal test suite.

## Discussions
[4 any discussions about the project](https://github.com/AlexSonar/prometheus_inegration/discussions/4#discussion-3320618)


Created by Alex Sonar 2021

#prometheus #docker #docer-compose #debian:buster #nginx #terraform #aws #azure #apt-get #wget #yml