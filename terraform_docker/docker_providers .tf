terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
  required_version = ">= 0.13"
}

# # Configure the Docker provider
# provider "docker" {
#   host = "tcp://127.0.0.1:2376/"
# }

# # Create a container
# resource "docker_container" "prometheus-server-dev" {
#   image = docker_image.ubuntu.latest
# #   namey = "${PROMETHEUS_DOMAIN_NAME}-server-${PROMETHEUS_ENV}"
#   name  = "prometheus-server-dev"
# }

# resource "docker_image" "ubuntu" {
#   name = "ubuntu"
# }

