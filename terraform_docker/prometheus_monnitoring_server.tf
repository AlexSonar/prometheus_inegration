# # Configure the Docker provider
# provider "docker" {
#   host = "tcp://127.0.0.1:2376/"
# }

# Start a container
resource "docker_container" "prometheus-server-dev" {
  name  = "prometheus-server-dev"
  image = docker_image.ubuntu.latest
}

# Find the latest Ubuntu precise image.
resource "docker_image" "ubuntu" {
  name = "ubuntu:precise"
}



# # Create a container
# resource "docker_container" "prometheus-server-dev" {
#   image = docker_image.ubuntu.latest
# #   namey = "${PROMETHEUS_DOMAIN_NAME}-server-${PROMETHEUS_ENV}"
#   name  = "prometheus-server-dev"
# }
